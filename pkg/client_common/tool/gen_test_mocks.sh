#!/bin/sh -e

# Output code in test/*_test.dart with the `@GenerateMocks` annotation.
# See https://github.com/dart-lang/mockito/blob/master/NULL_SAFETY_README.md
#
# This tool is idempotent.

dart run build_runner build "$@"
