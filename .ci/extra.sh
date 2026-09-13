#!/usr/bin/env bash
# Bridge-repo checks (run by .github/scripts/validate.py)
set -euo pipefail

test -s README.md || { echo "README.md is empty"; exit 1; }
grep -qi "GuardLog" README.md || { echo "README.md does not name the product"; exit 1; }
if grep -nE "github\.com/[A-Za-z0-9._-]*Core" README.md; then
  echo "README links to a private source repository"
  exit 1
fi
echo "bridge README OK"
