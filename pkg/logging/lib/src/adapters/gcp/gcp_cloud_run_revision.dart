import 'dart:io';

import 'package:googleapis/logging/v2.dart' show LogEntry, MonitoredResource;

class GcpCloudRunRevision {
  static const _type = 'cloud_run_revision';
  static const _unknown = 'unknown';

  final String projectId;
  final String gcpRegion;

  /// Populates the `resource` field of a [LogEntry].
  ///
  /// Your Cloud Run instance can obtain these values at runtime from the
  /// metadata server.
  ///
  /// See
  /// - <https://cloud.google.com/run/docs/container-contract#services-env-vars>
  /// - <https://cloud.google.com/run/docs/container-contract#metadata-server>
  ///
  /// Note a value for [gcpRegion] like `'projects/$PROJECT_ID/regions/$REGION'`
  /// is parsed to `'$REGION'`.
  const GcpCloudRunRevision(this.projectId, this.gcpRegion);

  String get _configurationName =>
      Platform.environment['K_CONFIGURATION'] ?? _unknown;

  String get _location => gcpRegion.split('/').last;

  String get _revisionName => Platform.environment['K_REVISION'] ?? _unknown;

  String get _serviceName => Platform.environment['K_SERVICE'] ?? _unknown;

  /// Builds a [MonitoredResource] using Cloud Run environment variables.
  MonitoredResource toMonitoredResource() =>
      MonitoredResource(type: _type, labels: {
        'configuration_name': _configurationName,
        'location': _location,
        'project_id': projectId,
        'revision_name': _revisionName,
        'service_name': _serviceName,
      });
}
