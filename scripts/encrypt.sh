#!/usr/bin/env bash
for host in $(ls ./ansible/host_vars); do 
    cd ansible && ansible-vault encrypt host_vars/"$host"/"$host"_vault.yml &> /dev/null || true
    cd ../
done

echo "[38;5;208mEncrypted all vaults![0m"