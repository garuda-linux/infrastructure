#!/bin/bash
cd /user/infrastructure/ansible
if [ "$#" != 0 ]; then
    "$@"
else
    bash -l
fi
