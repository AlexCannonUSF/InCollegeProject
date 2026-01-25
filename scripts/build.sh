#!/usr/bin/env bash
set -e

mkdir -p bin
cobc -x -free -o bin/InCollege \
  src/InCollege.cob \
  src/CreateAccount.cob \
  src/LogIn.cob \
  src/DataStore.cob

echo "Build complete: bin/InCollege"