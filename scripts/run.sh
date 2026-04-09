#!/usr/bin/env bash
set -e
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$ROOT/data"
  rm -f "$ROOT/data/accounts.dat"
  rm -f "$ROOT/data/profiles.dat"
  rm -f "$ROOT/data/PendingRequests.dat"
  rm -f "$ROOT/data/EstablishedConnections.dat"
  rm -f "$ROOT/data/JobPostings.dat"
  rm -f "$ROOT/data/JobApplications.dat"
  rm -f "$ROOT/data/Messages.dat"
./bin/InCollege < data/InCollege-Input.txt | tee data/InCollege-Output.txt
echo "Run complete. Output written to data/InCollege-Output.txt"