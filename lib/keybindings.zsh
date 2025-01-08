#!/usr/bin/env zsh

# Basic emacs keybindings
bindkey -e

file="$ZCONFIG/bindk ey.json"

if [[ -f $file ]]; then
  zc_debug "Loading keybindings from '%s'" "$(zc_relative_path $file)"

  # Parse widgets bindings
  jq -r '.widgets | to_entries | .[] | "\(.key) \(.value)"' "$file" | while read -r key widget; do
    zc_debug "Binding $key to $widget" 4
    zle -N "$widget"
    bindkey "$key" "$widget"
  done

  # Parse string bindings
  jq -r '.strings | to_entries | .[] | "\(.key) \(.value)"' "$file" | while read -r key command; do
    zc_debug "  Binding $key to $command" 4
    bindkey -s "$key" "$command"
  done
else
  zc_print --type err --source "File '%s' was not found!" "$(zc_relative_path $file)"

fi
