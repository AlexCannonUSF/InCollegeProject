#!/usr/bin/env bash
set -e

./bin/InCollege < data/InCollege-Input.txt > data/InCollege-Output.txt
echo "Run complete. Output written to data/InCollege-Output.txt"
