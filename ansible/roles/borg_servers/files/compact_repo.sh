#!/usr/bin/env bash

REPODIR=/backups
CLIENTS=(esxi-web esxi-web-two esxi-monitor esxi-forum web esxi-cloud)

for client in ${REPODIR[@]}; do
    borg compact "$REPODIR"/"$client"/
done