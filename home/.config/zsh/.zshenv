# .zshenv
#
# Sourced on all invocations of the shell. Contains exported variables that
# should be available to other programs.

export DOTFILES="$HOME/.dotfiles"

# XDG Base Directory Specification
# See: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_BIN_HOME=${XDG_BIN_HOME:="$HOME/.local/bin"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_LIB_HOME=${XDG_LIB_HOME:="$HOME/.local/lib"}

# ZSH Config
export ZDOTDIR="${HOME}/.config/zsh"               # Zsh config path
export HISTFILE="${HOME}/.local/share/zsh/history" # History filepath
export HISTSIZE=10000                              # Maximum events for internal history
export SAVEHIST=10000                              # Maximum events in history file

# Custom Zsh
export ZSH_THEME="coldark"
export ZSH_PLUGINS=(vcs zsh-syntax-highlighting)

# Default Apps
export EDITOR="nano"

# SSH
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export SSH_ASKPASS=/usr/lib/ssh/ssh-askpass

# GPG
export GPG_TTY=$(tty)

# Bat
export BAT_THEME="Coldark-Dark"

# Force these apps to respect XDG
# See: https://wiki.archlinux.org/title/XDG_Base_Directory_support#Support
export GTK2_RC_FILES="{$XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export LESSHISTFILE="{$XDG_CACHE_HOME}/less/history"
export LESSKEY="{$XDG_CONFIG_HOME}/less/lesskey"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
