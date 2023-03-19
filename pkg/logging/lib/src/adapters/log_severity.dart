//ignore_for_file: constant_identifier_names

/// See <https://cloud.google.com/logging/docs/reference/v2/rest/v2/LogEntry#logseverity>.
enum LogSeverity {
  /// The log entry has no assigned severity level.
  DEFAULT._(0),

  /// Debug or trace information.
  DEBUG._(100),

  /// Routine information, such as ongoing status or performance.
  INFO._(200),

  /// Normal but significant events, such as start up, shut down, or a configuration change.
  NOTICE._(300),

  /// Warning events might cause problems.
  WARNING._(400),

  /// Error events are likely to cause problems.
  ERROR._(500),

  /// Critical events cause more severe problems or outages.
  CRITICAL._(600),

  /// A person must take an action immediately.
  ALERT._(700),

  /// One or more systems are unusable.
  EMERGENCY._(800);

  final int value;

  const LogSeverity._(this.value);

  @override
  String toString() => name;
}
