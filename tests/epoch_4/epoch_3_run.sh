#!/bin/bash

# Get the directory where this script is located (epoch_3)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INPUT_DIR="$SCRIPT_DIR/inputs"
OUTPUT_DIR="$SCRIPT_DIR/actual_outputs"
mkdir -p "$OUTPUT_DIR"

# Assuming repo root is two levels above epoch_3
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Timeout limit in seconds
TIME_LIMIT=3

# Loop over all input files
for input_file in "$INPUT_DIR"/*.txt; do
    filename=$(basename "$input_file")
    
    # Run your program in the background
    "$REPO_ROOT/bin/InCollege" < "$input_file" > "$OUTPUT_DIR/$filename" &
    pid=$!   # capture the PID of the background process

    # Start a timer in the background to kill it if it runs too long
    ( sleep $TIME_LIMIT && kill -0 $pid 2>/dev/null && kill $pid 2>/dev/null ) &
    timer_pid=$!

    # Wait for the program to finish
    wait $pid
    exit_status=$?

    # Kill the timer if the program finished early
    kill $timer_pid 2>/dev/null

    # Check if program was killed due to timeout
    if [ $exit_status -ne 0 ]; then
        echo "$filename: TIMEOUT or ERROR"
        exit 1   # stop the entire script immediately
    fi
done

echo "All inputs processed. Outputs are in $OUTPUT_DIR"