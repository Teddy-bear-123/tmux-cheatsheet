#!/usr/bin/env bash

# Get the current directory of the script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Path to the Rust binary
BINARY_PATH="$CURRENT_DIR/../target/debug/tmux-cheetsheet"

# Check if the binary exists
if [ ! -f "$BINARY_PATH" ]; then
    echo "Building the Rust binary..."
    # Navigate to the Cargo project directory and build the project
    (cd "$CURRENT_DIR/.." && cargo build)
else
    echo "Binary already exists: $BINARY_PATH"
fi
