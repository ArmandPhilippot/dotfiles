#!/bin/zsh
#
# keybindings.zsh
#
# Used to define ZSH options.

# Completion
setopt always_to_end    # Move cursor to the end of the word.
setopt auto_list        # Automatically list choices on ambiguous completion.
setopt auto_menu        # Automatically use menu completion.
setopt complete_aliases # Make the alias a distinct command.

# Correction
setopt correct       # Correct only commands.
unsetopt correct_all # Prevent arguments correction.

# History
setopt extended_history       # Record timestamp of command.
setopt hist_expire_dups_first # Delete duplicates first if HISTFILE > HISTSIZE.
setopt hist_ignore_dups       # Ignore duplicates of previous event.
setopt hist_reduce_blanks     # Remove superfluous blanks.
setopt share_history          # Share history between sessions.
