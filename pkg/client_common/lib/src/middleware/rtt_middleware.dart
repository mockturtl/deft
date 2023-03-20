import 'dart:async';
import 'dart:io';

import 'package:grpc/service_api.dart';

class RttMiddleware extends ClientInterceptor {
  final bool quiet;
  DateTime? _stopwatch;

  RttMiddleware({this.quiet = false});

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    if (!quiet) _stopwatch = DateTime.now();
    return invoker(method, request, options);
  }

  @override
  Future<R> interceptUnaryResponse<Q, R>(
      ClientMethod<Q, R> method, Q request, Future<R> response) async {
    var out = await response;
    if (!quiet && _stopwatch != null) {
      stdout.writeln(
          'rtt: ${DateTime.now().difference(_stopwatch!).inMilliseconds} ms');
    }
    return out;
  }
}
