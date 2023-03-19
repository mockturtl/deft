import 'adapters/log_adapter_base.dart';
import 'x_service_call.dart';

/// GCP's frontend has an automatic request logger named
/// `'projects/$PROJECT_ID/logs/run.googleapis.com%2Frequests'`.
///
/// It assigns a unique id for each request in the 'x-cloud-trace-context' header.
/// This value appears in Logs Explorer as `'trace'`.
///
/// See <https://cloud.google.com/trace/docs/setup#force-trace>.
///
/// The header is available to pass to your own logs.
/// See [RequestHeadersX.xCloudTraceContext], [LogAdapterBase.write].
class CloudTraceContext {
  final String trace;
  final bool sampled;

  factory CloudTraceContext(String headerValue) {
    var parts = headerValue.split(';');
    return CloudTraceContext._(parts.first, parts.last == 'o=1');
  }

  const CloudTraceContext._(this.trace, this.sampled);

  String asLogEntry(String projectId) => 'projects/$projectId/traces/$trace';
}
