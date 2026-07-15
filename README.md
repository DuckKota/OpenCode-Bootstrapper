# OpenCode Bootstrapper

One-command setup to supercharge a repository with [OpenCode](https://opencode.ai) tooling.

## What It Installs

- **`/commit-message`** — Staged diff analyzer enforcing 72-char Conventional Commits
- **OpenSpec** — Spec framework compiling requirements into AI context manifests ([openspec.dev](https://openspec.dev/))
- **CodeGraph** — Local SQLite knowledge graph indexing symbols and call paths ([https://colbymchenry.github.io/codegraph/](https://colbymchenry.github.io/codegraph/))
- **rtk** — Rust CLI proxy filtering and compressing shell tokens by 60-90% ([https://www.rtk-ai.app/](https://www.rtk-ai.app/))
- **Caveman** — Compressed AI response mode (edits `~/.config/opencode/AGENTS.md`)

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/DuckKota/OpenCode-Bootstrapper/refs/heads/main/bin/setup | bash
```

Run from the Git repository you want to bootstrap.

## Prerequisites

- Git, curl, bash 4.2+
- [OpenSpec](https://openspec.dev/)
- [CodeGraph](https://colbymchenry.github.io/codegraph/)
- [rtk](https://www.rtk-ai.app/)

## Local Development

```bash
git clone https://github.com/DuckKota/OpenCode-Bootstrapper.git
cd OpenCode-Bootstrapper
./bin/setup
```

The script sources files from the local checkout when available, falling back to GitHub raw content.

## Project Structure

```
bin/
  |-- setup              # Main bootstrap script
src/
  |-- utils/
  |   |-- _logger.sh       # Colored, leveled logging (debug/info/success/warn/error)
  |   |-- _utils.sh        # Shared helpers (git checks, file fetch, Python detection)
  |-- markdown/
      |-- caveman.md       # Caveman compression style guide
      |-- commit-message.md # /commit-message command definition
openspec/
  |-- config.yaml        # OpenSpec project configuration
```

## License

Apache 2.0
