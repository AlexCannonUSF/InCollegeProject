#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
mkdir -p "$REPO_ROOT/bin"

# Compile all COBOL files, suppress warnings, only show errors
if cobc -x -free -o "$REPO_ROOT/bin/InCollege" \
  "$REPO_ROOT/src/InCollege.cob" \
  "$REPO_ROOT/src/CreateAccount.cob" \
  "$REPO_ROOT/src/LogIn.cob" \
  "$REPO_ROOT/src/DataStore.cob" \
  "$REPO_ROOT/src/HomePage.cob" \
  "$REPO_ROOT/src/SkillMenu.cob" \
  "$REPO_ROOT/src/PersonalProfile.cob" \
  "$REPO_ROOT/src/ProfileStore.cob" \
  "$REPO_ROOT/src/ProfileCreate.cob" \
  "$REPO_ROOT/src/ProfileEdit.cob"
then
    echo "Build succeeded: $REPO_ROOT/bin/InCollege"
else
    echo "Build failed!"
fi