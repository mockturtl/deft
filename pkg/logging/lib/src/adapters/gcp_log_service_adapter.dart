import 'dart:convert';

import 'package:googleapis/logging/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

import 'gcp/gcp_cloud_run_revision.dart';
import 'gcp/gcp_cloud_trace_context.dart';
import 'log_adapter_base.dart';
import 'log_severity.dart';
import 'posix_log_adapter.dart';

/// Writes structured logs (JSON) to GCP Cloud Logging.
///
/// Note [PosixLogAdapter] is sufficient for Cloud Run services.
/// See <https://cloud.google.com/logging/docs/agent-or-library>.
class GcpLogServiceAdapter extends LogAdapterBase {
  static const scopes = [
    LoggingApi.cloudPlatformScope, // FIXME: omit?
    LoggingApi.loggingWriteScope,
  ];

  final String instanceId;
  final LoggingApi _api;

  late final MonitoredResource _resource;

  GcpLogServiceAdapter(String projectId, String logName, String region,
      this.instanceId, AuthClient client)
      : _api = LoggingApi(client),
        super(projectId, 'projects/$projectId/logs/$logName') {
    _resource = GcpCloudRunRevision(projectId, region).toMonitoredResource();
  }

  @override
  Future<void> write(
      {required String message,
      String? context,
      String tag = '',
      Map<String, dynamic> data = const {},
      Map<String, String>? labels,
      String? requestId,
      Object? error,
      required LogSeverity severity}) async {
    var payload = buildPayload(message, data, error);
    var entry = LogEntry(
        logName: logName,
        severity: severity.name,
        resource: _resource,
        labels: {'instanceId': instanceId}..addAll(labels ?? {}),
        sourceLocation: LogEntrySourceLocation(file: tag, function: context),
        jsonPayload: payload);

    _tryAddTrace(requestId, entry);

    try {
      var req = WriteLogEntriesRequest(entries: [entry]);
      await _api.entries.write(req);
    }
    //ignore: avoid_catching_errors
    on JsonUnsupportedObjectError catch (e) {
      await _handleRequestEncodeFailure(
          e, severity.name, data, message, context, requestId, labels, tag);
    }
  }

  /// If [EntriesResource.write] throws an error serializing your data, record it.
  Future<void> _handleRequestEncodeFailure(
      Error e,
      String originalSeverity,
      Map<String, dynamic> data,
      String originalMessage,
      String? originalContext,
      String? requestId,
      Map<String, String>? labels,
      String originalTag) async {
    const errLabel =
        'package:deft_logging/GcpLogServiceAdapter:_handleRequestEncodeFailure';
    const severity = LogSeverity.ALERT;

    var alert = LogEntry(
        logName: logName,
        severity: severity.name,
        resource: _resource,
        labels: {'instanceId': instanceId, 'deft_error': errLabel}
          ..addAll(labels ?? {}),
        sourceLocation: LogEntrySourceLocation(
            file: originalTag, function: originalContext),
        jsonPayload: buildPayload(
            'LoggingApi write failed: \'data\' is not encodable as JSON. Check your field values.'
            '\nhttps://pub.dev/documentation/googleapis/latest/logging.v2/LogEntry/jsonPayload.html'
            '\nhttps://api.dart.dev/stable/dart-convert/jsonEncode.html',
            {
              'original_severity': originalSeverity,
              'original_message': originalMessage,
              'bad_data_as_string': '$data',
            },
            e));

    _tryAddTrace(requestId, alert);

    var req = WriteLogEntriesRequest(entries: [alert]);
    await _api.entries.write(req);
  }

  void _tryAddTrace(String? requestId, LogEntry entry) {
    if (requestId == null) return;
    var t = GcpCloudTraceContext(requestId);
    entry
      ..trace = t.asLogEntry(projectId)
      ..traceSampled = t.sampled;
  }
}
