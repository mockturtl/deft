import 'dart:math';

import 'package:deft_logging/deft_logging.dart';
import 'package:deft_logging/src/api.g.dart';

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

        test('only adds entries for message and error', () {
          var it = subj.buildPayload('hello', {}, 'oof');
          expect(it.length, 2);
        });

        test('error is omitted when null', () {
          var it = subj.buildPayload('hello', {}, null);
          expect(it.length, 1);
        });

        test('message is omitted when empty', () {
          var it = subj.buildPayload('', {}, 'oof');
          expect(it.length, 1);
        });

        test('returns empty map with no message, error, or data', () {
          var it = subj.buildPayload('', {}, null);
          expect(it.isEmpty, true);
        });

        test('preserves existing entries', () {
          var it = subj.buildPayload('hello', data, 'oof');
          expect(it.length, data.length + 2);
          for (var k in data.keys) {
            expect(it.keys.contains(k), true);
          }
          for (var v in data.values) {
            expect(it.values.contains(v), true);
          }
        });

        group('reserved keys', () {
          test('overwrite an existing entry for "message"', () {
            var it = subj.buildPayload(
                'hello', data..addAll({'message': 'gone'}), 'oof');
            expect(it['message'], 'hello');
          });

          test('overwrite an existing entry for "error"', () {
            var it = subj.buildPayload(
                'hello', data..addAll({'error': 'gone'}), 'oof');
            expect(it['error'], 'oof');
          });
        });
      });
    });

    group('buildLabels', () {
      test('is null with null context and empty tag', () {
        expect(subj.buildLabels(null, ''), isNull);
      });

      test('has 1 entry with null context', () {
        var it = subj.buildLabels(null, 'some-tag');
        expect(it?.length, 1);
        expect(it?.keys.single, 'tag');
        expect(it?.values.single, 'some-tag');
      });

      test('has 1 entry with empty tag', () {
        var it = subj.buildLabels('some-context', '');
        expect(it?.length, 1);
        expect(it?.keys.single, 'context');
        expect(it?.values.single, 'some-context');
      });

      test('has 2 entries', () {
        var it = subj.buildLabels('some-context', 'some-tag');
        expect(it?.length, 2);
        var e1 = it?.entries.first;
        expect(e1?.key, 'context');
        expect(e1?.value, 'some-context');
        var e2 = it?.entries.last;
        expect(e2?.key, 'tag');
        expect(e2?.value, 'some-tag');
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
