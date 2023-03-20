import 'dart:math';

import 'package:deft_logging/deft_logging.dart';
import 'package:test/test.dart';

void main() {
  late String projectId;
  late String logName;
  late LogAdapterBase subj;
  group('LogAdapterBase', () {
    setUp(() {
      projectId = 'test-proj';
      logName = 'unittest-log';
      subj = TestLogAdapter(projectId, logName);
    });

    group('buildPayload', () {
      group('message', () {
        test('adds an entry', () {
          var it = subj.buildPayload('hello', {}, null);
          expect(it.containsKey('message'), true);
          expect(it['message'], 'hello');
        });
      });

      group('error', () {
        test('adds an entry', () {
          var it = subj.buildPayload('hello', {}, 'oof');
          expect(it.containsKey('error'), true);
          expect(it['error'], 'oof');
        });
      });

      group('data', () {
        late Map<String, dynamic> data;
        setUp(() {
          var tmp = List.generate(Random().nextInt(100), (i) => i);
          data = Map.fromIterable(tmp, key: (j) => '$j');
        });

        test('always contains message', () {
          var it = subj.buildPayload('', {}, null);
          expect(it.length, 1);
          expect(it.containsKey('message'), true);
        });

        test('omits data when empty', () {
          var it = subj.buildPayload('hello', {}, 'oof');
          expect(it.length, 2);
        });

        test('omits error when null', () {
          var it = subj.buildPayload('hello', {}, null);
          expect(it.length, 1);
        });

        test('preserves data', () {
          var it = subj.buildPayload('hello', data, 'oof');
          expect(it.length, 3);
          expect(it.containsKey('data'), true);
          expect(it['data'], data);
        });
      });
    });
  });
}

class TestLogAdapter extends LogAdapterBase {
  TestLogAdapter(super.projectId, super.logName);

  @override
  Future<void> write(
      {required String message,
      String? context,
      String tag = '',
      Map<String, dynamic> data = const {},
      Map<String, String>? labels,
      Object? error,
      String? requestId,
      required LogSeverity severity}) async {}
}
