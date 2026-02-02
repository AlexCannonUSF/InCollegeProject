#!/usr/bin/env bash
set -e

mkdir -p bin

cobc -x -free -o bin/InCollege \
  src/InCollege.cob \
  src/CreateAccount.cob \
  src/LogIn.cob \
  src/DataStore.cob \
  src/HomePage.cob \
  src/SkillMenu.cob \
  src/PersonalProfile.cob \
  src/ProfileCreate.cob \
  src/ProfileEdit.cob

echo "Build complete: bin/InCollege"