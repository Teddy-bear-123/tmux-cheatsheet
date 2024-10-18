#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Helper function to get tmux option
get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

# Set keybindings for the tmux cheatsheet
set_cheatsheet_keybindings() {
    local default_key=$1
    local key_binding=$(get_tmux_option "@cheatsheet" "$default_key")
    
    # Ensure scripts are executable
    chmod +x "$CURRENT_DIR/scripts/run.sh"
    
    # Set the key binding
    tmux bind-key "$key_binding" run-shell "$CURRENT_DIR/scripts/run.sh && notify-send 'Cheatsheet' 'Cheatsheet displayed'"
    
    # Debug message
    tmux display-message "Cheatsheet binding set to: $key_binding"
}

main() {
    local default_cheatsheet_key="C-c"  # Default key
    set_cheatsheet_keybindings "$default_cheatsheet_key"
}

# Run main
main

