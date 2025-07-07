# arphi theme for ZSH
# v1.0.0
# MIT License
#
# NOTE: This is a personal theme. I'll try to follow semver to inform about
# changes types but the appearance would probably change between two majors and
# maybe between two minors. So be aware of that if you want to use it.
#
# Inspired by the following themes: agnoster, pure
# Tested on EndeavourOS only.
#
# Cheat Sheet:
# %(condition_char.true-text.false-text)    define a ternary expression
# %~                                        current path
# %B                                        enable boldness
# %b                                        reset boldness
# %F{color}                                 set foreground color
# %f                                        reset foreground color
# %K{color}                                 set background color
# %k                                        reset background color
# %m                                        short hostname
# %n                                        username
# %T                                        time

# Ensure required Zsh modules are available
zmodload zsh/datetime 2>/dev/null

# Define a default if variable is not set
_arphi_default() {
  if ! typeset -p "$1" &>/dev/null; then
    typeset -g "$1=$2"
  fi
}

# ------------------------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------------------------

# Command tracking
_arphi_default ARPHI_CMD_DURATION_THRESHOLD_SEC "1.0"

# Component symbols
_arphi_default ARPHI_SYMBOL_BACKGROUND_JOBS       "⚙"
_arphi_default ARPHI_SYMBOL_CMD_DURATION          "🗲" # ⏲ and ⏱ are too small
_arphi_default ARPHI_SYMBOL_NODE                  "⬢"
_arphi_default ARPHI_SYMBOL_PROMPT_INDICATOR      "❭"
_arphi_default ARPHI_SYMBOL_RETURN_STATUS         "↳"

# Git symbols
_arphi_default ARPHI_SYMBOL_GIT_AHEAD             "⇡"
_arphi_default ARPHI_SYMBOL_GIT_BEHIND            "⇣"
_arphi_default ARPHI_SYMBOL_GIT_BRANCH            ""
_arphi_default ARPHI_SYMBOL_GIT_CLEAN             "✓"
_arphi_default ARPHI_SYMBOL_GIT_CONFLICT          "⚔"
_arphi_default ARPHI_SYMBOL_GIT_DELETED           "⛌" # or ⛌
_arphi_default ARPHI_SYMBOL_GIT_MODIFIED          "!"
_arphi_default ARPHI_SYMBOL_GIT_STAGED            "🞦"
_arphi_default ARPHI_SYMBOL_GIT_STASH             "≡"
_arphi_default ARPHI_SYMBOL_GIT_STATUS_SEPARATOR  " "  # or │ not sure yet
_arphi_default ARPHI_SYMBOL_GIT_UNTRACKED         "?"

# Colors - organized by component
_arphi_default ARPHI_COLOR_BACKGROUND_JOBS_BG         "007"
_arphi_default ARPHI_COLOR_BACKGROUND_JOBS_FG         "000"
_arphi_default ARPHI_COLOR_CMD_DURATION_BG            "014"
_arphi_default ARPHI_COLOR_CMD_DURATION_FG            "000"
_arphi_default ARPHI_COLOR_CONTEXT_BG                 "012"
_arphi_default ARPHI_COLOR_CONTEXT_FG                 "000"
_arphi_default ARPHI_COLOR_CURRENT_DIR_BG             "011"
_arphi_default ARPHI_COLOR_CURRENT_DIR_FG             "000"
_arphi_default ARPHI_COLOR_CURRENT_TIME_BG            "008"
_arphi_default ARPHI_COLOR_CURRENT_TIME_FG            "015"
_arphi_default ARPHI_COLOR_GIT_DATA_BG                "013"
_arphi_default ARPHI_COLOR_GIT_DATA_FG                "000"
_arphi_default ARPHI_COLOR_NODE_VERSION_BG            "010"
_arphi_default ARPHI_COLOR_NODE_VERSION_FG            "000"
_arphi_default ARPHI_COLOR_PROMPT_INDICATOR_BG        ""
_arphi_default ARPHI_COLOR_PROMPT_INDICATOR_FG        "007"
_arphi_default ARPHI_COLOR_PROMPT_INDICATOR_ROOT_BG   "000"
_arphi_default ARPHI_COLOR_PROMPT_INDICATOR_ROOT_FG   "003"
_arphi_default ARPHI_COLOR_RETURN_STATUS_BG           "009"
_arphi_default ARPHI_COLOR_RETURN_STATUS_FG           "000"

