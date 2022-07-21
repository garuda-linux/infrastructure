#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"/docker
./run sh -c "cd ./ansible && /usr/local/bin/ansible-playbook full_run.yml"