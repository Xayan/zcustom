#!/usr/bin/env zsh

() {
  command -v fastfetch >/dev/null 2>&1 || return

  if [[ "$DISPLAY" || -n "$SSH_CONNECTION" || "$TERM" == "xterm-256color" || "$TERM" == "screen-256color" ]]; then
    local config=$(zc_load --config "fastfetch.jsonc")

    if [[ -n "$config" ]]; then
      zc_debug "Found fastfetch configuration in ${config#$ZCUSTOM/}"
      fastfetch --config $config
    else
      zc_debug "No fastfetch configuration found"
      fastfetch
    fi
  fi
}
