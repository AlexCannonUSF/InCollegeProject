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
  : > "$ROOT/data/accounts.dat"
  : > "$ROOT/data/profiles.dat"
  : > "$ROOT/data/PendingRequests.dat"
  : > "$ROOT/data/EstablishedConnections.dat"
  : > "$ROOT/data/JobPostings.dat"
  : > "$ROOT/data/JobApplications.dat"
  : > "$ROOT/data/Messages.dat"

  (cd "$ROOT" && "$ROOT/bin/InCollege" < "$input") > "$ACTUAL_OUT_DIR/$name"
  cat "$ROOT/data/JobApplications.dat" > "$ACTUAL_OUT_DIR/$base_name-JobApplicationsPersistence.txt"
  cat "$ROOT/data/JobPostings.dat" > "$ACTUAL_OUT_DIR/$base_name-JobPostingsPersistence.txt"

  echo "Running Output Tests"
  DIFF=$(diff "$ACTUAL_OUT_DIR/$name" "$CORRECT_OUT_DIR/$name")
  if [ ! "$DIFF" ]; then
    echo "Pass Output Tests"
  else
    echo "Failed Output Tests"
    echo "$DIFF"
  fi

  DIFF=$(diff "$ACTUAL_OUT_DIR/$base_name-JobApplicationsPersistence.txt" "$CORRECT_OUT_DIR/$base_name-JobApplicationsPersistence.txt")
  if [ ! "$DIFF" ]; then
    echo "JobApplications.txt file is correct"
  else
    echo "JobApplications.txt file is incorrect"
    echo "$DIFF"
  fi

  DIFF=$(diff "$ACTUAL_OUT_DIR/$base_name-JobPostingsPersistence.txt" "$CORRECT_OUT_DIR/$base_name-JobPostingsPersistence.txt")
  if [ ! "$DIFF" ]; then
    echo "JobPostings.txt file is correct"
  else
    echo "JobPostings.txt is incorrect"
    echo "$DIFF"
  fi
done

echo "Done. Actual outputs in: $ACTUAL_OUT_DIR"
