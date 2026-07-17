# OpenCode Bootstrapper

My one-command setup to supercharge a repository with [OpenCode](https://opencode.ai) tooling.

> [!NOTE]
> This toolkit is my personal, highly opinionated workflow. It is designed to fit my exact development habits, tool preferences, and mental models.
> 
> While it is open and shared in the hope that others might find inspiration or utility from it, please keep in mind that **it is tailored for me**. It won't be a perfect, one-size-fits-all solution for everyone, nor does it try to capture every possible use case. Feel free to explore, fork, and adapt it to make it your own!

## Usage

Ensure you have git, curl, and bash installed.

Run from the Git repository you want to bootstrap:

```bash
curl -fsSL https://raw.githubusercontent.com/DuckKota/OpenCode-Bootstrapper/refs/heads/main/bin/setup | bash
```

## What It Installs

### Commands

- **[`/commit-message`](./src/commands/commit-message.md)** - A command that analyzes the Git staged changes and writes a meaningful Conventional Commit.
- **`/mermaid`** - _coming soon_
- **[`/grill-me`](./src/commands/grill-me.md)** - A command that interviews you relentlessly about a plan, decision, or idea. Walks down each branch of the decision tree one question at a time until you reach a shared understanding.
- **[`/handoff`](./src/commands/handoff.md)** - Compacts the current conversation into a handoff document so a fresh agent can pick up where you left off.

### Tools

- **[OpenSpec](https://openspec.dev/)** - A spec-driven workflow framework that lives in your repository alongside code. Specs persist as living documentation.
- **[codebase-memory-mcp](https://deusdata.github.io/codebase-memory-mcp/)** - An MCP server that indexes your codebase into a persistent knowledge graph of functions, classes, call chains, and routes.
- **[rtk](https://www.rtk-ai.app/)** - Compresses command output before it reaches the AI context window.

### Skills

- **[diagnosing-bugs](./src/skills/diagnosing-bugs/)** - A structured 6-phase process for hard bugs and performance regressions.
- **[codebase-design](./src/skills/codebase-design/)** - Shared vocabulary and principles for designing deep modules.
- **[domain-modeling](./src/skills/domain-modeling/)** - Build and sharpen the project's domain model as you design:.
- **[improve-codebase-architecture](./src/skills/improve-codebase-architecture/)** - Scans the codebase for deepening opportunities.

### Miscellaneous

- **[caveman](./src/instructions/caveman.md)** - A response style that strips all filler and keeps only technical substance.

## Local Development

```bash
git clone https://github.com/DuckKota/OpenCode-Bootstrapper.git
cd OpenCode-Bootstrapper
./bin/setup
```

The script sources files from the local checkout when available, falling back to GitHub raw content.

## License

Apache 2.0
