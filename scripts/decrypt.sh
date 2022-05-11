#!/usr/bin/env bash
set -e
pushd ansible >/dev/null
for host in $(ls ./host_vars); do
  [ -f "host_vars/$host/${host}_vault.yml" ] && ansible-vault decrypt "host_vars/$host/${host}_vault.yml" >/dev/null || true
done
popd >/dev/null

echo "[38;5;208mDecrypted all vault files![0m"
