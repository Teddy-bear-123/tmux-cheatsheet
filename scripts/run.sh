#!/usr/bin/env bash

# Get the current directory of the script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Path to the Rust binary
BINARY_PATH="$CURRENT_DIR/../target/release/tmux-cheatsheet"

# Check if the Rust binary exists
if [[ -f "$BINARY_PATH" ]]; then
    # Run the Rust binary to display the cheatsheet
    "$BINARY_PATH" && notify-send "Tmux Cheatsheet" "Cheatsheet displayed"
else
    echo "Error: Tmux cheatsheet binary not found at $BINARY_PATH"
    notify-send "Error" "Tmux cheatsheet binary not found"
fi

