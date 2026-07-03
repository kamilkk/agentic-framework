#!/usr/bin/env zsh
# Claude Code CLI Installer
# Deploys the agentic framework to a target project for use with Claude Code CLI
# Usage: ./installers/claude-code.sh [--target <dir>] [--agents all|<list>] [--skills all|<list>]

set -euo pipefail

# --- Configuration ---
SCRIPT_DIR="${0:A:h}"
FRAMEWORK_DIR="${SCRIPT_DIR:h}"
TARGET_DIR="${PWD}"
AGENTS="all"
SKILLS="all"
DRY_RUN=false
UPDATE_MODE=false

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# --- Functions ---
info()  { echo "${BLUE}[INFO]${NC} $1" }
ok()    { echo "${GREEN}[OK]${NC} $1" }
warn()  { echo "${YELLOW}[WARN]${NC} $1" }
error() { echo "${RED}[ERROR]${NC} $1" >&2 }

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Deploy agentic framework for Claude Code CLI.

Options:
  --target <dir>      Target project directory (default: current directory)
  --agents <list>     Agents to install: "all" or comma-separated names (default: all)
  --skills <list>     Skills to install: "all" or comma-separated names (default: all)
  --update            Update framework files without overwriting project config
  --dry-run           Show what would be done without making changes
  -h, --help          Show this help

Examples:
  $(basename "$0") --target ~/projects/my-app
  $(basename "$0") --agents analysis-expert,plan-expert,implement-expert
  $(basename "$0") --update
EOF
    exit 0
}

# --- Parse Arguments ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        --target)  TARGET_DIR="$2"; shift 2 ;;
        --agents)  AGENTS="$2"; shift 2 ;;
        --skills)  SKILLS="$2"; shift 2 ;;
        --update)  UPDATE_MODE=true; shift ;;
        --dry-run) DRY_RUN=true; shift ;;
        -h|--help) usage ;;
        *) error "Unknown option: $1"; usage ;;
    esac
done

# Resolve absolute path
TARGET_DIR="${TARGET_DIR:A}"

# --- Validation ---
if [[ ! -d "$FRAMEWORK_DIR/agents" ]]; then
    error "Framework directory not found. Run from the agentic-framework root."
    exit 1
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    error "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

info "Target: $TARGET_DIR"
info "Agents: $AGENTS"
info "Skills: $SKILLS"
[[ "$DRY_RUN" == true ]] && warn "DRY RUN — no files will be created"

# --- Helper: Copy file if not dry-run ---
deploy_file() {
    local src="$1" dst="$2"
    if [[ "$DRY_RUN" == true ]]; then
        echo "  [dry-run] $dst"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
}

# --- Helper: Write content to file if not dry-run ---
write_file() {
    local dst="$1" content="$2"
    if [[ "$DRY_RUN" == true ]]; then
        echo "  [dry-run] $dst"
        return
    fi
    mkdir -p "$(dirname "$dst")"
    echo "$content" > "$dst"
}

# --- Get list of items to install ---
get_agents_list() {
    if [[ "$AGENTS" == "all" ]]; then
        find "$FRAMEWORK_DIR/agents" -name "*.agent.md" ! -name "_template*" -exec basename {} .agent.md \;
    else
        echo "${AGENTS//,/$'\n'}"
    fi
}

get_skills_list() {
    if [[ "$SKILLS" == "all" ]]; then
        find "$FRAMEWORK_DIR/skills" -mindepth 1 -maxdepth 1 -type d ! -name "_template" -exec basename {} \;
    else
        echo "${SKILLS//,/$'\n'}"
    fi
}

# --- Step 1: Create directory structure ---
info "Creating directory structure..."
for dir in .claude/agents .claude/skills .claude/commands .ai-framework/config; do
    if [[ "$DRY_RUN" == true ]]; then
        echo "  [dry-run] mkdir $TARGET_DIR/$dir"
    else
        mkdir -p "$TARGET_DIR/$dir"
    fi
done
ok "Directory structure ready"

# --- Step 2: Deploy agents ---
info "Deploying agents..."
get_agents_list | while read -r agent; do
    src="$FRAMEWORK_DIR/agents/${agent}.agent.md"
    if [[ -f "$src" ]]; then
        deploy_file "$src" "$TARGET_DIR/.claude/agents/${agent}.agent.md"
        ok "  Agent: $agent"
    else
        warn "  Agent not found: $agent"
    fi
done

