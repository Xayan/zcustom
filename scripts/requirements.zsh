#!/usr/bin/env zsh

local required=(
  "jq"
  "curl"
  "git"
)

local optional=(
  "fastfetch"
)

local ret=0

for cmd in $required; do
  if ! command -v $cmd >/dev/null 2>&1; then
    zc_print --err --source 2 "$cmd not found"
    ret=1
  fi
done

for cmd in $optional; do
  if ! command -v $cmd >/dev/null 2>&1; then
    zc_print --warn --source 2 "$cmd not found"
  fi
done

return $ret
