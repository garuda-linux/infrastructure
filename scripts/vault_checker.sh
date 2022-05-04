#!/usr/bin/env bash
for host in $(ls ./ansible/host_vars); do
  if test -f ansible/host_vars/"$host"/"$host"_vault.yml; then
    if (grep -q "\$ANSIBLE_VAULT;" <ansible/host_vars/"$host"/"$host"_vault.yml); then
      echo "[38;5;108mVault Encrypted. Safe to commit.[0m"
    else
      echo "[38;5;208mCleartext vault detected! Run ./scripts/encrypt.sh and try again.[0m"
      exit 1
    fi
  fi
done
