#!/usr/bin/env zsh
# Agentic Framework Installer — Main Entry Point
# Dispatches to tool-specific installers for Claude Code CLI or Gemini CLI
# Usage: ./install.sh --tool <claude|gemini|all> [--target <dir>] [OPTIONS]

set -euo pipefail

SCRIPT_DIR="${0:A:h}"
TOOL=""
TARGET_DIR="${PWD}"
AGENTS="all"
SKILLS="all"
DRY_RUN=false
UPDATE_MODE=false
CHECK_MODE=false

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

info()  { echo "${BLUE}[INFO]${NC} $1" }
ok()    { echo "${GREEN}[OK]${NC} $1" }
warn()  { echo "${YELLOW}[WARN]${NC} $1" }
error() { echo "${RED}[ERROR]${NC} $1" >&2 }

banner() {
    echo ""
    echo "${BOLD}╔══════════════════════════════════════════════════════╗${NC}"
    echo "${BOLD}║        Agentic Framework Installer v1.0              ║${NC}"
    echo "${BOLD}╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
}

usage() {
    cat <<EOF
Usage: $(basename "$0") --tool <claude|gemini|all> [OPTIONS]

Deploy the agentic framework to your project.

Required:
  --tool <tool>       Target tool: claude, gemini, or all

Options:
  --target <dir>      Target project directory (default: current directory)
  --agents <list>     Agents to install: "all" or comma-separated (default: all)
  --skills <list>     Skills to install: "all" or comma-separated (default: all)
  --update            Refresh framework files without overwriting project config
  --check             Validate existing installation (no changes)
  --dry-run           Show what would be done without making changes
  -h, --help          Show this help

Available agents:
  analysis-expert, plan-expert, implement-expert, debug-expert,
  bug-rca-expert, review-expert, explain-expert, test-design-expert,
  spec-expert, security-expert

Available skills:
  anti-hallucination, green-coding, transparent-reasoning,
  exhaustive-analysis, white-box-tracing, test-case-design,
  error-handling, multi-agent-orchestration, pr-diff-analyzer,
  document-consolidation, workspace-search

Examples:
  $(basename "$0") --tool claude --target ~/projects/my-app
  $(basename "$0") --tool gemini --agents analysis-expert,plan-expert
  $(basename "$0") --tool all --update
  $(basename "$0") --tool claude --check
EOF
    exit 0
}

# --- Parse Arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --tool)    TOOL="$2"; shift 2 ;;
        --target)  TARGET_DIR="$2"; shift 2 ;;
        --agents)  AGENTS="$2"; shift 2 ;;
        --skills)  SKILLS="$2"; shift 2 ;;
        --update)  UPDATE_MODE=true; shift ;;
        --check)   CHECK_MODE=true; shift ;;
        --dry-run) DRY_RUN=true; shift ;;
        -h|--help) usage ;;
        *) error "Unknown option: $1"; echo ""; usage ;;
    esac
done

# --- Validation ---
if [[ -z "$TOOL" ]]; then
    banner
    error "Missing required --tool argument"
    echo ""
    echo "Which tool do you want to install for?"
    echo "  claude  — Claude Code CLI (.claude/ directory + CLAUDE.md)"
    echo "  gemini  — Gemini CLI (single GEMINI.md)"
    echo "  all     — Both tools"
    echo ""
    echo "Run: $(basename "$0") --tool <claude|gemini|all>"
    exit 1
fi

case "$TOOL" in
    claude|gemini|all) ;;
    *) error "Invalid tool: $TOOL. Must be: claude, gemini, or all"; exit 1 ;;
esac

TARGET_DIR="${TARGET_DIR:A}"
if [[ ! -d "$TARGET_DIR" ]]; then
    error "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

# --- Check Mode ---
if [[ "$CHECK_MODE" == true ]]; then
    banner
    info "Checking installation at: $TARGET_DIR"
    echo ""
    local issues=0

    if [[ "$TOOL" == "claude" || "$TOOL" == "all" ]]; then
        echo "Claude Code CLI:"
        [[ -f "$TARGET_DIR/CLAUDE.md" ]] && ok "  CLAUDE.md exists" || { warn "  CLAUDE.md missing"; ((issues++)) }
        [[ -d "$TARGET_DIR/.claude/agents" ]] && ok "  .claude/agents/ exists" || { warn "  .claude/agents/ missing"; ((issues++)) }
        [[ -d "$TARGET_DIR/.claude/skills" ]] && ok "  .claude/skills/ exists" || { warn "  .claude/skills/ missing"; ((issues++)) }
        [[ -d "$TARGET_DIR/.claude/commands" ]] && ok "  .claude/commands/ exists" || { warn "  .claude/commands/ missing"; ((issues++)) }
        local agent_count=$(find "$TARGET_DIR/.claude/agents" -name "*.agent.md" 2>/dev/null | wc -l | tr -d ' ')
        local skill_count=$(find "$TARGET_DIR/.claude/skills" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
        info "  Agents: $agent_count | Skills: $skill_count"
    fi

    if [[ "$TOOL" == "gemini" || "$TOOL" == "all" ]]; then
        echo "Gemini CLI:"
        [[ -f "$TARGET_DIR/GEMINI.md" ]] && ok "  GEMINI.md exists" || { warn "  GEMINI.md missing"; ((issues++)) }
        if [[ -f "$TARGET_DIR/GEMINI.md" ]]; then
            local lines=$(wc -l < "$TARGET_DIR/GEMINI.md" | tr -d ' ')
            info "  GEMINI.md: $lines lines"
            [[ $lines -le 800 ]] && ok "  Size within limit" || warn "  Exceeds 800 line target"
        fi
    fi

    echo ""
    echo "Shared:"
    [[ -f "$TARGET_DIR/.ai-framework/config/project.md" ]] && ok "  Project config exists" || { warn "  Project config missing"; ((issues++)) }

    echo ""
    if [[ $issues -eq 0 ]]; then
        ok "Installation valid — no issues found"
    else
        warn "$issues issue(s) found. Run without --check to fix."
    fi
    exit 0
fi

# --- Execute ---
banner
info "Tool: $TOOL"
info "Target: $TARGET_DIR"
echo ""

# Build args to forward
local forward_args=()
forward_args+=(--target "$TARGET_DIR")
forward_args+=(--agents "$AGENTS")
forward_args+=(--skills "$SKILLS")
[[ "$DRY_RUN" == true ]] && forward_args+=(--dry-run)
[[ "$UPDATE_MODE" == true ]] && forward_args+=(--update)

if [[ "$TOOL" == "claude" || "$TOOL" == "all" ]]; then
    info "═══ Installing for Claude Code CLI ═══"
    "$SCRIPT_DIR/installers/claude-code.sh" "${forward_args[@]}"
    echo ""
fi

if [[ "$TOOL" == "gemini" || "$TOOL" == "all" ]]; then
    info "═══ Installing for Gemini CLI ═══"
    "$SCRIPT_DIR/installers/gemini-cli.sh" "${forward_args[@]}"
    echo ""
fi

ok "Installation complete!"
