#!/usr/bin/env bash

WORKDIR="$(pwd)"/ansible
cd "$WORKDIR" || exit

echo Working on the following task: "$CI_COMMIT_MESSAGE".

# Initialize ansible-galaxy playbooks
chmod +x initialize && ./initialize

# Find out if commit message contains a certain string
run_playbook() {
  if grep -q "dry-run" <<<"$CI_COMMIT_MESSAGE" \
    && grep -q "$1" <<<"$CI_COMMIT_MESSAGE"; then
    ansible-playbook "$1" --check
  fi
}

# Define what to run
run_playbook "borg_clients.yml"
run_playbook "docker_compose.yml"
run_playbook "full_run.yml"
run_playbook "garuda.yml"
run_playbook "hardening.yml"
run_playbook "reboot.yml"
run_playbook "system_update.yml"
