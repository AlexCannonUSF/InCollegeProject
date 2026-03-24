#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EPOCH="epoch_4"
IN_DIR="$ROOT/tests/$EPOCH/inputs"
OUT_DIR="$ROOT/tests/$EPOCH/actual_outputs"

mkdir -p "$OUT_DIR"

for input in "$IN_DIR"/*.txt; do
  name="$(basename "$input")"
  echo "=== Running $EPOCH: $name ==="

  # always ensure data dir + required files exist (case-sensitive)
  mkdir -p "$ROOT/data"
  : > "$ROOT/data/accounts.dat"
  : > "$ROOT/data/profiles.dat"
  : > "$ROOT/data/PendingRequests.dat"
  : > "$ROOT/data/InCollege-Output.txt"

  (cd "$ROOT" && "$ROOT/bin/InCollege" < "$input") > "$OUT_DIR/$name"

  # ensure output ends with newline (prevents "\ No newline at end of file" diffs)
  printf '\n' >> "$OUT_DIR/$name"
done

echo "Done. Actual outputs in: $OUT_DIR"