import 'package:deft_logging/deft_logging.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/scaffolding.dart';

import 'logging_service_test.mocks.dart';

@GenerateMocks([LogAdapterBase])
void main() {
  group('LoggingService', () {
    late List<LogAdapterBase> adapters;
    late LoggingService subj;
    late Map<String, dynamic> data;
    setUp(() async {
      adapters = [MockLogAdapterBase(), MockLogAdapterBase()];
      subj = LoggingService(adapters);
      data = {'a': 1, 'b': 2, 'c': 3};
    });

    group('forwards to adapters', () {
      test('log', () async {
        await subj.log('hello', data: data, context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.log('my-test', 'hello', data, null, 'my-tag')).called(1);
        }
      });

      test('debug', () async {
        await subj.debug('hello', data: data, context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.debug('my-test', 'hello', data, null, 'my-tag')).called(1);
        }
      });

      test('info', () async {
        await subj.info('hello', data: data, context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.info('my-test', 'hello', data, null, 'my-tag')).called(1);
        }
      });

      test('notice', () async {
        await subj.notice(
            'hello', data: data, error: 'oops', context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.notice('my-test', 'hello', data, null, 'oops', 'my-tag'))
              .called(1);
        }
      });

      test('warning', () async {
        await subj.warn(
            'hello', data: data, error: 'oops', context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.warn('my-test', 'hello', data, null, 'oops', 'my-tag'))
              .called(1);
        }
      });

      test('error', () async {
        await subj.error(
            'hello', data: data, error: 'oof', context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.error('my-test', 'hello', data, null, 'oof', 'my-tag'))
              .called(1);
        }
      });

      test('critical', () async {
        await subj.critical(
            'hello', data: data, error: 'oof', context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.critical('my-test', 'hello', data, null, 'oof', 'my-tag'))
              .called(1);
        }
      });

      test('alert', () async {
        await subj.alert(
            'hello', data: data, error: 'oof', context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.alert('my-test', 'hello', data, null, 'oof', 'my-tag'))
              .called(1);
        }
      });

      test('emergency', () async {
        await subj.emergency(
            'hello', data: data, error: 'oof', context: 'my-test', 'my-tag');
        for (var ad in adapters) {
          verify(ad.emergency('my-test', 'hello', data, null, 'oof', 'my-tag'))
              .called(1);
        }
      });
    });
  });
}
