#!/bin/bash

addgroup -g "$GARUDA_GID" -S user
adduser -h /user -G user -S -D -s /bin/bash -u "$GARUDA_UID" "$GARUDA_USER"
exec su - "$GARUDA_USER" -- /launch.sh "$@"
