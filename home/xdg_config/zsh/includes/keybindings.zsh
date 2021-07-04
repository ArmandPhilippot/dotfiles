#!/bin/zsh
#
# keybindings.zsh
#
# Used to define keybindings.

# Make sure the terminal is in application mode, when zle is active. Only then
# values from $terminfo are valid.
# See: https://wiki.archlinux.org/title/Zsh#Key_bindings
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Exit shell even if the command line is filled
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Define more comprehensive names
# See: `man 5 terminfo`
typeset -g -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Backspace]="${terminfo[kbs]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Ctrl-Left]="^[[1;5D"
key[Ctrl-Right]="^[[1;5C"

# Setup keys accordingly
[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line
[[ -n "${key[Insert]}" ]] && bindkey -- "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char
[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-history
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-history
[[ -n "${key[Left]}" ]] && bindkey -- "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey -- "${key[Right]}" forward-char
[[ -n "${key[PageUp]}" ]] && bindkey -- "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey -- "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete
[[ -n "${key[Ctrl-Left]}" ]] && bindkey -- "${key[Ctrl-Left]}" backward-word
[[ -n "${key[Ctrl-Right]}" ]] && bindkey -- "${key[Ctrl-Right]}" forward-word
