#!/usr/bin/env zsh

export ADOTDIR=$ZDOTDIR
export ANTIGEN_AUTO_CONFIG=false
export ANTIGEN_COMPDUMP=$ZCOMPDUMP

if [[ $ZDEBUG == true ]]; then
  export ANTIGEN_CACHE=false
  export ANTIGEN_LOG=$ZLOGS/antigen.log
  export ANTIGEN_DEBUG_LOG=$ZLOGS/antigen-debug.log
else
  export ANTIGEN_CACHE=$ZCACHE/antigen.zsh
  export ANTIGEN_LOG=/dev/null
  export ANTIGEN_DEBUG_LOG=/dev/null
fi

# zsh-z
export ZSHZ_DATA="$ZDOTDIR/.z"
