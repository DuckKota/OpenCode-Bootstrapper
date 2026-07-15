---
description: Generate Conventional Commit Message
---

# Task

Generate a Conventional Commit message from the staged Git changes.

You must:
1. Analyze only staged changes.
2. Generate the commit message.
3. Provide the exact `git commit` command for the user.

You must never:
- execute `git commit`
- execute `git push`
- modify repository files
- inspect unstaged changes as a substitute for staged changes

---

# Execution Workflow

Follow these steps in order.

## Step 1: Verify staged changes

Run:

git diff --cached

If no staged changes exist:

STOP.

Tell the user:
- no staged changes were found
- they should stage changes first (example: `git add .`)

Do not continue.

---

## Step 2: Determine issue number

Run:

git branch --show-current

Extract the issue number from the branch name.

Recognize common formats:

- `123-description`
- `issue-123-description`
- `feature/123-description`
- `fix/123-description`
- `#123`

The issue number is mandatory.

If an issue number cannot be found:

STOP.

Ask the user for the issue number.

Never:
- guess an issue number
- invent an issue number
- omit the issue footer

---

## Step 3: Analyze the change

Determine:

1. Commit type
2. Scope
3. Summary
4. Body
5. Footer

### Commit Type

Choose exactly one:

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

Select the type that best represents the primary purpose of the change.

---

### Scope

Include a scope only when the changes belong to one clear, high-level component.

Rules:

- lowercase
- kebab-case
- omit for global or cross-cutting changes

Examples:

- parser
- installer
- pipeline
- docs
- api-client

---

### Summary

Requirements:

- imperative mood
- present tense
- starts with lowercase letter
- no trailing period
- describes the primary change
- maximum 72 characters

---

### Body

The body is required.

Explain:

- what changed
- why it changed
- important implementation decisions
- impact on users or developers

Do not repeat the summary.

Wrap lines at 72 characters.

---

### Footer

The footer is required.

The footer must contain:

<GitLab keyword> #<issue>

Choose the keyword based on commit type:

- fix: Fixes
- feat: Implements
- all others: Closes

Examples:

Fixes #123

Implements #456

Closes #789

---

# Validation Gate

Before responding, verify all requirements:

- staged changes were inspected
- issue number exists
- commit type is valid
- scope is valid or omitted intentionally
- summary exists
- first line is <=72 characters
- body exists
- footer exists
- footer contains the issue number
- footer uses the correct GitLab keyword

If any validation fails:

Fix it before responding.

---

# Quality Gate

Before responding, ask:

Would this commit make sense six months from now when viewed in
git log without any additional context?

If not:

Fix it before responding.

---

# Output Format

Return only:

1. Commit message

Inside a fenced code block:

<type>(<scope>): <summary>

<body>

<footer>

If no scope:

<type>: <summary>

<body>

<footer>

2. Git command

Provide the exact command:

git commit -m "<subject>" -m "<body>" -m "<footer>"

Use multiple -m flags for shell compatibility.

Do not execute the command.