# Components length
_arphi_default ARPHI_MAX_BRANCH_LENGTH      "25"
_arphi_default ARPHI_MAX_PATH_LENGTH        "50"
_arphi_default ARPHI_PATH_TRUNCATE_START    "2"
_arphi_default ARPHI_PATH_TRUNCATE_END      "2"

# ------------------------------------------------------------------------------
# GLOBALS
# ------------------------------------------------------------------------------

# Command tracking
typeset -g _ARPHI_CMD_EXIT_CODE=0
typeset -g _ARPHI_CMD_START_TIME=0

# ------------------------------------------------------------------------------
# UTILITY FUNCTIONS
# ------------------------------------------------------------------------------

# Recursively search upward for a file or directory
_arphi_find_up() {
    local name=$1
    local dir=$PWD

    while [[ "$dir" != "/" ]]; do
        [[ -e "$dir/$name" ]] && return 0
        dir=${dir:h}
    done

    return 1
}

# Get the duration of the last command
_arphi_get_command_duration() {
    (( _ARPHI_CMD_START_TIME == 0 )) && return 1

    local duration=$(( EPOCHREALTIME - _ARPHI_CMD_START_TIME ))
    echo "${duration}"
}

# Get display path, truncated if needed
_arphi_get_display_path() {
    local max_length=${1:-$ARPHI_MAX_PATH_LENGTH}
    local current_dir
    current_dir=$(print -P "%~")

    if (( ${#current_dir} > max_length )); then
        _arphi_truncate_path "$current_dir"
    else
        echo "${current_dir}"
    fi
}

# Format duration in human-readable format
_arphi_get_human_readable_duration() {
    local raw=$1
    local integer_part=${raw%.*}
    local decimal_part=${raw#*.}

    # Pad or truncate decimal part to exactly 3 digits (milliseconds)
    decimal_part="${decimal_part}000"  # Pad with zeros
    decimal_part="${decimal_part:0:3}" # Take first 3 digits

    local total_ms=$(( integer_part * 1000 + decimal_part ))

    local ms=$(( total_ms % 1000 ))
    local total_sec=$(( total_ms / 1000 ))
    local sec=$(( total_sec % 60 ))
    local min=$(( (total_sec % 3600) / 60 ))
    local hours=$(( total_sec / 3600 ))

    local result=""
    (( hours > 0 )) && result+="${hours}h"
    (( min > 0 )) && result+="${min}m"
    (( sec > 0 )) && result+="${sec}s"
    (( ms > 0 )) && result+="${ms}ms"

    [[ -z "$result" ]] && result="0ms"
    echo "$result"
}

# Get current Node.js version (cached within session)
_arphi_get_node_version() {
    command -v node &>/dev/null || return 0
    node -v
}

# Check if current directory is a Node.js project
_arphi_is_node_project() {
    _arphi_find_up package.json ||
    _arphi_find_up node_modules ||
    _arphi_find_up .nvmrc
}

# Check if current session is a remote connection
_arphi_is_remote_connection() {
    [[ -n "$SSH_CLIENT" || -n "$SSH_TTY" || -n "$SSH_CONNECTION" ]]
}

# Truncate string in the middle when it exceeds max_length
_arphi_truncate_string() {
    local str=$1
    local max_length=$2

    (( ${#str} <= max_length )) && { echo "$str"; return; }

    # Calculate chars for each side (subtract 3 for "...")
    local available_chars=$((max_length - 3))
    local start_chars=$((available_chars / 2))
    local end_chars=$((available_chars - start_chars))

    echo "${str:0:$start_chars}...${str: -$end_chars}"
}

# Truncate path by shortening middle directories to first character
_arphi_truncate_path() {
    local path=$1
    local keep_start=${2:-$ARPHI_PATH_TRUNCATE_START}
    local keep_end=${3:-$ARPHI_PATH_TRUNCATE_END}

    local path_parts=("${(@s:/:)path}")
    local total_parts=${#path_parts[@]}

    # Need enough parts to make truncation worthwhile
    (( total_parts <= keep_start + keep_end + 1 )) && { echo "$path"; return; }

    local result=()

    # Keep start parts full
    for ((i=1; i<=keep_start; i++)); do
        result+=("${path_parts[i]}")
    done

    # Truncate middle parts to first character
    for ((i=keep_start+1; i<=total_parts-keep_end; i++)); do
        local part="${path_parts[i]}"
        [[ -n "$part" ]] && result+=("${part[1]}")
    done

    # Keep end parts full
    for ((i=total_parts-keep_end+1; i<=total_parts; i++)); do
        result+=("${path_parts[i]}")
    done

    echo "${(j:/:)result}"
}

# ------------------------------------------------------------------------------
# GIT FUNCTIONS
# ------------------------------------------------------------------------------

# Get short commit hash with optional prefix
_arphi_get_commit_hash() {
    local prefix=${1:-""}
    local commit_hash

    commit_hash=$(git rev-parse --short HEAD 2>/dev/null) || return 1
    echo "${prefix}${commit_hash}"
}

# Get git branch or detached commit hash
_arphi_get_git_ref() {
    local max_length=${1:-$ARPHI_MAX_BRANCH_LENGTH}
    local branch_name

    if branch_name=$(git symbolic-ref --short HEAD 2>/dev/null); then
        _arphi_truncate_string "$branch_name" "$max_length"
    else
        _arphi_get_commit_hash "detached:"
    fi
}

# Parse git status and return counts as space-separated values
_arphi_parse_git_status() {
    local git_status
    git_status=$(git status --porcelain --ignore-submodules 2>/dev/null) || return 1

    local staged=0 modified=0 deleted=0 untracked=0 conflicts=0

    [[ -z "$git_status" ]] && { echo "$staged $modified $deleted $untracked $conflicts"; return; }

    while IFS= read -r line; do
        local status_code="${line:0:2}"
        local index_status="${status_code:0:1}"

        case "$status_code" in
            "??") ((untracked++)) ;;
            *"M"*|*"A"*|*"R"*|*"C"*) ((modified++)) ;;
            *"D"*) ((deleted++)) ;;
            "DD"|"AU"|"UD"|"UA"|"DU"|"AA"|"UU") ((conflicts++)) ;;
        esac

        # Count staged files (index status is not space or ?)
        [[ "$index_status" != " " && "$index_status" != "?" ]] && ((staged++))
    done <<< "$git_status"

    echo "$staged $modified $deleted $untracked $conflicts"
}

# Build git status symbols string with separators
_arphi_build_git_status_symbols() {
    local staged=$1 modified=$2 deleted=$3 untracked=$4 conflicts=$5
    local symbols_array=()

    ((staged > 0)) && symbols_array+=("${ARPHI_SYMBOL_GIT_STAGED}${staged}")
    ((conflicts > 0)) && symbols_array+=("${ARPHI_SYMBOL_GIT_CONFLICT}${conflicts}")
    ((modified > 0)) && symbols_array+=("${ARPHI_SYMBOL_GIT_MODIFIED}${modified}")
    ((deleted > 0)) && symbols_array+=("${ARPHI_SYMBOL_GIT_DELETED}${deleted}")
    ((untracked > 0)) && symbols_array+=("${ARPHI_SYMBOL_GIT_UNTRACKED}${untracked}")

    echo "${(j:$ARPHI_SYMBOL_GIT_STATUS_SEPARATOR:)symbols_array}"
}

# Get working tree status symbols
_arphi_get_worktree_status() {
    local counts
    counts=($(_arphi_parse_git_status)) || return 1

    local symbols=$(_arphi_build_git_status_symbols "${counts[@]}")

    echo "${symbols:-$ARPHI_SYMBOL_GIT_CLEAN}"
}

# Get upstream tracking symbols (ahead/behind)
_arphi_get_upstream_status() {
    local upstream counts behind ahead symbols=""

    upstream=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null) || return 0
    counts=$(git rev-list --left-right --count $upstream...HEAD 2>/dev/null) || return 0

    behind="${counts%%$'\t'*}"
    ahead="${counts##*$'\t'}"

    ((ahead > 0)) && symbols+="$ARPHI_SYMBOL_GIT_AHEAD${ahead}"
    ((behind > 0)) && symbols+="$ARPHI_SYMBOL_GIT_BEHIND${behind}"

    echo "${symbols}"
}

# Get stash count symbol
_arphi_get_stash_status() {
    local count
    count=$(git stash list 2>/dev/null | wc -l) || return 0
    ((count > 0)) && echo "${ARPHI_SYMBOL_GIT_STASH}${count}"
}

# Get all git status symbols
_arphi_get_git_status() {
    local parts=()
    local worktree=$(_arphi_get_worktree_status)
    local stash=$(_arphi_get_stash_status)
    local upstream=$(_arphi_get_upstream_status)

    [[ -n "$worktree" ]] && parts+=("$worktree")
    [[ -n "$stash" ]] && parts+=("$stash")
    [[ -n "$upstream" ]] && parts+=("$upstream")

    echo "${(j:$ARPHI_SYMBOL_GIT_STATUS_SEPARATOR:)parts}"
}

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# ------------------------------------------------------------------------------

# Display command duration if it exceeds threshold
arphi_component_command_duration() {
    local bg fg duration human_readable_duration
    bg=${ARPHI_COLOR_CMD_DURATION_BG:+"%K{$ARPHI_COLOR_CMD_DURATION_BG}"}
    fg=${ARPHI_COLOR_CMD_DURATION_FG:+"%F{$ARPHI_COLOR_CMD_DURATION_FG}"}

    duration=$(_arphi_get_command_duration) || return 0
    (( ${duration%.*} < ${ARPHI_CMD_DURATION_THRESHOLD_SEC%.*} )) && return 0

    human_readable_duration=$(_arphi_get_human_readable_duration "$duration")
    print -n "${bg}${fg} ${ARPHI_SYMBOL_CMD_DURATION} ${human_readable_duration} %k%f"
}

# Display user context (user or user@hostname for SSH)
arphi_component_context() {
    local context=$(_arphi_is_remote_connection && echo "%n@%m" || echo "%n")
    local bg=${ARPHI_COLOR_CONTEXT_BG:+"%K{$ARPHI_COLOR_CONTEXT_BG}"}
    local fg=${ARPHI_COLOR_CONTEXT_FG:+"%F{$ARPHI_COLOR_CONTEXT_FG}"}

    print -n "${bg}${fg} ${context} %k%f"
}

# Display current time
arphi_component_current_time() {
    local bg=${ARPHI_COLOR_CURRENT_TIME_BG:+"%K{$ARPHI_COLOR_CURRENT_TIME_BG}"}
    local fg=${ARPHI_COLOR_CURRENT_TIME_FG:+"%F{$ARPHI_COLOR_CURRENT_TIME_FG}"}

    print -n "${bg}${fg} %T %k%f"
}

# Display current working directory
arphi_component_current_dir() {
    local display_path=$(_arphi_get_display_path)
    local bg=${ARPHI_COLOR_CURRENT_DIR_BG:+"%K{$ARPHI_COLOR_CURRENT_DIR_BG}"}
    local fg=${ARPHI_COLOR_CURRENT_DIR_FG:+"%F{$ARPHI_COLOR_CURRENT_DIR_FG}"}

    print -n "${bg}${fg} ${display_path} %k%f"
}

# Display return status when last command failed
arphi_component_return_status() {
    local bg=${ARPHI_COLOR_RETURN_STATUS_BG:+"%K{$ARPHI_COLOR_RETURN_STATUS_BG}"}
    local fg=${ARPHI_COLOR_RETURN_STATUS_FG:+"%F{$ARPHI_COLOR_RETURN_STATUS_FG}"}

    (( _ARPHI_CMD_EXIT_CODE != 0 )) && print -n "${bg}${fg} ${ARPHI_SYMBOL_RETURN_STATUS}${_ARPHI_CMD_EXIT_CODE} %f%k"
}

# Display background jobs indicator
arphi_component_background_jobs() {
  local job_count=${#jobstates}
  local bg=${ARPHI_COLOR_BACKGROUND_JOBS_BG:+"%K{$ARPHI_COLOR_BACKGROUND_JOBS_BG}"}
  local fg=${ARPHI_COLOR_BACKGROUND_JOBS_FG:+"%F{$ARPHI_COLOR_BACKGROUND_JOBS_FG}"}

  (( job_count > 0 )) && print -n "${bg}${fg} ${ARPHI_SYMBOL_BACKGROUND_JOBS} ${job_count} %f%k"
}

# Display Git information
arphi_component_git_data() {
    git rev-parse --git-dir >/dev/null 2>&1 || return 0

    local git_ref=$(_arphi_get_git_ref)
    local status_symbols=$(_arphi_get_git_status)
    local bg=${ARPHI_COLOR_GIT_DATA_BG:+"%K{$ARPHI_COLOR_GIT_DATA_BG}"}
    local fg=${ARPHI_COLOR_GIT_DATA_FG:+"%F{$ARPHI_COLOR_GIT_DATA_FG}"}

    print -n "${bg}${fg} ${ARPHI_SYMBOL_GIT_BRANCH} ${git_ref} ${status_symbols} %k%f"
}

# Display Node.js version if in a Node project
arphi_component_node_version() {
    _arphi_is_node_project || return 0

    local bg fg version
    bg=${ARPHI_COLOR_NODE_VERSION_BG:+"%K{$ARPHI_COLOR_NODE_VERSION_BG}"}
    fg=${ARPHI_COLOR_NODE_VERSION_FG:+"%F{$ARPHI_COLOR_NODE_VERSION_FG}"}
    version=$(_arphi_get_node_version) || return 0

    print -n "${bg}${fg} ${ARPHI_SYMBOL_NODE} ${version} %k%f"
}

# Display prompt indicator
arphi_component_prompt_indicator() {
    local fg bg

    if [[ $EUID -eq 0 ]]; then
        fg=${ARPHI_COLOR_PROMPT_INDICATOR_ROOT_FG:+"%F{$ARPHI_COLOR_PROMPT_INDICATOR_ROOT_FG}"}
        bg=${ARPHI_COLOR_PROMPT_INDICATOR_ROOT_BG:+"%K{$ARPHI_COLOR_PROMPT_INDICATOR_ROOT_BG}"}
    else
        fg=${ARPHI_COLOR_PROMPT_INDICATOR_FG:+"%F{$ARPHI_COLOR_PROMPT_INDICATOR_FG}"}
        bg=${ARPHI_COLOR_PROMPT_INDICATOR_BG:+"%K{$ARPHI_COLOR_PROMPT_INDICATOR_BG}"}
    fi

    print -n "${bg}${fg}${ARPHI_SYMBOL_PROMPT_INDICATOR}%f%k"
}

# ------------------------------------------------------------------------------
# PROMPT SETUP
# ------------------------------------------------------------------------------

# Render all components
_arphi_render_components() {
    local component
    for component in "$@"; do
        [[ -n $component ]] && $component
    done
}

# Hook to store start time before command execution
arphi_prompt_preexec() {
    _ARPHI_CMD_START_TIME=$EPOCHREALTIME
}

# Main prompt construction
arphi_prompt_precmd() {
    # Capture exit code immediately to avoid corruption
    _ARPHI_CMD_EXIT_CODE=$?

    local -a ps1_components=(
        arphi_component_current_time
        arphi_component_context
        arphi_component_current_dir
        arphi_component_git_data
        arphi_component_node_version
        arphi_component_background_jobs
        arphi_component_return_status
        arphi_component_command_duration
    )

    local -a ps2_components=(
        arphi_component_prompt_indicator
    )

    local ps1_output ps2_output
    ps1_output=$(_arphi_render_components "${ps1_components[@]}")
    ps2_output=$(_arphi_render_components "${ps2_components[@]}")

    PROMPT="
${ps1_output}%E
${ps2_output} "
    RPROMPT=""
}

# Theme initialization
arphi_prompt_setup() {
    autoload -Uz add-zsh-hook
    add-zsh-hook preexec arphi_prompt_preexec
    add-zsh-hook precmd arphi_prompt_precmd
}

# Initialize the theme
arphi_prompt_setup "$@"
