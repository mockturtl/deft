import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stream.mocks.dart';

export 'stream.mocks.dart';

@GenerateMocks([Stream])
MockStream<T> prepareStream<T>(Iterable<T> states) {
  var stream = MockStream<T>();
  when(stream.listen(any,
          onError: anyNamed('onError'), onDone: anyNamed('onDone')))
      .thenAnswer((inv) =>
          Stream.fromIterable(states).listen(inv.positionalArguments.first));
  return stream;
}
