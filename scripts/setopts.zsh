#!/usr/bin/env zsh

# Disable flow control (Ctrl+S and Ctrl+Q) in the terminal
# This allows using Ctrl+S for other purposes like searching forward in history
setopt noflowcontrol

# Allows parameter/command substitution in prompts
# This enables dynamic content in your shell prompt, like git branch info
setopt prompt_subst

# Append to history file instead of overwriting
setopt append_history

# Save timestamp and duration for each command in history
setopt extended_history

# Display PID when suspending processes
setopt longlistjobs

# Prevent "no matches found" error when using wildcards
# Passes the pattern unchanged if no matches are found
setopt nonomatch

# Report background job status immediately
# setopt notify

# # Hash entire command path, not just command name
# setopt hash_list_all

# Allow completion within a word, not just at the end
# For example: completing 'cd /u/lo/b<TAB>' can complete to 'cd /usr/local/bin'
setopt completeinword

# Don't split words on spaces (important for filenames with spaces)
# Prevents unwanted word splitting in parameter expansions
setopt noshwordsplit

# Allow comments in interactive shell
# Lets you add comments to commands in terminal with #
setopt interactivecomments
