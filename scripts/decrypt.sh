#!/usr/bin/env bash
for host in $(ls ./ansible/host_vars); do 
    cd ansible && ansible-vault decrypt host_vars/"$host"/"$host"_vault.yml &> /dev/null || true
    cd ../
done

echo "[38;5;208mDecrypted all vault files![0m"