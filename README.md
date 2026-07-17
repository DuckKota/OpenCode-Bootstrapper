# OpenCode Bootstrapper

My one-command setup to supercharge a repository with [OpenCode](https://opencode.ai) tooling.

## Usage

Ensure you have git, curl, and bash installed.

Run from the Git repository you want to bootstrap:

```bash
curl -fsSL https://raw.githubusercontent.com/DuckKota/OpenCode-Bootstrapper/refs/heads/main/bin/setup | bash
```

## What It Installs

### Commands

- [x] **[`/commit-message`](./src/commands/commit-message.md)** - A command that analyzes the Git staged changes and writes a meaningful Conventional Commit.
- [ ] **[`/mermaid`](./src/commands/mermaid.md)** - TODO
- [x] **[`/grill-me`](./src/commands/grill-me.md)** - A command that interviews you relentlessly about a plan, decision, or idea. Walks down each branch of the decision tree one question at a time until you reach a shared understanding.
- [x] **[`/handoff`](./src/commands/handoff.md)** - Compacts the current conversation into a handoff document so a fresh agent can pick up where you left off.

### Tools

- [x] **[OpenSpec](https://openspec.dev/)** - A spec-driven workflow framework that lives in your repository alongside code. Specs persist as living documentation.
- [x] **[codebase-memory-mcp](https://deusdata.github.io/codebase-memory-mcp/)** - An MCP server that indexes your codebase into a persistent knowledge graph of functions, classes, call chains, and routes.
- [x] **[rtk](https://www.rtk-ai.app/)** - Compresses command output before it reaches the AI context window.

### Skills

- [ ] **[caveman](./src/skills/caveman.md)** - A response style that strips all filler and keeps only technical substance.
- [ ] **[diagnosing-bugs](./src/skills/diagnosing-bugs/)** - A structured 6-phase process for hard bugs and performance regressions.
- [ ] **[codebase-design](./src/skills/codebase-design/)** - Shared vocabulary and principles for designing deep modules.
- [ ] **[domain-modeling](./src/skills/domain-modeling/)** - Build and sharpen the project's domain model as you design:.
- [ ] **[improve-codebase-architecture](./src/skills/improve-codebase-architecture/)** - Scans the codebase for deepening opportunities.

## Local Development

```bash
git clone https://github.com/DuckKota/OpenCode-Bootstrapper.git
cd OpenCode-Bootstrapper
./bin/setup
```

The script sources files from the local checkout when available, falling back to GitHub raw content.

## License

Apache 2.0
