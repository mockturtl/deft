import 'dart:async';

import 'package:googleapis/logging/v2.dart' show LogEntry;

import 'adapters/log_adapter_base.dart';
import 'adapters/log_severity.dart';

class LoggingService {
  final Iterable<LogAdapterBase> _adapters;

  const LoggingService(this._adapters);

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.ALERT].
  /// This level is more severe than [LoggingService.critical], but less severe than [emergency].
  /// {@template error_log_latency}
  /// Consider `await`ing this [Future] to ensure ordered messages in the error log.
  /// {@endtemplate}
  Future<void> alert(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels,
          required Object error}) async =>
      Future.wait(_adapters.map((e) => e.alert(
          context, message, data, labels, error, tag,
          requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.CRITICAL].
  /// This level is more severe than [LoggingService.error], but less severe than [alert].
  /// {@template error_log_latency}
  /// Consider `await`ing this [Future] to ensure ordered messages in the error log.
  /// {@endtemplate}
  Future<void> critical(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels,
          required Object error}) async =>
      Future.wait(_adapters.map((e) => e.critical(
          context, message, data, labels, error, tag,
          requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.DEBUG].
  /// This level is higher than [LoggingService.log], but less than [info].
  /// {@template log_latency}
  /// Prefer wrapping this call with [unawaited], since it could add significant latency.
  /// {@endtemplate}
  Future<void> debug(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels}) async =>
      Future.wait(_adapters.map((e) =>
          e.debug(context, message, data, labels, tag, requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.EMERGENCY].
  /// This is the maximum level.
  /// {@template error_log_latency}
  /// Consider `await`ing this [Future] to ensure ordered messages in the error log.
  /// {@endtemplate}
  Future<void> emergency(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels,
          required Object error}) async =>
      Future.wait(_adapters.map((e) => e.emergency(
          context, message, data, labels, error, tag,
          requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.ERROR].
  /// This level is higher than [LoggingService.warn], but less than [critical].
  /// An [error] value is required.
  /// {@template error_log_latency}
  /// Consider `await`ing this [Future] to ensure ordered messages in the error log.
  /// {@endtemplate}
  Future<void> error(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels,
          required Object error}) async =>
      Future.wait(_adapters.map((e) => e.error(
          context, message, data, labels, error, tag,
          requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.INFO].
  /// This level is higher than [LoggingService.debug], but less than [notice].
  /// {@macro log_latency}
  Future<void> info(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels}) async =>
      Future.wait(_adapters.map((e) =>
          e.info(context, message, data, labels, tag, requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.DEFAULT].
  /// This is the minimum level.
  /// {@macro log_latency}
  Future<void> log(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels}) async =>
      Future.wait(_adapters.map((e) =>
          e.log(context, message, data, labels, tag, requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.NOTICE].
  /// This level is higher than [LoggingService.info], but less than [warn].
  /// An [error] value is optional.
  /// {@macro log_latency}
  Future<void> notice(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels,
          Object? error}) async =>
      Future.wait(_adapters.map((e) => e.notice(
          context, message, data, labels, error, tag,
          requestId: requestId)));

  /// Write a structured [LogEntry] to all [_adapters] with [LogSeverity.WARNING].
  /// This level is higher than [LoggingService.notice], but less than [LoggingService.error].
  /// An [error] value is optional.
  /// {@macro error_log_latency}
  Future<void> warn(String message, String tag,
          {String? context,
          Map<String, dynamic> data = const {},
          String? requestId,
          Map<String, String>? labels,
          Object? error}) async =>
      Future.wait(_adapters.map((e) => e.warn(
          context, message, data, labels, error, tag,
          requestId: requestId)));
}
