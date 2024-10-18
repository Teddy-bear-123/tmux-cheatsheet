#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR="$(dirname "$CURRENT_DIR")"
BINARY_PATH="$PARENT_DIR/target/release/tmux-cheatsheet"

# Check if binary exists
if [ ! -f "$BINARY_PATH" ]; then
    tmux display-message "Error: Cheatsheet binary not found. Try rebuilding the plugin."
    cd "$PARENT_DIR" && ./build.sh
    exit 1
fi

# Check if binary is executable
if [ ! -x "$BINARY_PATH" ]; then
    chmod +x "$BINARY_PATH"
fi

# Run the binary and capture any errors
if ! "$BINARY_PATH"; then
    tmux display-message "Error: Failed to display cheatsheet"
    exit 1
fi

