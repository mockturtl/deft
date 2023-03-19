import 'dart:async';

import 'package:grpc/grpc.dart' show ClientChannel, ServiceAccountAuthenticator;
import 'package:meta/meta.dart';

import '../api.g.dart'
    show
        LogEntry,
        LogEntrySourceLocation,
        LogSeverity,
        LoggingServiceV2Client,
        MonitoredResource,
        Struct,
        Value,
        WriteLogEntriesRequest;
import '../cloud_run_revision.dart';
import '../cloud_trace_context.dart';
import 'gcp_log_service_adapter.dart';
import 'log_adapter_base.dart';

/// See [GcpLogServiceAdapter].
@Deprecated('This file\'s dependencies are compiled from `vendor/`.'
    ' Prefer [GcpApiLogServiceAdapter], which uses package:googleapis/logging.')
class DiyGcpLogServiceAdapter extends LogAdapterBase {
  static const _host = 'logging.googleapis.com';
  static const _scopes = [
    'https://www.googleapis.com/auth/cloud-platform',
    'https://www.googleapis.com/auth/logging.write',
  ];

  final ServiceAccountAuthenticator _auth;
  final String instanceId;
  late final LoggingServiceV2Client _stub;
  late final MonitoredResource _resource;

  /// The [serviceAccountKey] is a key for a GCP service account
  /// (APIs & Services -> Credentials -> Service Account).
  /// It must have "Logs Writer" role.
  @Deprecated('Prefer [GcpApiLogServiceAdapter.new].'
      ' This class works, but the upkeep is a bad idea.')
  DiyGcpLogServiceAdapter(
      super.projectId, super.logName, String region, this.instanceId,
      {required String serviceAccountKey})
      : _auth = ServiceAccountAuthenticator(serviceAccountKey, _scopes) {
    _stub = LoggingServiceV2Client(ClientChannel(_host),
        options: _auth.toCallOptions);
    _resource = CloudRunRevision(projectId, region).toOldMonitoredResource();
  }

  // FIXME: test
  @visibleForTesting
  Value valueFor(Object? e) {
    // if (e == null) return Value();
    if (e is String) return Value(stringValue: e);
    // FIXME: int?
    // if (e is double) return Value(numberValue: e);
    // if (e is bool) return Value(boolValue: e);
    // if (e is List) {
    //   return Value(listValue: ListValue(values: e.map(_valueFor)));
    // }
    // if (e is Map) {
    //   return Value(
    //       structValue:
    //           Struct(fields: {for (var x in e.entries) x.key: _valueFor(e)}));
    // }
    return Value(stringValue: '$e');
  }

  /// {@macro log_adapter.write}
  @override
  Future<void> write(
      {required String message,
      String? context,
      String tag = '',
      Map<String, dynamic> data = const {},
      Map<String, String>? labels,
      Object? error,
      String? requestId,
      required LogSeverity severity}) async {
    var payload = buildPayload(message, data, error);
    var entry = LogEntry(
        logName: 'projects/$projectId/logs/$logName',
        severity: severity,
        resource: _resource,
        labels: {'instanceId': instanceId}..addAll(labels ?? {}),
        sourceLocation: LogEntrySourceLocation(file: tag, function: context),
        jsonPayload: Struct(
            fields: {for (var e in payload.entries) e.key: valueFor(e.value)}));

    if (requestId != null) {
      var t = CloudTraceContext(requestId);
      entry
        ..trace = t.asLogEntry(projectId)
        ..traceSampled = t.sampled;
    }

    var req = WriteLogEntriesRequest(entries: [entry]);
    await _stub.writeLogEntries(req);
  }
}
