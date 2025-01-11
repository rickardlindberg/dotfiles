#!/usr/bin/env bash

exec tree \
    -I '__pycache__|.git|.*.swp' \
    -a \
    "$@"
