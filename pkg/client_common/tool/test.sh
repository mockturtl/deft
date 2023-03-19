#!/bin/sh -e

# By default, only failed and skipped (not successful) tests print output.
# Pass '-r expanded' to see all results (one per line).

dart test --test-randomize-ordering-seed random -j $(nproc) "$@"
