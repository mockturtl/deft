import 'log_adapter_base.dart';
import 'log_severity.dart';

/// A [LogAdapterBase] where [write] is a no-op.
/// Useful for testing.
class NilLogAdapter extends LogAdapterBase {
  const NilLogAdapter(super.projectId, super.logName);

  @override
  Future<void> write(
      {required String message,
      String? context,
      String tag = '',
      Map<String, dynamic> data = const {},
      Map<String, String>? labels,
      String? requestId,
      Object? error,
      required LogSeverity severity}) async {}
}
