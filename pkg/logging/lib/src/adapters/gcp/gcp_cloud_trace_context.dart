import '../log_adapter_base.dart';
import '../../x_service_call.dart';

/// Cloud Run automatically logs incoming requests.
/// They appear in Logs Explorer with a `logName` of
/// `"projects/$PROJECT_ID/logs/run.googleapis.com%2Frequests"`.
///
/// Each request is assigned a unique id, in the 'x-cloud-trace-context' header.
/// This value appears in Logs Explorer as `trace`.
///
/// Read more: <https://cloud.google.com/trace/docs/setup#force-trace>.
///
/// You can pass the header value to your own logs by passing
/// [RequestHeadersX.xCloudTraceContext] as the `requestId` in [LogAdapterBase.write].
class GcpCloudTraceContext {
  final String trace;
  final bool sampled;

  factory GcpCloudTraceContext(String headerValue) {
    var parts = headerValue.split(';');
    return GcpCloudTraceContext._(parts.first, parts.last == 'o=1');
  }

  const GcpCloudTraceContext._(this.trace, this.sampled);

  String asLogEntry(String projectId) => 'projects/$projectId/traces/$trace';
}
