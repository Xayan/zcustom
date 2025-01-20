#!/usr/bin/env zsh

# Basic emacs keybindings
bindkey -e

local file="$ZCONFIG/bindkey.json"

if [[ -f $file ]]; then
  zc_debug "Loading keybindings from '%s'" ${file#$ZCUSTOM/}

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
else
  zc_error "Keybindings file not found: '%s'" ${file#$ZCUSTOM/}
fi
