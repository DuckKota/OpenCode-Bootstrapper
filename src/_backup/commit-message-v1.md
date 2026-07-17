---
description: Generate Conventional Commit Message
---

# Purpose

Generate a high-quality Conventional Commit message based on the currently
staged Git changes.

The AI must **never perform the commit** or execute any mutating Git
commands. Its responsibility is only to analyze the staged changes,
generate the commit message, and provide the exact command for the user
to copy and run.

# Workflow

1. Inspect the staged changes by running:

   ```bash
   git diff --cached
   ```

2. Determine:
   - the appropriate Conventional Commit type
   - an optional scope
   - the primary purpose of the change
   - the motivation behind the change

3. If no issue number is supplied:
   - inspect the current branch name for an issue reference
   - if none exists, ask the user for the issue number
   - never invent or guess an issue number

4. Validate the commit message before presenting it:
   - verify the entire first line does not exceed 72 characters
   - if shell tools are available, use them to verify the length (for example, `wc -c`)
   - if the first line exceeds 72 characters, rewrite the summary and validate it again

# Commit Format

Every commit must follow this structure:

```text
<type>(<scope>): <summary>

<body>

<footer>
```

The entire first line (including the type, optional scope, colon, space, and summary) should target 50 characters or fewer, and must never exceed 72 characters.

## Type

Must be one of:

- build
- chore
- ci
- dep
- docs
- feat
- fix
- perf
- refactor
- revert
- style
- test

## Scope

Optional, but include it whenever the changes clearly belong to a specific
component.

Examples:

- core
- parser
- installer
- pipeline
- docs

## Summary

The summary must:

- be present tense
- use imperative mood
- begin with a lowercase letter
- not end with a period
- clearly describe the primary change
- target **50 characters or fewer**
- never exceed **72 characters**

## Body

The body is **required**.

It should explain:

- what changed
- why it changed
- any important implementation decisions
- user or developer impact, when appropriate

Do not simply restate the summary.

Wrap body lines at 72 characters.

## Footer

A footer that includes a GitLab closing keyword is **required**.

Allowed keywords:

- Closes
- Fixes
- Resolves
- Implements

Example:

```text
Closes #123
```

If no issue exists, ask the user.

# Output

Return **only**:

1. the completed commit message inside a fenced code block

2. the exact command the user can copy and paste to do the commit

Do **not** execute `git commit`.

Do **not** execute `git push`.

Do **not** modify the repository.