#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EPOCH="epoch_3"
IN_DIR="$ROOT/tests/$EPOCH/inputs"
OUT_DIR="$ROOT/tests/$EPOCH/actual_outputs"

mkdir -p "$OUT_DIR"

for input in "$IN_DIR"/*.txt; do
  name="$(basename "$input")"
  echo "=== Running $EPOCH: $name ==="

  rm -f "$ROOT/data/accounts.dat" "$ROOT/data/profiles.dat" || true
  cp "$input" "$ROOT/data/InCollege-Input.txt"
  : > "$ROOT/data/InCollege-Output.txt"

  (cd "$ROOT" && ./InCollege >/dev/null)

  cp "$ROOT/data/InCollege-Output.txt" "$OUT_DIR/$name"
done

echo "Done. Actual outputs in: $OUT_DIR"
