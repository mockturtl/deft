import 'dart:async';

import 'package:grpc/grpc.dart' show ResponseFuture;
import 'package:mockito/mockito.dart';

/// https://github.com/google/protobuf.dart/issues/162#issuecomment-451737266
class MockResponseFuture<T> extends Mock implements ResponseFuture<T> {
  final Future<T> future;

  MockResponseFuture(this.future);

  MockResponseFuture.error(Object error) : future = Future.error(error);

  MockResponseFuture.value(T value) : future = Future.value(value);

  @override
  Future<S> then<S>(FutureOr<S> Function(T value) onValue,
          {Function? onError}) =>
      future.then(onValue, onError: onError);
}
