#!/usr/bin/env zsh

export ZCUSTOM="$HOME/.zsh"

# Custom setup
export ZCONFIG="$ZCUSTOM/config"
export ZFUNCTIONS="$ZCUSTOM/functions"
export ZLIB="$ZCUSTOM/lib"
export ZPLUGINS="$ZCUSTOM/plugins"
export ZSCRIPTS="$ZCUSTOM/scripts"

# Temp files
export ZLOGS="$ZCUSTOM/var/logs"
export ZCACHE="$ZCUSTOM/var/cache"
export ZCOMPDUMP="$ZCACHE/.zcompdump"

# Debugging (use `zc_debug --enable|--disable` to toggle)
export ZDEBUGFILE="$ZDOTDIR/.zdebug"
export ZDEBUG=$(test -f $ZDEBUGFILE && echo 1 || echo 0)

# Add functions dir and all of its subdirs to fpath
fpath=($ZFUNCTIONS $ZFUNCTIONS/**/*(/N) "$ZCUSTOM/completions" $fpath)

# Load functions
() {
  # Functions needed to load other functions
  local preloaded=(zc_load zc_print zc_debug)
  autoload -Uz $preloaded

  # Load all functions lazily
  for func in $ZFUNCTIONS/**/*(N); do
    if [[ -f $func ]]; then
      local fname=${func:t}
      (( ${preloaded[(Ie)$fname]} )) && continue
      zc_load --function $fname
    fi
  done
}

# Set shell options
zc_load --script "setopts.zsh"

# Prevent further setup if required programs are missing
zc_load --script "requirements.zsh" || {
  zc_print --err "Please install required programs and try again."
  return
}

# macOS specific setup
[[ "$(uname)" == "Darwin" ]] && zc_load --script "macos.zsh"

# Sourcing libraries
for lib in $ZLIB/**/*(N); do
  if [[ -f $lib ]]; then
    zc_load --lib ${lib#$ZLIB/}
  fi
done

zc_load --script "antigen.zsh"
zc_load --script "fastfetch.zsh"
