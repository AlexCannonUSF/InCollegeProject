#!/bin/bash
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/." && pwd)"
EPOCH="epoch_7"
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
    cat "$ROOT/tests/indexed_base_data.txt" > "$ROOT/data/EstablishedConnections.dat"
    : > "$ROOT/data/JobPostings.dat"
    : > "$ROOT/data/JobApplications.dat"

    (cd "$ROOT" && "$ROOT/bin/InCollege" < "$input") > "$ACTUAL_OUT_DIR/$name"
    # (cd "$ROOT" && "$ROOT/bin/InCollege" < "$input")

    DIFF=$(diff "$ACTUAL_OUT_DIR/$name" "$CORRECT_OUT_DIR/$name")
    if [ ! "$DIFF" ]; then
        echo "$base_name": Make Persistence
        cat "$ROOT/data/JobApplications.dat" > "$CORRECT_OUT_DIR/$base_name-JobApplicationsPersistence.txt"
        cat "$ROOT/data/JobPostings.dat" > "$CORRECT_OUT_DIR/$base_name-JobPostingsPersistence.txt"
    fi
done