#!/usr/bin/env bash

# This list is often referred to as the "Bash Unofficial Strict Mode"
set -euo pipefail

# --------------------------------------------
# Internal: Log Level Mapping
# --------------------------------------------

# Internal: Maps a string log level to an integer for comparison.
# Arguments:
#   $1  level  — string level (e.g. INFO, WARN)
# Outputs:
#   Integer value printed to stdout
function _log::level_to_int
{
    case "$1" in
        DEBUG) echo 10 ;;
        INFO)  echo 20 ;;
        SUCCESS) echo 25 ;;
        WARN)  echo 30 ;;
        ERROR) echo 40 ;;
        OFF)   echo 100 ;;
        *)     echo 20 ;;  # Default to INFO
    esac
}

# Internal: Determines if a given level meets the current LOG_LEVEL threshold.
# Arguments:
#   $1  msg_level  — string level of the current message
# Outputs:
#   None (Side effects: returns 0 if should log, 1 if silenced)
function _log::should_log
{
    local msg_level="$1"
    local current_level="${LOG_LEVEL:-INFO}"

    local msg_int
    msg_int=$(_log::level_to_int "$msg_level")
    local current_int
    current_int=$(_log::level_to_int "$current_level")

    (( msg_int >= current_int ))
}

# --------------------------------------------
# Internal: Formatting
# --------------------------------------------

# Internal: Generates a standard timestamp.
# Arguments:
#   None
# Outputs:
#   Formatted timestamp string printed to stdout
function _log::timestamp
{
    date +"%m-%d-%Y %H:%M:%S"
}

# Internal: Formats a log level string with terminal ANSI colors.
# Arguments:
#   $1  level  — string level (e.g. ERROR)
# Outputs:
#   Color-formatted level string printed to stdout
function _log::format_level
{
    local level="$1"
    local level_color

    case "$level" in
        DEBUG) level_color="36" ;;    # Cyan
        INFO)  level_color="34" ;;    # Blue
        SUCCESS) level_color="32" ;;  # Green
        WARN)  level_color="33" ;;    # Yellow
        ERROR) level_color="31" ;;    # Red
        *)     level_color="0" ;;     # No color
    esac

    echo -e "\033[${level_color}m${level}\033[0m"
}

# Internal: Constructs the fully formatted log message.
# Arguments:
#   $1  level    — string level
#   $2  message  — the raw log text
# Outputs:
#   Prefixed and colored log line printed to stdout
function _log::format_message
{
    local level="$1"
    local message="$2"
    
    local timestamp
    timestamp=$(_log::timestamp)
    local formatted_level
    formatted_level=$(_log::format_level "$level")
    
    echo "[$timestamp] [$formatted_level] $message"
}

# --------------------------------------------
# Internal: Output Routing
# --------------------------------------------

# Internal: Handles the routing of the log message to stdout/stderr and file.
# Arguments:
#   $1  level    — string level
#   $2  message  — the raw log text
# Outputs:
#   Text sent to the appropriate outputs
function _log::write
{
    local level="$1"
    local message="$2"
    
    local formatted
    formatted="$(_log::format_message "$level" "$message")"

    # if level and message are blank, override formatted to be empty.
    # This is used by log::newline
    [[ -z "$level" ]] && [[ -z "$message" ]] && formatted=""

    # Send all log output to stderr to keep stdout clean for program output.
    # This allows safe use of command substitution $(...) and piping without
    # mixing logs into data streams.
    echo -e "$formatted" >&2
}

# --------------------------------------------
# Public API
# --------------------------------------------

# Prints a debug level log message.
# Arguments:
#   $@  — the message text
# Outputs:
#   Formatted message directed to stdout if threshold allows
function log::debug
{
    if _log::should_log "DEBUG"
    then
        _log::write "DEBUG" "$*"
    fi
}

# Prints an info level log message.
# Arguments:
#   $@  — the message text
# Outputs:
#   Formatted message directed to stdout if threshold allows
function log::info
{
    if _log::should_log "INFO"
    then
        _log::write "INFO" "$*"
    fi
}

# Prints a success level log message.
# Arguments:
#   $@  — the message text
# Outputs:
#   Formatted message directed to stdout if threshold allows
function log::success
{
    if _log::should_log "SUCCESS"
    then
        _log::write "SUCCESS" "$*"
    fi
    
}

# Prints a warning level log message.
# Arguments:
#   $@  — the message text
# Outputs:
#   Formatted message directed to stderr if threshold allows
function log::warn
{
    if _log::should_log "WARN"
    then
        _log::write "WARN" "$*"
    fi
}

# Prints an error level log message.
# Arguments:
#   $@  — the message text
# Outputs:
#   Formatted message directed to stderr if threshold allows
function log::error
{
    if _log::should_log "ERROR"
    then
        _log::write "ERROR" "$*"
    fi
}

# --------------------------------------------
# Convenience Helpers
# --------------------------------------------

# Prints an error message and instantly terminates the process.
# Arguments:
#   $@  — the error message text
# Outputs:
#   Formatted message directed to stderr (Side effects: exits with code 1)
function log::die
{
    log::error "$*"
    exit 1
}

# Prints a formatted section header.
# Arguments:
#   $@  — the section title text
# Outputs:
#   Formatted header block directed to stdout
function log::section
{
    log::newline
    log::info "==== $* ===="
    log::newline
}

# Prints an empty newline matching the log file destination.
# Arguments:
#   None
# Outputs:
#   Empty newline sent to outputs
function log::newline
{
    _log::write "" ""
}

# Prints a boxed message with a border around it.
# Arguments:
#   $@  — the message lines to be boxed
# Outputs:
#   Formatted boxed message directed to stdout
function log::box
{
    (( $# == 0 )) && return

    local max_len=0
    local line

    for line in "$@"
    do
        if (( ${#line} > $max_len ))
        then
            max_len=${#line}
        fi
    done

    local border_len=$((max_len + 4))
    local top_border="╔$(printf '═%.0s' $(seq 1 $((border_len - 2))))╗"
    local bottom_border="╚$(printf '═%.0s' $(seq 1 $((border_len - 2))))╝"

    echo "$top_border"
    for line in "$@"
    do
        local pad_len=$((max_len - ${#line}))
        local padding=$(printf '%*s' $pad_len "")
        echo "║ ${line}${padding} ║"
    done
    echo "$bottom_border"
}