import '../api.g.dart';
import 'log_adapter_base.dart';

/// Writes plaintext logs using [print].
class PrintLogAdapter extends LogAdapterBase {
  const PrintLogAdapter(super.projectId, super.logName);

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
    var now = DateTime.now().toUtc();
    var sb = StringBuffer()
      ..write('${severity.name} ${now.toIso8601String()} [$tag]');
    if (context != null && context.isNotEmpty) sb.write(' $context:');
    if (message.isNotEmpty) sb.write(' $message');
    if (data.isNotEmpty) sb.write(' data=$data');
    if (labels?.isNotEmpty ?? false) sb.write(' ($labels)');
    if (requestId?.isNotEmpty ?? false) sb.write(' <$requestId>');
    if (error != null) sb.write('\n$error');

    // ignore: avoid_print
    print('$sb');
  }
}
