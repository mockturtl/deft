import 'dart:async';
import 'dart:io';

import 'package:grpc/service_api.dart';
import 'package:protobuf/protobuf.dart';

class ConsoleLogMiddleware extends ClientInterceptor {
  final bool quiet;

  ConsoleLogMiddleware({this.quiet = false});

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    if (!quiet) stdout.writeln('-> ${method.path} ${_toString(request)}');
    return invoker(method, request, options);
  }

  @override
  Future<R> interceptUnaryResponse<Q, R>(
      ClientMethod<Q, R> method, Q request, Future<R> response) async {
    var out = await response;
    if (!quiet) stdout.writeln('<- ${method.path} ${_toString(out)}');
    return out;
  }

  String _toString<R>(R message) => message is GeneratedMessage
      ? '${message.runtimeType} ${message.writeToJsonMap()}'
      : '$message';
}
