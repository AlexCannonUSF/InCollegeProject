#!/usr/bin/env bash
set -e
mkdir -p data
./bin/InCollege < data/InCollege-Input.txt | tee data/InCollege-Output.txt
echo "Run complete. Output written to data/InCollege-Output.txt"