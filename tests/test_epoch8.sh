#!/bin/bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EPOCH="epoch_8"
IN_DIR="$ROOT/tests/$EPOCH/inputs"
CORRECT_OUT_DIR="$ROOT/tests/$EPOCH/expected_outputs"
ACTUAL_OUT_DIR="$ROOT/tests/$EPOCH/actual_outputs"

mkdir -p "$ACTUAL_OUT_DIR"

for input in "$IN_DIR"/*.txt; do
  name="$(basename "$input")"
  base_name="${name%.txt}"
  echo "=== Running $EPOCH: $name ==="

  mkdir -p "$ROOT/data"
  rm -f "$ROOT/data/accounts.dat"
  rm -f "$ROOT/data/profiles.dat"
  rm -f "$ROOT/data/PendingRequests.dat"
  rm -f "$ROOT/data/EstablishedConnections.dat"
  rm -f "$ROOT/data/JobPostings.dat"
  rm -f "$ROOT/data/JobApplications.dat"
  rm -f "$ROOT/data/Messages.dat"

  (cd "$ROOT" && "$ROOT/bin/InCollege" < "$input") > "$ACTUAL_OUT_DIR/$name"
  cat "$ROOT/data/Messages.dat" > "$ACTUAL_OUT_DIR/$base_name-MessagesPersistence.txt"

  echo "Running Output Tests"
  DIFF=$(diff "$ACTUAL_OUT_DIR/$name" "$CORRECT_OUT_DIR/$name")
  if [ ! "$DIFF" ]; then
    echo "Pass Output Tests"
  else
    echo "Failed Output Tests"
    echo "$DIFF"
  fi

  DIFF=$(diff "$ACTUAL_OUT_DIR/$base_name-MessagesPersistence.txt" "$CORRECT_OUT_DIR/$base_name-MessagesPersistence.txt")
  if [ ! "$DIFF" ]; then
    echo "Messages.dat file is correct"
  else
    echo "Messages.dat file is incorrect"
    echo "$DIFF"
  fi

  DIFF=$(diff "$ACTUAL_OUT_DIR/$base_name-MessagesPersistence.txt" "$CORRECT_OUT_DIR/$base_name-MessagesPersistence.txt")
  if [ ! "$DIFF" ]; then
    echo "Messages.dat file is correct"
  else
    echo "Messages.dat is incorrect"
    echo "$DIFF"
  fi
done

echo "Done. Actual outputs in: $ACTUAL_OUT_DIR"
