#!/usr/bin/env zsh

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

source $ADOTDIR/antigen.zsh

antigen use oh-my-zsh

antigen theme sindresorhus/pure@main

antigen bundle git
# antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle mafredri/zsh-async@main
antigen bundle zsh-users/zsh-completions
# antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle agkozak/zsh-z

# antigen bundle $ZPLUGINS/zcm --no-local-clone

zc_compinit

# antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions

antigen apply
