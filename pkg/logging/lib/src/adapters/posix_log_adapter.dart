//ignore_for_file: close_sinks
import 'dart:convert';
import 'dart:io';

import 'gcp_log_service_adapter.dart';
import 'log_adapter_base.dart';
import 'log_severity.dart';
import 'print_log_adapter.dart';

/// Writes structured logs (JSON) to [stdout] or [stderr], depending on [LogSeverity].
///
/// - Uses [stdout] for [LogSeverity.NOTICE] or lower.
/// - Uses [stderr] for [LogSeverity.WARNING] or higher.
///
/// Note Cloud Run automatically sends these streams to Cloud Logging
/// without additional configuration.
///
/// For plaintext logging, see [PrintLogAdapter].
/// For custom configuration, see [GcpLogServiceAdapter].
class PosixLogAdapter extends LogAdapterBase {
  final String? instanceId;

  const PosixLogAdapter(super.projectId, super.logName, this.instanceId);

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
    var map = {
      'logName': 'projects/$projectId/logs/$logName',
      'severity': severity.name,
      'sourceLocation': {'file': tag, 'function': context},
      'trace': requestId,
      'jsonPayload': buildPayload(message, data, error),
      'labels': (labels ?? {})..addAll({'instanceId': instanceId ?? 'n/a'}),
    };

    var sink = _getSink(severity)..writeln(jsonEncode(map));
    // FIXME: threadsafe?
    await sink.flush();
  }

  IOSink _getSink(LogSeverity severity) =>
      (severity.value >= LogSeverity.WARNING.value) ? stderr : stdout;
}
