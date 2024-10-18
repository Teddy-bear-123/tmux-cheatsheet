#!/usr/bin/env bash

# Set keybindings for the tmux cheatsheet
set_cheatsheet_keybindings() {
    local key_bindings=$(get_tmux_option "@cheatsheet" "$default_cheatsheet_key")
    local key
    for key in $key_bindings; do
        tmux bind-key "$key" run-shell "$CURRENT_DIR/scripts/run.sh"
    done
}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
    local default_cheatsheet_key="C-c"  # Set the default key to show the cheatsheet
    set_cheatsheet_keybindings
}
main

