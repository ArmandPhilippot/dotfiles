#!/bin/zsh
#
# zsh-themes.zsh
#
# A theme manager that allows you to test a theme without editing `.zshenv`:
# * List available themes in ~/.config/zsh/themes
# * Change theme for the current shell
# WARNING: It works with my config, not tested elsewhere.

list_themes() {
    echo -e "\nAvailable themes for Zsh:"
    for theme in ${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/*.zsh-theme; do
        theme_file=${theme##*/}
        theme_name=${theme_file%.*}
        print -P "%F{green}$theme_name%f"
    done
}

set_theme() {
    echo -e "The theme will be changed only for the current shell. For a permanent solution, consider editing $HOME/.config/zsh/.zshenv file."
    while true; do
        read "choice?Theme name: "

        if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/$choice.zsh-theme" ]]; then
            export ZSH_THEME=$choice
            source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/themes/$choice.zsh-theme"
            return 1
        else
            echo -e "Invalid theme name."
        fi
    done
}

zsh-themes() {
    while true; do
        echo -e "Choose the action to be performed from the list:"
        echo -e "[1] List themes"
        echo -e "[2] Change theme"
        echo -e "[qQ] Exit"
        read "choice?Your choice: "

        case $choice in
        1) list_themes ;;
        2) set_theme ;;
        [qQ]) return 1 ;;
        *) echo -e "Invalid input, try again." >&2 ;;
        esac
    done
}
