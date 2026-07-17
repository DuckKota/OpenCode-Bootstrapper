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

function util::get_python_exe
{
    if command -v python3 >/dev/null 2>&1 && python3 -c "import json" 2>/dev/null
    then
        echo "python3"
    elif command -v python >/dev/null 2>&1 && python -c "import json" 2>/dev/null
    then
        echo "python"
    fi
}