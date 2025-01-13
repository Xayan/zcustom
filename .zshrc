#!/usr/bin/env zsh

export ZCUSTOM="$HOME/.zsh"

export ZDEBUG=true

# Custom setup
export ZCONFIG="$ZCUSTOM/config"
export ZFUNCTIONS="$ZCUSTOM/functions"
export ZLIB="$ZCUSTOM/lib"
export ZPLUGINS="$ZCUSTOM/plugins"
export ZSCRIPTS="$ZCUSTOM/scripts"

# Temp files
export ZLOGS="$ZCUSTOM/var/logs"
export ZCACHE="$ZCUSTOM/var/cache"

# zsh internal
export ZDOTDIR="$ZCUSTOM/var/z"
export ZCOMPDUMP="$ZCACHE/.zcompdump"

fpath=($ZFUNCTIONS $ZFUNCTIONS/**/*(/N) "$ZCUSTOM/completions" $fpath)

autoload -Uz zc_debug zc_load

zc_load --script "setopts.zsh"

if [[ "$(uname)" == "Darwin" ]]; then
  zc_load --script "macos.zsh"
fi

for func in $ZFUNCTIONS/**/*(N); do
  if [[ -f $func ]]; then
    zc_load --function ${func:t}
  fi
done

for lib in $ZLIB/**/*(N); do
  if [[ -f $lib ]]; then
    zc_load --lib ${lib#$ZLIB/}
  fi
done

zc_load --script "antigen_init.zsh"

# Splash screen
() {
  [[ $ZDEBUG == true ]] && zc_debug --dumpenv && return

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
