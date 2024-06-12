#!/usr/bin/env bash

DIST=$1
PATTERN="0000 604d d76f 5609 0040"

if [[ -z $DIST ]]; then
    echo -e "Usage: $0 <dist>\nDist: memory dump file or directory"
    exit 0
fi

if [[ -d $DIST ]]; then
    MPIN=$(for file in $DIST/*; do xxd $file |grep -i "$PATTERN"; done)
else
    MPIN=$(xxd $DIST |grep -i "$PATTERN")
fi

if [[ -z $MPIN ]]; then
    echo "MPIN not found."
    exit 0
fi

MPIN=$(echo $MPIN |grep -Eo "[0-9]{6}")
echo "MPIN found: $MPIN"