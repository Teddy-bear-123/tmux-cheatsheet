#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_DIR="$(dirname "$CURRENT_DIR")"

# Build and install
cd "$PLUGIN_DIR" && make install

