import 'package:grpc/grpc.dart'
    show
        ChannelCredentials,
        ChannelOptions,
        ClientChannel,
        Codec,
        CodecRegistry,
        GzipCodec,
        IdentityCodec;

/// Builds [ChannelOptions] suitable for a [ClientChannel].
///
/// The value of [credentials]
/// - MAY use [ChannelCredentials.insecure] when targeting a local server instance.
/// - MUST use [ChannelCredentials.secure] when targeting a remote server instance.
///
/// The 'user-agent' request header will indicate the [grpcVersion].
/// See <https://github.com/grpc/grpc/blob/master/doc/PROTOCOL-HTTP2.md#user-agents>.
/// It SHOULD match the version of the caller's `package:grpc` dependency, like `'3.1.0'`.
///
/// Callers MAY specify their own package version, user device info, etc. in [userAgentFragments].
/// They will be appended to the user-agent string as specified in the link above.
///
/// ```dart
///    ['foo', 'bar/v1', 'baz'] => 'grpc-dart/$grpcVersion (foo; bar/v1; baz)'
/// ```
ChannelOptions chanOpts(ChannelCredentials credentials, String grpcVersion,
        {List<Codec> codecs = const [GzipCodec(), IdentityCodec()],
        List<String> userAgentFragments = const []}) =>
    ChannelOptions(
        credentials: credentials,
        codecRegistry: CodecRegistry(codecs: codecs),
        userAgent: _ua(grpcVersion, userAgentFragments));

String _ua(String grpcVersion, [List<String> fragments = const []]) {
  var out = StringBuffer('grpc-dart/$grpcVersion');
  if (fragments.isNotEmpty) {
    out
      ..write(' (')
      ..writeAll(fragments, '; ')
      ..write(')');
  }
  return '$out';
}
