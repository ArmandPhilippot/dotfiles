# Coldark theme for ZSH
# Tested on Manjaro Linux only.
# It is recommended to use it with Coldark for XFCE4 terminal.
# Features: git status
# Copyright: Armand Philippot, 2020
# Version: 1.0.0
# Adapted to my personal config. Orginal version: https://github.com/ArmandPhilippot/coldark-zsh-theme

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# Each component will draw itself, and hide itself if no information needs
# to be shown
# ------------------------------------------------------------------------------

# Username - Bold, blue foreground
username() {
    echo "%B%F{004} %n %F{015}→ %b%k%f"
}

# Current directory - Bold, green foreground
directory() {
    echo "%B%F{002}%~%b%f"
}

# # if root, $ if user - Yellow foreground
prompt_indicator() {
    echo "%B%F{003}%(!.#.$)%b%f"
}

# Time - Blue foreground
current_time() {
    echo "%F{004}%T%f"
}

print_vcs_info() {
    echo ${vcs_info_msg_0_}
}

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS SETTINGS
# Define information to show and colors
# ------------------------------------------------------------------------------

# Git info
ZSH_THEME_VCS_PROMPT_BRANCH_PREFIX="%B%F{015} on %F{003}"
ZSH_THEME_VCS_PROMPT_BRANCH_SUFFIX=" %%b%f"
ZSH_THEME_VCS_PROMPT_DIRTY="%F{001}✗ "
ZSH_THEME_VCS_PROMPT_CLEAN="%F{002}✔ "

# Git Status

ZSH_THEME_VCS_PROMPT_UNTRACKED="%K{005}%F{000} U %k%f"
ZSH_THEME_VCS_PROMPT_UNTRACKED_COUNT="false"
ZSH_THEME_VCS_PROMPT_ADDED="%K{002}%F{000} A %k%f"
ZSH_THEME_VCS_PROMPT_ADDED_COUNT="false"
ZSH_THEME_VCS_PROMPT_DELETED="%K{001}%F{000} D %k%f"
ZSH_THEME_VCS_PROMPT_DELETED_COUNT="false"
ZSH_THEME_VCS_PROMPT_RENAMED="%K{004}%F{000} R %k%f"
ZSH_THEME_VCS_PROMPT_RENAMED_COUNT="false"
ZSH_THEME_VCS_PROMPT_MODIFIED="%K{003}%F{000} M %k%f"
ZSH_THEME_VCS_PROMPT_MODIFIED_COUNT="false"
ZSH_THEME_VCS_PROMPT_UNMERGED="%K{006}%F{000} = %k%f"
ZSH_THEME_VCS_PROMPT_UNMERGED_COUNT="false"
ZSH_THEME_VCS_PROMPT_STASHED="%K{007}%F{000} S %k%f"
ZSH_THEME_VCS_PROMPT_STASHED_COUNT="false"

# ------------------------------------------------------------------------------
# MAIN
# Entry point
# ------------------------------------------------------------------------------

PROMPT='
$(username)$(directory)$(print_vcs_info)
$(prompt_indicator) '

RPROMPT='$(current_time)'

