# .zshenv
#
# Sourced on all invocations of the shell. Contains exported variables that
# should be available to other programs.

export DOTFILES="$HOME/.local/dotfiles"
export DOTFILES_PRIVATE="$HOME/.local/private"

# XDG Base Directory Specification
# See: http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_BIN_HOME=${XDG_BIN_HOME:="$HOME/.local/bin"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_LIB_HOME=${XDG_LIB_HOME:="$HOME/.local/lib"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

# ZSH Config
export ZDOTDIR="${HOME}/.config/zsh"               # Zsh config path
export HISTFILE="${HOME}/.local/share/zsh/history" # History filepath
export HISTSIZE=10000                              # Maximum events for internal history
export SAVEHIST=10000                              # Maximum events in history file

# Custom Zsh
export ZSH_THEME="coldark"
export ZSH_PLUGINS=(vcs zsh-nvm zsh-syntax-highlighting)

# Default Apps
export EDITOR="nano"

# SSH
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
export SSH_ASKPASS=/usr/lib/ssh/ssh-askpass

# GPG
export GPG_TTY=$(tty)

# Bat
export BAT_THEME="Coldark-Dark"

# nvm
export NVM_LAZY_LOAD=true

# Force these apps to respect XDG
# See: https://wiki.archlinux.org/title/XDG_Base_Directory_support#Support
export GOBIN="${XDG_BIN_HOME}"
export GOPATH="${XDG_DATA_HOME}/go"
export GTK2_RC_FILES="{$XDG_CONFIG_HOME}/gtk-2.0/gtkrc"
export LESSHISTFILE="{$XDG_CACHE_HOME}/less/history"
export LESSKEY="{$XDG_CONFIG_HOME}/less/lesskey"
export MYSQL_HISTFILE="${XDG_CACHE_HOME}/mysql/history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NVM_DIR="${XDG_CONFIG_HOME}/nvm"
export PHPENV_ROOT="${XDG_DATA_HOME}/phpenv"
export PNPM_HOME="${XDG_DATA_HOME}/pnpm"
export VIMINIT="${XDG_CONFIG_HOME}/vim/vimrc"
