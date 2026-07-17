---
description: Generate Conventional Commit Message
---

# Purpose

Generate a high-quality Conventional Commit message from the currently staged Git changes.

The AI **must never perform the commit** or execute any mutating Git commands. Its responsibility is limited to:

1. Inspecting the staged changes.
2. Determining the correct Conventional Commit metadata.
3. Generating the commit message.
4. Providing the exact `git commit` command for the user to copy and run.

---

# Workflow

Follow these steps **in order**. Do not skip or reorder them.

## 1. Verify staged changes

Inspect the staged changes by running:

```bash
git diff --cached
```

If no staged changes exist:

* Stop immediately.
* Inform the user that no changes are staged.
* Suggest staging files first (for example, `git add .`).
* Do **not** inspect unstaged changes.
* Do **not** continue.

---

## 2. Determine the issue number

Inspect the current branch name:

```bash
git branch --show-current
```

Look for an issue reference using common branch naming conventions, such as:

* `123-description`
* `issue-123`
* `feature/123-description`
* `fix/123-description`
* `#123`

The issue number is **mandatory**.

If no issue number can be determined:

* Stop immediately.
* Ask the user for the issue number.
* Never invent, estimate, or omit it.

---

## 3. Classify the change

Determine the appropriate Conventional Commit type.

Allowed types:

* build
* chore
* ci
* dep
* docs
* feat
* fix
* perf
* refactor
* revert
* style
* test

Choose the single type that best represents the primary purpose of the staged changes.

---

## 4. Determine the scope

Determine whether a scope should be included.

Include a scope only when the staged changes clearly belong to one distinct high-level component.

Examples:

* parser
* installer
* pipeline
* docs
* api

Rules:

* lowercase
* kebab-case
* omit the scope for cross-cutting or global changes

---

## 5. Write the summary

Write a concise one-line summary.

Requirements:

* imperative mood
* present tense
* begins with a lowercase letter
* no trailing period
* target 50 characters or fewer
* hard maximum of 72 characters

---

## 6. Write the body

The body is **required**.

Explain:

* what changed
* why it changed
* important technical decisions
* expected impact

Do not simply restate the summary.

Wrap body lines at 72 characters.

---

## 7. Determine the footer

A footer is **required**.

Select the GitLab closing keyword using this mapping:

* `fix` → `Fixes`
* `feat` → `Implements`
* all other commit types → `Closes`

Append the mandatory issue number.

Examples:

```text
Fixes #123
Implements #456
Closes #789
```

Never omit the footer.

---

## 8. Validate the commit

Before producing the final answer:

* verify the summary length
* verify the body exists
* verify the footer exists
* verify the footer contains the issue number
* verify the footer uses the correct GitLab keyword

If shell tools are available, use them to verify the first-line length.

If they are unavailable, defensively target 50–60 characters.

If validation fails, correct the commit message before presenting it.

---

# Commit Format

Every commit must follow this structure:

```text
<type>(<scope>): <summary>

<body>

<footer>
```

If no scope is appropriate:

```text
<type>: <summary>
```

---

# Output

Return **only**:

1. The completed commit message inside a fenced code block.

2. The exact copy-pasteable command:

```bash
git commit -m "<type>(<scope>): <summary>" \
           -m "<body>" \
           -m "<footer>"
```

Use multiple `-m` flags for maximum shell compatibility.

Do **not** execute:

* `git commit`
* `git push`
* any mutating Git command

---

# Final Verification Checklist

Before responding, verify every item below.

* ✓ Staged changes were inspected.
* ✓ An issue number exists.
* ✓ A valid Conventional Commit type was selected.
* ✓ The scope is valid or intentionally omitted.
* ✓ The summary is present.
* ✓ The summary is no longer than 72 characters.
* ✓ The body is present.
* ✓ The footer is present.
* ✓ The footer contains the issue number.
* ✓ The footer uses the correct GitLab closing keyword.
* ✓ The generated command includes three `-m` arguments.

If **any** item cannot be verified, stop and explain the problem instead of making assumptions.
