import 'dart:math';

import 'package:grpc/service_api.dart';

/// https://cloud.google.com/trace/docs/setup#force-trace
class TraceMiddleware extends ClientInterceptor {
  static const _header = 'x-cloud-trace-context';

  final _rnd = Random();

  /// The header value will indicate whether to trace this request.
  final bool enabled;

  /// Unique value within a trace.  Pass a parent request's [spanId] to its child requests.
  final int spanId;

  TraceMiddleware({this.spanId = 1, this.enabled = true});

  int get _enabled => enabled ? 1 : 0;

  /// Unique 32-character hexadecimal value.
  String get _traceId {
    var out = StringBuffer();
    for (var i = 0; i < 32; i++) {
      out.write(_rnd.nextInt(16).toRadixString(16));
    }
    return '$out';
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
          CallOptions options, ClientUnaryInvoker<Q, R> invoker) =>
      invoker(
          method,
          request,
          options.mergedWith(CallOptions(
              metadata: {_header: '$_traceId/$spanId;o=$_enabled'})));
}
