import 'package:deft_client_common/src/x_grpc_error.dart';
import 'package:grpc/grpc.dart';
import 'package:test/test.dart';

void main() {
  late GrpcError subj;
  group('httpStatusEquivalent', () {
    test('notFound', () {
      subj = GrpcError.notFound();
      expect(subj.httpStatusEquivalent, 404);
    });
  });
}
