#!/usr/bin/env bash

function util::is_git_project
{
    local target_dir="$1"

    if command -v git >/dev/null 2>&1
    then
        git -C "$target_dir" rev-parse --is-inside-work-tree >/dev/null 2>&1
        return $?
    fi

    return 1
}

function util::command_exists
{
    command -v "$1" >/dev/null 2>&1
}

# Fetch script content (local file preferred, fall back to GitHub)
function util::get_script_content
{
    local relative_path="$1"
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local local_path="$script_dir/../../$relative_path"

    if [[ -f "$local_path" ]]
    then
        cat "$local_path"
        return 0
    fi

    # If not found locally, try to fetch from GitHub
    local github_url="https://raw.githubusercontent.com/DuckKota/OpenCode-Bootstrapper/refs/heads/main/$relative_path"
    local content
    if content=$(curl -fsSL "$github_url")
    then
        echo "$content"
        return 0
    fi

    echo "Error: Failed to download script '$relative_path'." >&2
    return 1
}

function util::write_script_to_file
{
    if (( $# < 2 ))
    then
        echo "Error: Missing arguments." >&2
        exit 1
    fi

    local relative_path="$1"
    local target_path="$2"
    local mode="${3:-'--overwrite'}"

    local content
    if ! content=$(util::get_script_content "$relative_path")
    then
        exit 1
    fi

    local target_dir
    target_dir="$(dirname $target_path)"
    if [[ ! -d "$target_dir" ]]
    then
        mkdir -p "$target_dir"
    fi

    case "$mode" in
        --append|-a)
            echo "$content" >> "$target_path"
            ;;
        --overwrite|-o)
            echo "$content" > "$target_path"
            ;;
        *)
            echo "Error: Invalid mode '$mode'. Use '--overwrite' (-o) or '--append' (-a)." >&2
            exit 1
            ;;
    esac
}
