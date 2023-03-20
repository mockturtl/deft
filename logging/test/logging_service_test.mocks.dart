// Mocks generated by Mockito 5.3.2 from annotations
// in deft_logging/test/logging_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:deft_logging/src/adapters/log_adapter_base.dart' as _i2;
import 'package:deft_logging/src/adapters/log_severity.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [LogAdapterBase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLogAdapterBase extends _i1.Mock implements _i2.LogAdapterBase {
  MockLogAdapterBase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get projectId => (super.noSuchMethod(
        Invocation.getter(#projectId),
        returnValue: '',
      ) as String);
  @override
  String get logName => (super.noSuchMethod(
        Invocation.getter(#logName),
        returnValue: '',
      ) as String);
  @override
  _i3.Future<void> alert(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    Object? error,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #alert,
          [
            context,
            message,
            data,
            labels,
            error,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  Map<String, dynamic> buildPayload(
    String? message,
    Map<String, dynamic>? data,
    Object? error,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #buildPayload,
          [
            message,
            data,
            error,
          ],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  _i3.Future<void> critical(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    Object? error,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #critical,
          [
            context,
            message,
            data,
            labels,
            error,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> debug(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #debug,
          [
            context,
            message,
            data,
            labels,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> emergency(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    Object? error,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #emergency,
          [
            context,
            message,
            data,
            labels,
            error,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> error(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    Object? error,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #error,
          [
            context,
            message,
            data,
            labels,
            error,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> info(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #info,
          [
            context,
            message,
            data,
            labels,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> log(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #log,
          [
            context,
            message,
            data,
            labels,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> notice(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    Object? error,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #notice,
          [
            context,
            message,
            data,
            labels,
            error,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> warn(
    String? context,
    String? message,
    Map<String, dynamic>? data,
    Map<String, String>? labels,
    Object? error,
    String? tag, {
    String? requestId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #warn,
          [
            context,
            message,
            data,
            labels,
            error,
            tag,
          ],
          {#requestId: requestId},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> write({
    required String? message,
    String? context,
    String? tag = r'',
    Map<String, dynamic>? data = const {},
    Map<String, String>? labels,
    String? requestId,
    Object? error,
    required _i4.LogSeverity? severity,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #write,
          [],
          {
            #message: message,
            #context: context,
            #tag: tag,
            #data: data,
            #labels: labels,
            #requestId: requestId,
            #error: error,
            #severity: severity,
          },
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}