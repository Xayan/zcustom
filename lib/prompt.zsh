#!/usr/bin/env zsh

zstyle :prompt:pure:git:branch      color  221
zstyle :prompt:pure:git:dirty       color  red
zstyle :prompt:pure:user            color  cyan
zstyle :prompt:pure:host            color  cyan
zstyle :prompt:pure:path            color  75
zstyle :prompt:pure:prompt:success  color  green
zstyle :prompt:pure:prompt:error    color  red

# Choose random prompt symbol from array
PROMPT_SYMBOLS=( "λ" "¿" "※" "⁞" "⋯" "⁈" "ℵ" "↪" "⤷" "⮑ " "⇶" "⟠" "⬖" "⭔" "⌂" "∊" "∞" "∪" "✘" "⊙" "⨀" "≫" "⋙" "⋗" "›" "❯" "⟩" "❱" "⟭" "⦔" "⧁" "⍩" "⨠" "⪢" "⫸" "⌦" "⫍" "⫎" "⫻" "❖" "♠" "♣" "♥" "♦" "♫" "⚝" "⛌" "⛏" "⛐" "⛟ " "⟁" "⛬" "⟅" "⟆" "⌁" "⌇" "⌊" "⍚" "⍜" "⎇ " "⎋" "⎖" "⏏" "⏯" "⏻" "⏾" "▔" "▏" "▢" "▣" "▪" "◇" "◊" "◯" "◌" "◡" "◤" "◸" "★" "☇" "☗" "☖" "⚑" "⚐" "☘" "☡" "⚕" "⚛" "⚜" "⛓" "⛚" "⛛" "⛩" "⛭" "⛰" "⛱" "✈" "❞" "•" "√" "𝒳" "𝓍" "⦦" "⧉" "≒" "࠵" )

set_prompt_symbol() {
    # Set in this order: 1) function argument; 2) already defined value in $PROMPT_SYMBOL; 3) random value from $PROMPT_SYMBOLS
    if [[ -n "$1" ]]; then
        export PURE_PROMPT_SYMBOL="$1"
    else
        export PURE_PROMPT_SYMBOL="$PROMPT_SYMBOLS[$RANDOM % ${#PROMPT_SYMBOLS[@]} + 1]"
    fi

} && set_prompt_symbol "$PURE_PROMPT_SYMBOL"
