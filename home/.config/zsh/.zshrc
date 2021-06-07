# .zshrc
#
# Sourced in interactive shells. Contains commands to set up aliases,
# functions, options, key bindings, etc.

# Includes
for includes ($ZDOTDIR/includes/*.zsh); do
    source $includes
done

# Functions
for file ($ZDOTDIR/functions/*.zsh); do
    source $file
done

# Plugins
for plugin ($ZSH_PLUGINS); do
    if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/$plugin.zsh" ]; then
        source ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/$plugin.zsh
    fi
done

# Themes
if [ ! "$ZSH_THEME" = ""  ]; then
    if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/$ZSH_THEME.zsh-theme" ]; then
        source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/$ZSH_THEME.zsh-theme"
    fi
fi

# Aliases
source ${XDG_CONFIG_HOME:-$HOME/.config}/sh/.aliases

# Load dir_colors
eval "$(dircolors ${XDG_CONFIG_HOME:-$HOME/.config}/sh/.dir_colors)"

# Make sure the ZSH cache directory exists
[ -d "$XDG_CACHE_HOME/zsh" ] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Make sure the ZSH data directory exists
[ -d "$XDG_DATA_HOME/zsh" ] || mkdir -p "$XDG_DATA_HOME/zsh"

# Fzf
if [ $(command -v "fzf") ]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi
