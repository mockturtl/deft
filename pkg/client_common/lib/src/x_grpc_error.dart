import 'dart:io' show HttpStatus, stderr;

import 'package:grpc/grpc.dart' show GrpcError, StatusCode;

/// See [StatusCode._httpStatusToGrpcStatus].
/// https://github.com/grpc/grpc-dart/blob/master/lib/src/shared/status.dart#L132
const _grpcToHttp = <int, int>{
  StatusCode.ok: HttpStatus.ok,
  StatusCode.cancelled: HttpStatus.clientClosedRequest,
  StatusCode.unknown: HttpStatus.internalServerError,
  StatusCode.invalidArgument: HttpStatus.badRequest,
  StatusCode.deadlineExceeded: HttpStatus.gatewayTimeout,
  StatusCode.notFound: HttpStatus.notFound,
  StatusCode.alreadyExists: HttpStatus.conflict,
  StatusCode.permissionDenied: HttpStatus.forbidden,
  StatusCode.resourceExhausted: HttpStatus.tooManyRequests,
  StatusCode.failedPrecondition: HttpStatus.preconditionFailed,
  StatusCode.aborted: HttpStatus.conflict,
  StatusCode.outOfRange: HttpStatus.requestedRangeNotSatisfiable,
  StatusCode.unimplemented: HttpStatus.notImplemented,
  StatusCode.internal: HttpStatus.internalServerError,
  StatusCode.unavailable: HttpStatus.serviceUnavailable,
  StatusCode.dataLoss: HttpStatus.internalServerError,
  StatusCode.unauthenticated: HttpStatus.unauthorized,
};

extension HttpStatusX on GrpcError {
  int get httpStatusEquivalent {
    try {
      return _grpcToHttp[code]!;
    } on Exception catch (e, s) {
      stderr.writeln(
          'ERROR: httpStatusEquivalent: unhandled status $code $codeName - ${e.runtimeType} $e\n$s');
      rethrow;
    }
  }
}
