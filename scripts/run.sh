#!/usr/bin/env bash

# Get the current directory of the script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Path to the Rust binary
BINARY_PATH="$CURRENT_DIR/../target/debug/tmux-cheetsheet"

# Run the Rust binary to display the cheatsheet
"$BINARY_PATH"

