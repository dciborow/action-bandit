#!/bin/bash
set -eu # Increase bash strictness

if [[ -n "${GITHUB_WORKSPACE}" ]]; then
  cd "${GITHUB_WORKSPACE}/${INPUT_WORKDIR}" || exit
fi

if [[ "$(which bandit)" == "" ]]; then
  echo "[action-bandit] Installing bandit package..."
  python -m pip install --upgrade bandit
fi
echo "[action-bandit] bandit version:"
bandit --version

echo "[action-bandit] Checking python code with the bandit linter..."
exit_val="0"
bandit --configfile "${INPUT_BANDIT_CONFIG}" . 2>&1

echo "[action-bandit] Clean up..."

if [[ "${exit_val}" -ne '0' ]]; then
  exit 1
fi
