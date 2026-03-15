#!/usr/bin/env bash
# agent-writer.sh — Writes a generated agent file to .claude/agents/
#
# Usage: ./agent-writer.sh <filename> <content>
# Or pipe content: echo "content" | ./agent-writer.sh <filename>
#
# This script:
# 1. Creates .claude/agents/ if it doesn't exist
# 2. Checks for existing agent files and warns about overwrites
# 3. Writes the agent file
# 4. Reports success with the full path

set -euo pipefail

AGENTS_DIR=".claude/agents"
FILENAME="${1:?Usage: agent-writer.sh <filename.md> [content]}"

# Ensure .md extension
if [[ "$FILENAME" != *.md ]]; then
    FILENAME="${FILENAME}.md"
fi

FILEPATH="${AGENTS_DIR}/${FILENAME}"

# Create agents directory
mkdir -p "$AGENTS_DIR"

# Check for existing file
if [[ -f "$FILEPATH" ]]; then
    echo "⚠️  Agent file already exists: ${FILEPATH}"
    echo "    Backing up to: ${FILEPATH}.bak"
    cp "$FILEPATH" "${FILEPATH}.bak"
fi

# Write content — either from argument or stdin
if [[ -n "${2:-}" ]]; then
    echo "$2" > "$FILEPATH"
elif [[ ! -t 0 ]]; then
    cat > "$FILEPATH"
else
    echo "Error: No content provided. Pass as argument or pipe to stdin."
    exit 1
fi

# Report
LINES=$(wc -l < "$FILEPATH")
echo "✅ Agent written: ${FILEPATH} (${LINES} lines)"
echo "   Claude Code will pick this up in new sessions."