# --- Step 3: Deploy skills ---
info "Deploying skills..."
get_skills_list | while read -r skill; do
    src="$FRAMEWORK_DIR/skills/${skill}/SKILL.md"
    if [[ -f "$src" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            echo "  [dry-run] $TARGET_DIR/.claude/skills/${skill}/SKILL.md"
        else
            mkdir -p "$TARGET_DIR/.claude/skills/${skill}"
            cp "$src" "$TARGET_DIR/.claude/skills/${skill}/SKILL.md"
        fi
        ok "  Skill: $skill"
    else
        warn "  Skill not found: $skill"
    fi
done

# --- Step 4: Generate slash commands ---
info "Generating slash commands..."
get_agents_list | while read -r agent; do
    local cmd_name="${agent%%-expert}"
    cmd_name="${cmd_name%%-rca}"
    local agent_file=".claude/agents/${agent}.agent.md"

    # Extract description from agent file
    local desc=""
    if [[ -f "$FRAMEWORK_DIR/agents/${agent}.agent.md" ]]; then
        desc=$(sed -n '/^description:/,/^argument-hint:/{ /^description:/d; /^argument-hint:/d; s/^  //; p; }' "$FRAMEWORK_DIR/agents/${agent}.agent.md" | head -1)
    fi

    local cmd_content="# /${cmd_name}

Activates the **${agent}** agent.

${desc:-See .claude/agents/${agent}.agent.md for details.}

## Usage
Read and follow the full agent protocol in \`${agent_file}\`.
"
    write_file "$TARGET_DIR/.claude/commands/${cmd_name}.md" "$cmd_content"
    ok "  Command: /${cmd_name}"
done

# --- Step 5: Deploy project config (never overwrite) ---
local config_dst="$TARGET_DIR/.ai-framework/config/project.md"
if [[ -f "$config_dst" && "$UPDATE_MODE" == true ]]; then
    warn "Project config exists — preserved (not overwritten)"
elif [[ -f "$config_dst" && "$UPDATE_MODE" == false ]]; then
    warn "Project config exists — preserved (use --update to refresh framework files only)"
else
    deploy_file "$FRAMEWORK_DIR/config/project.template.md" "$config_dst"
    ok "Project config template deployed"
fi

# --- Step 6: Generate CLAUDE.md ---
info "Generating CLAUDE.md..."
generate_claude_md() {
    cat <<'HEADER'
# Project Instructions

> Auto-generated by agentic-framework installer. Customizations below the PROJECT CONFIGURATION section are preserved on updates.

HEADER

    # Section 1: Core Doctrine
    echo "## Core Principles"
    echo ""
    cat "$FRAMEWORK_DIR/core/doctrine.md" | sed -n '/^## Core Directive/,/^## Output File Conventions/{ /^## Output File Conventions/d; p; }'
    echo ""

    # Section 2: Output Conventions
    echo "## Output Conventions"
    echo ""
    cat "$FRAMEWORK_DIR/core/doctrine.md" | sed -n '/^## Output File Conventions/,$p'
    echo ""

    # Section 3: Agent Catalog
    echo "## Available Agents"
    echo ""
    echo "Activate by name or by matching domain keywords. Agent files in \`.claude/agents/\`."
    echo ""
    echo "| Agent | Purpose | Activation |"
    echo "|-------|---------|-----------|"
    get_agents_list | while read -r agent; do
        local desc=""
        if [[ -f "$FRAMEWORK_DIR/agents/${agent}.agent.md" ]]; then
            desc=$(sed -n '/^description:/,/^argument-hint:/{ /^description:/d; /^argument-hint:/d; s/^  //; p; }' "$FRAMEWORK_DIR/agents/${agent}.agent.md" | tr '\n' ' ' | cut -c1-80)
        fi
        echo "| ${agent} | ${desc:-See agent file} | \`/${agent%%-expert}\` |"
    done
    echo ""

    # Section 4: Skill Catalog
    echo "## Available Skills"
    echo ""
    echo "Skills in \`.claude/skills/\`. Always-active skills are applied automatically."
    echo ""
    echo "| Skill | Always Active | Purpose |"
    echo "|-------|:------------:|---------|"
    get_skills_list | while read -r skill; do
        local always="No"
        local purpose=""
        if [[ -f "$FRAMEWORK_DIR/skills/${skill}/SKILL.md" ]]; then
            if grep -q "Always Active.*Yes" "$FRAMEWORK_DIR/skills/${skill}/SKILL.md" 2>/dev/null; then
                always="**Yes**"
            fi
            purpose=$(grep -A1 "^## Purpose" "$FRAMEWORK_DIR/skills/${skill}/SKILL.md" 2>/dev/null | tail -1 | cut -c1-80)
        fi
        echo "| ${skill} | ${always} | ${purpose:-See skill file} |"
    done
    echo ""

    # Section 5: Project Configuration Reference
    echo "## Project Configuration"
    echo ""
    echo "See \`.ai-framework/config/project.md\` for project-specific settings."
    echo ""
    echo "---"
    echo ""
    echo "## References"
    echo ""
    echo "- Core doctrine: \`.claude/agents/\` + \`.claude/skills/\`"
    echo "- Phases: Read \`core/phases/\` files for detailed workflow protocols"
    echo "- Guardrails: Security, anti-hallucination, and YAGNI rules are always active"
}

if [[ "$DRY_RUN" == true ]]; then
    echo "  [dry-run] $TARGET_DIR/CLAUDE.md"
else
    generate_claude_md > "$TARGET_DIR/CLAUDE.md"
fi
ok "CLAUDE.md generated"

# --- Step 7: Deploy core reference files ---
info "Deploying core reference files..."
for phase_file in "$FRAMEWORK_DIR"/core/phases/*.md; do
    deploy_file "$phase_file" "$TARGET_DIR/.claude/skills/_core/phases/$(basename "$phase_file")"
done
for guard_file in "$FRAMEWORK_DIR"/core/guardrails/*.md; do
    deploy_file "$guard_file" "$TARGET_DIR/.claude/skills/_core/guardrails/$(basename "$guard_file")"
done
ok "Core reference files deployed"

# --- Summary ---
echo ""
echo "════════════════════════════════════════════════════════════"
ok "Claude Code framework deployed to: $TARGET_DIR"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Next steps:"
echo "  1. Edit .ai-framework/config/project.md with your project details"
echo "  2. Review CLAUDE.md and customize as needed"
echo "  3. Use /command-name to activate agents in Claude Code"
echo ""
echo "Structure created:"
echo "  $TARGET_DIR/"
echo "  ├── CLAUDE.md"
echo "  ├── .claude/"
echo "  │   ├── agents/     ($(get_agents_list | wc -l | tr -d ' ') agents)"
echo "  │   ├── skills/     ($(get_skills_list | wc -l | tr -d ' ') skills)"
echo "  │   └── commands/   (slash commands)"
echo "  └── .ai-framework/"
echo "      └── config/project.md"
