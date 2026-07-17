import type { Plugin } from "@opencode-ai/plugin"
import * as fs from "fs/promises"
import { existsSync } from "fs"
import * as path from "path"

const SEARCH_COMMAND_REGEX = /\b(grep|egrep|fgrep|rg|ag|ack|find|fd)\b/i
const MARKER_REGEX = /<!--\s*codebase-memory-mcp:start\s*-->([\s\S]*?)<!--\s*codebase-memory-mcp:end\s*-->/

export const CodebaseMemoryReminderPlugin: Plugin = async ({ directory, $ }) => {
  try {
    await $`which codebase-memory-mcp`.quiet()
  } catch {
    console.warn("codebase-memory-mcp binary not found in PATH — plugin disabled")
    return {}
  }

  // Target folder setup — ensure directory exists
  const workspaceRoot = directory || process.cwd()
  const agentsFilePath = path.join(workspaceRoot, "AGENTS.md")

  let reminder: string | null = null

  try {
    if (existsSync(agentsFilePath)) {
      const fileContent = await fs.readFile(agentsFilePath, "utf8")
      const match = fileContent.match(MARKER_REGEX)

      if (match?.[1]?.trim()) {
        const rawInstructions = match[1].trim()

        reminder = [
          "# ========================================================================",
          "#  REMINDER: ACTIVE KNOWLEDGE GRAPH DETECTED IN THIS CODEBASE",
          "# ========================================================================",
          ...rawInstructions.split("\n").map(line => `# ${line}`),
          "# ========================================================================",
          "", // Blank line before the original command
        ].join("\n")
      }
    }
  } catch {
    // Ignore initialization failures and run without reminders.
  }

  return {
    "tool.execute.before": async (input, output) => {
      if (!reminder) return

      const tool = String(input?.tool ?? "").toLowerCase()
      if (tool !== "bash" && tool !== "shell") return

      const args = output?.args
      if (!args || typeof args !== "object") return

      const shellArgs = args as Record<string, unknown>

      const command = shellArgs.command
      if (typeof command !== "string" || command.length === 0) return

      if (!SEARCH_COMMAND_REGEX.test(command)) return

      shellArgs.command = `${reminder}${command}`
    },
  }
}