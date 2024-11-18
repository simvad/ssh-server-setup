#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <MAC_ADDRESS>"
    exit 1
fi

wakeonlan "$1"
