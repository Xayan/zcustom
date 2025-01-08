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

autoload -Uz zc_debug

if [[ "$(uname)" == "Darwin" ]]; then
    zc_debug "MacOS detected, sourcing %s/macos.zsh"
    source "$ZSCRIPTS/macos.zsh"
fi

for func in $ZFUNCTIONS/*(N); do
  if [[ -f $func ]]; then
    zc_debug "Autoloading function ${func:t}"
    autoload -Uz ${func}
  fi
done

autoload -Uz compinit
compinit -D

for file in $ZLIB/**/*.zsh; do
  zc_debug "Sourcing file $(zc_relative_path $file)"
  source $file
done

source "$ZSCRIPTS/antigen_init.zsh"

# Splash screen
() {
  if [[ $ZDEBUG == true ]]; then
    return
  fi

  if [[ "$DISPLAY" || -n "$SSH_CONNECTION" || "$TERM" == "xterm-256color" || "$TERM" == "screen-256color" ]]; then
    local config="$ZCONFIG/fastfetch.jsonc"

    if [[ -f $config ]]; then
      zc_debug "Found fastfetch configuration in $(__zc_relpath $config)"
      fastfetch --config $config
    else
      zc_debug "No fastfetch configuration found in $config"
      fastfetch
    fi
  fi
}
