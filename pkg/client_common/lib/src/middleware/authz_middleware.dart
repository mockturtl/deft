import 'dart:io';

import 'package:grpc/service_api.dart';

class AuthzMiddleware extends ClientInterceptor {
  final String token;

  AuthzMiddleware(this.token);

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
          CallOptions options, ClientUnaryInvoker<Q, R> invoker) =>
      invoker(
          method,
          request,
          options.mergedWith(CallOptions(
              metadata: {HttpHeaders.authorizationHeader: 'bearer $token'})));
}
