#!/bin/zsh
#
# options.zsh
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

# Globbing
unsetopt extendedglob  # Extended globbing. Allows using regular expressions with * (but it messes with git HEAD^ so I prefer to disable it)
setopt nocaseglob      # Case insensitive globbing
setopt numericglobsort # Sort filenames numerically when it makes sense

# History
setopt appendhistory          # Immediately append history instead of overwriting
setopt extended_history       # Record timestamp of command.
setopt histignorealldups      # If a new command is a duplicate, remove the older one
setopt histignorespace        # Don't save commands that start with space
setopt hist_expire_dups_first # Delete duplicates first if HISTFILE > HISTSIZE.
setopt hist_ignore_dups       # Ignore duplicates of previous event.
setopt hist_reduce_blanks     # Remove superfluous blanks.
setopt share_history          # Share history between sessions.

# Prompt
setopt prompt_subst # Allow substitutions and expansions in the prompt
