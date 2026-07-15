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

1. **Verify Staged Changes:** Inspect the staged changes by running:
   ```bash
   git diff --cached
   ```
   If the output is empty, immediately halt. Inform the user that no changes are staged, and suggest staging files first (e.g., `git add .`). Do not attempt to analyze unstaged changes.

2. **Extract or Ask for Issue Number:** 
   - Inspect the current branch name (using `git branch --show-current`) for a structured issue reference (e.g., matching patterns like `123-`, `issue-123`, `closes-123`, `#123`).
   - If no issue number is found in the branch name, **halt and ask the user to provide the issue number** before drafting the commit message. An issue number is strictly mandatory. Never invent or guess an issue number.

3. **Determine Commit Metadata:**
   - Determine the appropriate Conventional Commit type.
   - Determine the scope (lowercase kebab-case, e.g., `ci-pipeline`). Only include a scope if the changes clearly belong to a specific high-level component; omit it entirely for cross-cutting or global changes.
   - Determine the primary purpose of the change (summary).
   - Determine the motivation behind the change (body).

4. **Validate Commit Length:**
   - The entire first line (including type, optional scope, colon, space, and summary) must never exceed 72 characters.
   - If shell tools are available (e.g., `wc -c`), use them to verify the character length of the first line.
   - If shell tools are **not** available, defensively target an internal limit of 50 to 60 characters for the first line to ensure it safely stays under the hard 72-character limit.
   - If the line exceeds the limit, rewrite the summary and validate it again.

# Commit Format

Every commit must follow this structure:

```text
<type>(<scope>): <summary>

<body>

<footer>
```

## Type
Must be one of:
- build, chore, ci, dep, docs, feat, fix, perf, refactor, revert, style, test

## Scope
Optional, lowercase kebab-case. Include only for distinct functional components. Omit for cross-cutting concerns.

## Summary
- Present tense, imperative mood.
- Begins with a lowercase letter.
- No trailing period.
- Target 50 characters or fewer (max 72).

## Body
- **Required.**
- Explains what changed, why it changed, key technical decisions, and impact.
- Avoids filler or simply repeating the summary, focusing strictly on adding analytical value.
- Wrap body lines at 72 characters.

## Footer
- **Required.** Must use a GitLab closing keyword followed by the mandatory issue number.
- Map the keyword dynamically based on the commit type:
  - `fix` -> `Fixes #<issue>`
  - `feat` -> `Implements #<issue>`
  - All other types -> `Closes #<issue>` (or `Resolves #<issue>` if contextually appropriate)

# Output

Return **only**:

1. The completed commit message inside a fenced code block.
2. The exact, copy-pasteable command to execute the commit using multiple `-m` flags to ensure Zsh compatibility, formatted like this:
   ```bash
   git commit -m "<type>(<scope>): <summary>" -m "<body>" -m "<footer>"
   ```

Do **not** execute `git commit`.
Do **not** execute `git push`.
Do **not** modify the repository.