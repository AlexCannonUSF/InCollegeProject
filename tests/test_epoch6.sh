#!/usr/bin/bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EPOCH="epoch_6"
IN_DIR="$ROOT/tests/$EPOCH/inputs"
CORRECT_OUT_DIR="$ROOT/tests/$EPOCH/expected_outputs"
ACTUAL_OUT_DIR="$ROOT/tests/$EPOCH/actual_outputs"

mkdir -p "$ACTUAL_OUT_DIR"

for input in "$IN_DIR"/*.txt; do
  name="$(basename "$input")"
  echo "=== Running $EPOCH: $name ==="

  # always ensure data dir + required files exist (case-sensitive)
  mkdir -p "$ROOT/data"
  : > "$ROOT/data/accounts.dat"
  : > "$ROOT/data/profiles.dat"
  : > "$ROOT/data/PendingRequests.dat"
  cat "$ROOT/tests/indexed_base_data.txt" > "$ROOT/data/EstablishedConnections.dat"
  : > "$ROOT/data/PendingRequests.dat"
  : > "$ROOT/data/JobPostings.dat"

  (cd "$ROOT" && "$ROOT/bin/InCollege" < "$input") > "$ACTUAL_OUT_DIR/$name"

  if [ -f "$CORRECT_OUT_DIR/${name::-4}-Persistence.txt" ]; then
    cat "$ROOT/data/JobPostings.dat" > "$ACTUAL_OUT_DIR/${name::-4}-Persistence.txt"
  fi

  # ensure output ends with newline (prevents "\ No newline at end of file" diffs)

  echo "Running Output Tests"
  DIFF=$(diff "$ACTUAL_OUT_DIR/$name" "$CORRECT_OUT_DIR/$name")
  if [ ! "$DIFF" ]; then
    echo "Pass Output Tests"
  else
    echo "Failed Output Tests"
    echo "$DIFF"
  fi

  if [ -f "$CORRECT_OUT_DIR/${name::-4}-Persistence.txt" ]; then
    echo "Running Persistence Tests"
    DIFF=$(diff "$ACTUAL_OUT_DIR/${name::-4}-Persistence.txt" "$CORRECT_OUT_DIR/${name::-4}-Persistence.txt");
    if [ ! "$DIFF" ]; then
      echo "Pass Persistence Tests"
    else
      echo "Failed Persistence Tests"
      echo "$DIFF"
    fi
  fi
    
done

echo "Done. Actual outputs in: $ACTUAL_OUT_DIR"