#!/usr/bin/env zsh

# Basic emacs keybindings
bindkey -e

() {
  # Definition needs to be separated from zc_load call, otherwise return code is not propagated
  local file; file=$(zc_load --config "keybindings.json") || return 1

  # Parse widgets bindings
  jq -r '.widgets | to_entries | .[] | "\(.key) \(.value)"' "$file" | while read -r key widget; do
    zc_debug "Binding $key to $widget"
    zle -N "$widget"
    bindkey "$key" "$widget"
  done

  # Parse string bindings
  jq -r '.strings | to_entries | .[] | "\(.key) \(.value)"' "$file" | while read -r key command; do
    zc_debug "  Binding $key to $command"
    bindkey -s "$key" "$command"
  done
}
