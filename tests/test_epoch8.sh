#!/bin/bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EPOCH="epoch_8"
IN_DIR="$ROOT/tests/$EPOCH/inputs"
CORRECT_OUT_DIR="$ROOT/tests/$EPOCH/expected_outputs"
ACTUAL_OUT_DIR="$ROOT/tests/$EPOCH/actual_outputs"

mkdir -p "$ACTUAL_OUT_DIR"

normalize_messages_persistence() {
  local source_file="$1"
  local normalized_file="$2"

  if [ -f "$source_file" ]; then
    sed -E 's/[0-9]{2}\/[0-9]{2}\/[0-9]{4} @ [0-9]{2}:[0-9]{2}/<TIMESTAMP>/g' "$source_file" > "$normalized_file"
  else
    : > "$normalized_file"
  fi
}

for input in "$IN_DIR"/*.txt; do
  name="$(basename "$input")"
  base_name="${name%.txt}"
  actual_persistence_file="$ACTUAL_OUT_DIR/$base_name-MessagesPersistence.txt"
  actual_normalized_file="$ACTUAL_OUT_DIR/$base_name-MessagesPersistence.normalized.txt"
  expected_normalized_file="$ACTUAL_OUT_DIR/$base_name-ExpectedMessagesPersistence.normalized.txt"
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
  if [ -f "$ROOT/data/Messages.dat" ]; then
    cat "$ROOT/data/Messages.dat" > "$actual_persistence_file"
  else
    : > "$actual_persistence_file"
  fi

  normalize_messages_persistence "$actual_persistence_file" "$actual_normalized_file"
  normalize_messages_persistence "$CORRECT_OUT_DIR/$base_name-MessagesPersistence.txt" "$expected_normalized_file"

  echo "Running Output Tests"
  DIFF=$(diff "$ACTUAL_OUT_DIR/$name" "$CORRECT_OUT_DIR/$name")
  if [ ! "$DIFF" ]; then
    echo "Pass Output Tests"
  else
    echo "Failed Output Tests"
    echo "$DIFF"
  fi

  DIFF=$(diff "$actual_normalized_file" "$expected_normalized_file")
  if [ ! "$DIFF" ]; then
    echo "Messages.dat file is correct"
  else
    echo "Messages.dat is incorrect"
    echo "$DIFF"
  fi

  rm -f "$actual_normalized_file" "$expected_normalized_file"
done

echo "Done. Actual outputs in: $ACTUAL_OUT_DIR"
