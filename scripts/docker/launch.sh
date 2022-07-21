#!/bin/bash
cd /user/infrastructure/
if [ "$#" != 0 ]; then
    "$@"
else
    bash -l
fi