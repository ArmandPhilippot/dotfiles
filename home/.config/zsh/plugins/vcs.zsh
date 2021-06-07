#!/bin/zsh
#
# vcs.zsh
#
# Display information about version control system.

# ------------------------------------------------------------------------------
# Customization
# All variables with defaults that can be overrided to customize the prompt.
# ------------------------------------------------------------------------------

# Define active VCS
[ -v ZSH_THEME_VCS_ENABLED ] || ZSH_THEME_VCS_ENABLED=(git)

# Customize VCS info output
ZSH_THEME_VCS_PROMPT_BRANCH_PREFIX=${ZSH_THEME_VCS_PROMPT_BRANCH_PREFIX=""}
ZSH_THEME_VCS_PROMPT_BRANCH_SUFFIX=${ZSH_THEME_VCS_PROMPT_BRANCH_SUFFIX=""}
ZSH_THEME_VCS_PROMPT_ACTION_PREFIX=${ZSH_THEME_VCS_PROMPT_ACTION_PREFIX=""}
ZSH_THEME_VCS_PROMPT_ACTION_SUFFIX=${ZSH_THEME_VCS_PROMPT_ACTION_SUFFIX=""}
ZSH_THEME_VCS_PROMPT_UNTRACKED=${ZSH_THEME_GIT_UNTRACKED="✭"}
ZSH_THEME_VCS_PROMPT_UNTRACKED_COUNT=${ZSH_THEME_GIT_UNTRACKED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_ADDED=${ZSH_THEME_GIT_ADDED="✚"}
ZSH_THEME_VCS_PROMPT_ADDED_COUNT=${ZSH_THEME_GIT_ADDED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_DELETED=${ZSH_THEME_GIT_DELETED="✖"}
ZSH_THEME_VCS_PROMPT_DELETED_COUNT=${ZSH_THEME_GIT_DELETED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_RENAMED=${ZSH_THEME_GIT_RENAMED="➜"}
ZSH_THEME_VCS_PROMPT_RENAMED_COUNT=${ZSH_THEME_GIT_RENAMED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_MODIFIED=${ZSH_THEME_GIT_MODIFIED="✹"}
ZSH_THEME_VCS_PROMPT_MODIFIED_COUNT=${ZSH_THEME_GIT_MODIFIED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_UNMERGED=${ZSH_THEME_GIT_UNMERGED="═"}
ZSH_THEME_VCS_PROMPT_UNMERGED_COUNT=${ZSH_THEME_GIT_UNMERGED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_STASHED=${ZSH_THEME_GIT_STASHED="⚑"}
ZSH_THEME_VCS_PROMPT_STASHED_COUNT=${ZSH_THEME_GIT_STASHED_COUNT="true"}
ZSH_THEME_VCS_PROMPT_DIRTY=${ZSH_THEME_GIT_DIRTY="✗"}
ZSH_THEME_VCS_PROMPT_CLEAN=${ZSH_THEME_GIT_CLEAN="✔"}

# Customize Git prompt order. Segments can be reordered or deleted.
ZSH_THEME_GIT_PROMPT_ORDER=(
  prompt_git_branch
  prompt_git_state
  prompt_git_untracked_count
  prompt_git_untracked
  prompt_git_added_count
  prompt_git_added
  prompt_git_deleted_count
  prompt_git_deleted
  prompt_git_modified_count
  prompt_git_modified
  prompt_git_renamed_count
  prompt_git_renamed
  prompt_git_unmerged_count
  prompt_git_unmerged
  prompt_git_stashed_count
  prompt_git_stashed
)

# ------------------------------------------------------------------------------
# Git helpers
# ------------------------------------------------------------------------------

# Use git with `--no-optional-locks` option.
call_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Determine if git has [untracked, staged...] files by providing a count.
git_has() {
  [ $# -ne 1 ] && return
  [ $($1) -gt 0 ]
}

is_git_dir() {
  call_git rev-parse --git-dir &> /dev/null
}

get_git_status() {
  call_git status --porcelain
}

# ------------------------------------------------------------------------------
# Git info
# ------------------------------------------------------------------------------

get_branch_name() {
  call_git symbolic-ref --quiet --short HEAD
}

get_current_ref() {
  call_git rev-parse --short HEAD
}

is_dirty() {
  [ $(get_git_status | wc -l) -ne 0 ]
}

untracked_files() {
  get_git_status | grep "^??" | wc -l
}

staged_files() {
  get_git_status | grep "^A" | wc -l
}

deleted_files() {
  get_git_status | grep "^.D" | wc -l
}

renamed_files() {
  get_git_status | grep "^R" | wc -l
}

modified_files() {
  get_git_status | grep "^.M" | wc -l
}

unmerged_files() {
  call_git ls-files --unmerged | wc -l
}

stashed_files() {
  call_git stash list | wc -l
}

# ------------------------------------------------------------------------------
# Git prompt segments
# ------------------------------------------------------------------------------

prompt_git_branch() {
  local ref
  ref=$(get_branch_name)
  [ $? != 0 ] && ref=$(get_current_ref)
  print -n ${ZSH_THEME_VCS_PROMPT_BRANCH_PREFIX}${ref}${ZSH_THEME_VCS_PROMPT_BRANCH_SUFFIX}
}

prompt_git_state() {
  is_dirty && print -n $ZSH_THEME_VCS_PROMPT_DIRTY || print -n $ZSH_THEME_VCS_PROMPT_CLEAN
}

prompt_git_untracked() {
  git_has untracked_files && print -n $ZSH_THEME_VCS_PROMPT_UNTRACKED
}

prompt_git_untracked_count() {
  [ $ZSH_THEME_VCS_PROMPT_UNTRACKED_COUNT = "true" ] && [ $(untracked_files) -gt 0 ] && print -n $(untracked_files)
}

prompt_git_added() {
  git_has staged_files && print -n $ZSH_THEME_VCS_PROMPT_ADDED
}

prompt_git_added_count() {
  [ $ZSH_THEME_VCS_PROMPT_ADDED_COUNT = "true" ] && [ $(staged_files) -gt 0 ] && print -n $(staged_files)
}

prompt_git_deleted() {
  git_has deleted_files && print -n $ZSH_THEME_VCS_PROMPT_DELETED
}

prompt_git_deleted_count() {
  [ $ZSH_THEME_VCS_PROMPT_DELETED_COUNT = "true" ] && [ $(deleted_files) -gt 0 ] && print -n $(deleted_files)
}

prompt_git_renamed() {
  git_has renamed_files && print -n $ZSH_THEME_VCS_PROMPT_RENAMED
}

prompt_git_renamed_count() {
  [ $ZSH_THEME_VCS_PROMPT_RENAMED_COUNT = "true" ] && [ $(renamed_files) -gt 0 ] && print -n $(renamed_files)
}

prompt_git_modified() {
  git_has modified_files && print -n $ZSH_THEME_VCS_PROMPT_MODIFIED
}

prompt_git_modified_count() {
  [ $ZSH_THEME_VCS_PROMPT_MODIFIED_COUNT = "true" ] && [ $(modified_files) -gt 0 ] && print -n $(modified_files)
}

prompt_git_unmerged() {
  git_has unmerged_files && print -n $ZSH_THEME_VCS_PROMPT_UNMERGED
}

prompt_git_unmerged_count() {
  [ $ZSH_THEME_VCS_PROMPT_UNMERGED_COUNT = "true" ] && [ $(unmerged_files) -gt 0 ] && print -n $(unmerged_files)
}

prompt_git_stashed() {
  git_has stashed_files && print -n $ZSH_THEME_VCS_PROMPT_STASHED
}

prompt_git_stashed_count() {
  [ $ZSH_THEME_VCS_PROMPT_STASHED_COUNT = "true" ] && [ $(stashed_files) -gt 0 ] && print -n $(stashed_files)
}

# ------------------------------------------------------------------------------
# VCS info
# Define enabled VCS and VCS info formats.
# ------------------------------------------------------------------------------

# Specific format for Git
git_format() {
  ! is_git_dir && return
  for prompt_segment in "${ZSH_THEME_GIT_PROMPT_ORDER[@]}"; do
    $prompt_segment
  done
}

# Branch format for all VCS except Git
branch_format() {
    echo "${ZSH_THEME_VCS_PROMPT_BRANCH_PREFIX}%b${ZSH_THEME_VCS_PROMPT_BRANCH_SUFFIX}"
}

# Status format for all VCS except Git
status_format() {
    echo "%u%c%m"
}

# Action format for all VCS except Git
action_format() {
    echo "${ZSH_THEME_VCS_PROMPT_ACTION_PREFIX}%a${ZSH_THEME_VCS_PROMPT_ACTION_SUFFIX}"
}

set_vcs_parameters() {
    zstyle ':vcs_info:*:*' formats "$(branch_format)$(status_format)"
    zstyle ':vcs_info:*:*' actionformats "$(branch_format)$(action_format)$(status_format)"
    zstyle ':vcs_info:*:*' unstagedstr $ZSH_THEME_VCS_PROMPT_DELETED
    zstyle ':vcs_info:*:*' stagedstr $ZSH_THEME_VCS_PROMPT_ADDED
    zstyle ':vcs_info:*:*' check-for-changes true
    zstyle ':vcs_info:git:*' formats "$(git_format)"
    zstyle ':vcs_info:git:*' actionformats "$(git_format)"
}

enable_vcs() {
    local vcs_list=""
    local sep=""
    setopt prompt_subst
    autoload -Uz vcs_info
    for vcs ($ZSH_THEME_VCS_ENABLED); do
        vcs_list="${vcs_list}${sep}${vcs}"
        sep=" "
    done
    zstyle ':vcs_info:*' enable $vcs_list
    set_vcs_parameters
}

precmd() {
  if [ ${#ZSH_THEME_VCS_ENABLED[@]} -gt 0 ]; then
    enable_vcs
    vcs_info
  fi
}
