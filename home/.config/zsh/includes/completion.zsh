#!/bin/zsh
#
# completion.zsh
#
# Used to define completion.

autoload -Uz compinit && compinit -d ${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
