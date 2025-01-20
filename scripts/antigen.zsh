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

if [[ ! -f "$ADOTDIR/antigen.zsh" ]]; then
  echo "Antigen not found. Do you want to download it now? [y/n] "
  read -k1 answer

  if [[ $answer == "y" ]]; then
    echo "Downloading Antigen..."
    curl -L git.io/antigen > $ADOTDIR/antigen.zsh
  else
    echo "Antigen not found. Exiting..."
    exit 1
  fi
fi

() {
  local config; config=$(zc_load --config "antigen.json") || return 1
  local omz=$(jq -r '."oh-my-zsh"' "$config" -e >/dev/null && echo 1 || echo 0)
  local theme=$(jq -r '.theme' "$config")

  zc_debug --indent 1 "oh-my-zsh: $omz"
  zc_debug --indent 1 "theme: $theme"
  zc_debug --indent 1 "plugins:"

  bundle_plugins() {
    local filter=$([[ -n $1 ]] && echo '.after == $after' || echo '.after == null')
    local after=$1

    jq -r --arg after "$after" '.plugins | .[] | select('"${filter}"') | "\(.name) \(.local // "false")"' "$config" | while read -r name local; do
      zc_debug --indent 2 "$name [local=$local]"

      if [[ "$local" == "true" ]]; then
        antigen bundle "$ZPLUGINS/$name" --no-local-clone
      else
        antigen bundle "$name"
      fi
    done
  }


  source $ADOTDIR/antigen.zsh

  [[ $omz ]] && antigen use oh-my-zsh

  antigen theme "$theme"

  bundle_plugins

  zc_compinit

  bundle_plugins "compinit"

  antigen apply
}
