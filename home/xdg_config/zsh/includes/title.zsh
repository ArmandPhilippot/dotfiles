autoload -Uz add-zsh-hook

title_precmd() {
	case $TERM in
	'screen'*|'tmux'*)
		print -Pn -- "\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\"
		;;
	*)
		print -Pn -- "\e]2;%n@%m > %~\a"
		;;
	esac
}

title_preexec() {
	case $TERM in
	'screen'*|'tmux'*)
		print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} | %(!.sudo .) '
		print -n -- "${(q)1}\e\\"
		;;
	*)
		print -Pn -- "\e]2;%n@%m > %~ | %(!.sudo .) "
		print -n -- "${(q)1}\a"
		;;
	esac
}

is_term_in() {
	case $1 in
	'alacritty'*|'aterm'*|'Eterm'*|'gnome'*|'konsole'*|'kterm'*|'putty'*|'rxvt'*|'screen'*|'tmux'*|'xterm'*) return 0 ;;
	*) return 1
	esac
}

if is_term_in "$TERM"; then
	add-zsh-hook -Uz precmd title_precmd
	add-zsh-hook -Uz preexec title_preexec
fi
