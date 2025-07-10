#!/bin/zsh
#
# theming.zsh
#
# Used to define theming options.

autoload -Uz compinit colors zcalc
compinit -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION
colors
