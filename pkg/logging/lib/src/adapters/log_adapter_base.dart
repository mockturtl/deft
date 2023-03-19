import 'dart:convert';

import 'package:googleapis/logging/v2.dart';
import 'package:grpc/service_api.dart' show ServiceCall;
import 'package:meta/meta.dart';

import '../api.g.dart' show LogSeverity;

abstract class LogAdapterBase {
  final String projectId;
  final String logName;

  const LogAdapterBase(this.projectId, this.logName);

  /// FIXME: stack trace
  /// Write a structured [LogEntry] with [LogSeverity.ALERT].
  /// {@macro error_required}
  Future<void> alert(String? context, String message, Map<String, dynamic> data,
          Map<String, String>? labels, Object error, String tag,
          {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          tag: tag,
          labels: labels,
          error: error,
          requestId: requestId,
          severity: LogSeverity.ALERT);

  /// Assemble [context], [tag] for [LogEntry.labels].
  @visibleForTesting
  @protected
  Map<String, String>? buildLabels(String? context, String tag) {
    if (context == null || context.isEmpty) {
      return (tag.isEmpty) ? null : {'tag': tag};
    }

    return (tag.isEmpty)
        ? {'context': context}
        : {'context': context, 'tag': tag};
  }

  /// Assemble [message], [data], [error] for [LogEntry.jsonPayload].
  /// **Note:** [data] keys `message` and `error` are **reserved**.
  @visibleForTesting
  @protected
  Map<String, dynamic> buildPayload(
          String message, Map<String, dynamic> data, Object? error) =>
      {'message': message, 'data': data, if (error != null) 'error': '$error'};

  /// FIXME: stack trace
  /// Write a structured [LogEntry] with [LogSeverity.CRITICAL].
  /// {@macro error_required}
  Future<void> critical(
          String? context,
          String message,
          Map<String, dynamic> data,
          Map<String, String>? labels,
          Object error,
          String tag,
          {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          labels: labels,
          tag: tag,
          error: error,
          requestId: requestId,
          severity: LogSeverity.CRITICAL);

  /// Write a structured [LogEntry] with [LogSeverity.DEBUG].
  Future<void> debug(String? context, String message, Map<String, dynamic> data,
          Map<String, String>? labels, String tag, {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          labels: labels,
          tag: tag,
          requestId: requestId,
          severity: LogSeverity.DEBUG);

  /// FIXME: stack trace
  /// Write a structured [LogEntry] with [LogSeverity.EMERGENCY].
  /// {@macro error_required}
  Future<void> emergency(
          String? context,
          String message,
          Map<String, dynamic> data,
          Map<String, String>? labels,
          Object error,
          String tag,
          {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          tag: tag,
          labels: labels,
          error: error,
          requestId: requestId,
          severity: LogSeverity.EMERGENCY);

  /// FIXME: stack trace
  /// Write a structured [LogEntry] with [LogSeverity.ERROR].
  /// {@template error_required}
  /// Note [error] is required.
  /// {@endtemplate}
  Future<void> error(String? context, String message, Map<String, dynamic> data,
          Map<String, String>? labels, Object error, String tag,
          {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          tag: tag,
          labels: labels,
          error: error,
          requestId: requestId,
          severity: LogSeverity.ERROR);

  /// Write a structured [LogEntry] with [LogSeverity.INFO].
  Future<void> info(String? context, String message, Map<String, dynamic> data,
          Map<String, String>? labels, String tag, {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          labels: labels,
          tag: tag,
          requestId: requestId,
          severity: LogSeverity.INFO);

  /// Write a structured [LogEntry] with [LogSeverity.DEFAULT].
  Future<void> log(String? context, String message, Map<String, dynamic> data,
          Map<String, String>? labels, String tag, {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          labels: labels,
          tag: tag,
          requestId: requestId,
          severity: LogSeverity.DEFAULT);

  /// FIXME: stack trace
  /// Write a structured [LogEntry] with [LogSeverity.NOTICE].
  /// {@macro error_optional}
  Future<void> notice(
          String? context,
          String message,
          Map<String, dynamic> data,
          Map<String, String>? labels,
          Object? error,
          String tag,
          {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          labels: labels,
          tag: tag,
          error: error,
          requestId: requestId,
          severity: LogSeverity.NOTICE);

  /// FIXME: stack trace
  /// Write a structured [LogEntry] with [LogSeverity.WARNING].
  /// {@template error_optional}
  /// Note [error] is optional.
  /// {@endtemplate}
  /// Note [error] is optional.
  Future<void> warn(String? context, String message, Map<String, dynamic> data,
          Map<String, String>? labels, Object? error, String tag,
          {String? requestId}) async =>
      write(
          message: message,
          context: context,
          data: data,
          tag: tag,
          labels: labels,
          error: error,
          requestId: requestId,
          severity: LogSeverity.WARNING);

  /// {@template log_adapter.write}
  /// For better filtering of log entries with structured data,
  /// prefer static text in [message], and variable values in [data].
  ///
  /// Note [data] values **MUST** be compatible with [jsonEncode].
  ///
  /// The keys `"message"` and `"error"` are **reserved** by [buildPayload].
  ///
  /// Consider providing a Dart library or file name as [tag], and a class method as [context].
  /// These will populate [LogEntrySourceLocation.file], [LogEntrySourceLocation.function] respectively.
  /// To tag log lines in Logs Explorer, right-click an entry -> "Add field to summary line."
  ///
  /// A [requestId] ("trace") is available in the request headers, via [ServiceCall.clientMetadata].
  /// See <https://cloud.google.com/trace/docs/setup#force-trace>.
  /// {@endtemplate}
  @visibleForOverriding
  Future<void> write(
      {required String message,
      String? context,
      String tag = '',
      Map<String, dynamic> data = const {},
      Map<String, String>? labels,
      String? requestId,
      Object? error,
      required LogSeverity severity});
}
