#!/usr/bin/env bash
set -e

mkdir -p bin
cobc -x -free -o bin/InCollege src/InCollege.cob
echo "Build complete: bin/InCollege"
