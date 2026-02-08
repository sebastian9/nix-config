#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
DIR=$(echo "$input" | jq -r '.workspace.current_dir')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

CYAN='\033[36m'; GREEN='\033[32m'; YELLOW='\033[33m'; RED='\033[31m'; RESET='\033[0m'

# Pick color based on context usage
if [ "$PCT" -ge 90 ]; then PCT_COLOR="$RED"
elif [ "$PCT" -ge 70 ]; then PCT_COLOR="$YELLOW"
else PCT_COLOR="$RESET"; fi

if git rev-parse --git-dir > /dev/null 2>&1; then
    BRANCH=$(git branch --show-current 2>/dev/null)
    STAGED=$(git diff --cached --numstat 2>/dev/null | wc -l | tr -d ' ')
    MODIFIED=$(git diff --numstat 2>/dev/null | wc -l | tr -d ' ')

    # Convert git SSH URL to HTTPS
    REMOTE=$(git remote get-url origin 2>/dev/null | sed 's/git@github.tesla.com:/https:\/\/github.tesla.com\//' | sed 's/\.git$//')

    if [ -n "$REMOTE" ]; then
        REPO_NAME=$(basename "$REMOTE")
        # OSC 8 format: \e]8;;URL\a then TEXT then \e]8;;\a
        # printf %b interprets escape sequences reliably across shells
        REPO_NAME=" 🔗 ${CYAN}\e]8;;${REMOTE}\a${REPO_NAME}\e]8;;\a${RESET} "
    else
        REPO_NAME=""
    fi

    GIT_STATUS=""
    [ "$STAGED" -gt 0 ] && GIT_STATUS="${GREEN}+${STAGED}${RESET}"
    [ "$MODIFIED" -gt 0 ] && GIT_STATUS="${GIT_STATUS}${YELLOW}~${MODIFIED}${RESET}"

    printf '%b' "[$MODEL] $PCT_COLOR$PCT%${RESET} |${REPO_NAME}🌿 $BRANCH $GIT_STATUS\n"
else
    printf '%b' "[$MODEL] $PCT_COLOR$PCT%${RESET} | 📁 ${DIR##*/}"
fi
