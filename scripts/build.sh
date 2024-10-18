#!/usr/bin/env bash

# Get the directory where the script is located
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# Get the parent directory (main project directory)
PARENT_DIR="$(dirname "$CURRENT_DIR")"

# Navigate to the project directory and build the Rust project in release mode
cd "$PARENT_DIR" && cargo build --release

# Check if the build was successful
if [ $? -eq 0 ]; then
    echo "✓ Successfully built tmux-cheatsheet"
else
    echo "✗ Failed to build tmux-cheatsheet"
    exit 1
fi

