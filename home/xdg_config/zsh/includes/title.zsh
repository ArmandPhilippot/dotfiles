autoload -Uz add-zsh-hook

get_app_name() {
	ps --pid $(ps --pid $$ -o ppid=) -o comm=
}

title_precmd() {
	local _app_name=$(get_app_name) || true

	case $TERM in
	'screen'*|'tmux'*)
		print -Pn -- "\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\"
		;;
	*)
		print -Pn -- "\e]2;${_app_name} | %n@%m > %~\a"
		;;
	esac
}

title_preexec() {
	local _app_name=$(get_app_name) || true

	case $TERM in
	'screen'*|'tmux'*)
		print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} | %(!.sudo .) '
		print -n -- "${(q)1}\e\\"
		;;
	*)
		print -Pn -- "\e]2;${_app_name} | %n@%m > %~ | %(!.sudo .) "
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
