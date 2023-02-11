#!/bin/bash

set -e
set -u
set -o pipefail

PIDS=()
for TEMPLATE in "cloud"; do
    echo building: $TEMPLATE
    docker buildx build --platform linux/amd64 -f $TEMPLATE.dockerfile -t ptorru/blue-alma:$TEMPLATE --push . &
    PIDS+=$!
done;

for pid in ${PIDS[*]}; do
    wait $pid
done
