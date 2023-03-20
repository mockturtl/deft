import 'package:grpc/service_api.dart' show ServiceCall;

extension RequestHeadersX on ServiceCall {
  /// Potentially a token, like `'bearer ...'`.
  String? get authorization => clientMetadata?['authorization'];

  /// Note this header value will fail [int.parse], due to a trailing letter `'m'`.
  String? get grpcTimeoutMillis => clientMetadata?['grpc-timeout'];

  /// The hostname and port.
  String? get urlAuthority => clientMetadata?[':authority'];

  /// Normally `'POST'`.
  String? get urlMethod => clientMetadata?[':method'];

  String? get urlPath => clientMetadata?[':path'];

  /// Normally `'http'` inside of Cloud Run (SSL terminates at the load balancer).
  String? get urlScheme => clientMetadata?[':scheme'];

  /// Like `'grpc-dart/3.1.0 (my_client/1.2.3)'`.
  String? get userAgent => clientMetadata?['user-agent'];

  String? get xCloudTraceContext => clientMetadata?['x-cloud-trace-context'];
}
