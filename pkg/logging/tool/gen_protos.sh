#!/usr/bin/env bash
set -euxo pipefail

# Lifted from https://github.com/grpc/grpc-dart/tree/master/example/googleapis.
# The build dependencies are included in vendor/ to keep this repo self-contained.
# Consider extracting a separate dart package?
GOOGLEAPIS="vendor/googleapis_7b5a467b9"
PROTOBUF="vendor/protobuf_v3.21.7"
outdir="lib/src/generated"
PROTOC="protoc --dart_out=grpc:$outdir -I$PROTOBUF/src -I$GOOGLEAPIS"

cat<<EOF
Regenerating upstream .pb.dart files...
EOF
# Keep the generated code as minimal as possible.
$PROTOC $GOOGLEAPIS/google/logging/v2/*.proto
$PROTOC $GOOGLEAPIS/google/logging/type/*.proto
# Some required Include files in api/ do not need generated code.
$PROTOC $GOOGLEAPIS/google/api/monitored_resource.proto
$PROTOC $GOOGLEAPIS/google/api/label.proto
$PROTOC $GOOGLEAPIS/google/api/launch_stage.proto
$PROTOC $GOOGLEAPIS/google/rpc/status.proto
#$PROTOC $GOOGLEAPIS/google/type/*.proto
$PROTOC $PROTOBUF/src/google/protobuf/*.proto

dart format lib/src/generated > /dev/null

cat<<EOF > lib/src/api.g.dart
export 'generated/google/api/monitored_resource.pb.dart';
export 'generated/google/logging/type/log_severity.pb.dart';
export 'generated/google/logging/v2/log_entry.pb.dart';
export 'generated/google/logging/v2/logging.pbgrpc.dart';
export 'generated/google/protobuf/struct.pb.dart';
EOF
