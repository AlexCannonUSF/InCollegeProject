#!/usr/bin/env bash
set -e
mkdir -p data
: > data/accounts.dat
: > data/profiles.dat
./bin/InCollege < data/InCollege-Input.txt | tee data/InCollege-Output.txt
echo "Run complete. Output written to data/InCollege-Output.txt"