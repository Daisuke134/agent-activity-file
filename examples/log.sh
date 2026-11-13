#!/usr/bin/env bash
# Append one line to the shared activity file and push, retrying on rebase.
# Usage: AGENT_NAME=ops-bot ./log.sh DONE "Fixed X" [surface] [evidence]
set -euo pipefail
KIND="${1:?KIND required (START|NOW|DONE|FIX|CLAIM|RELEASE|TOPIC|POSTING|POSTED)}"
MSG="${2:?message required}"
SURFACE="${3:--}"
EVIDENCE="${4:--}"
AGENT="${AGENT_NAME:?set AGENT_NAME}"
FILE="${ACTIVITY_FILE:-ACTIVITY.md}"
case "$KIND" in START|NOW|DONE|FIX|CLAIM|RELEASE|TOPIC|POSTING|POSTED) ;; *) echo "bad KIND: $KIND" >&2; exit 2;; esac
MSG="${MSG//$'\n'/ }"
git pull -q --rebase || { git rebase --abort 2>/dev/null || true; echo "pull failed" >&2; exit 1; }
printf '%s | %s | %s | %s | %s | %s\n' "$(date '+%Y-%m-%d %H:%M %Z')" "$AGENT" "$KIND" "$MSG" "$SURFACE" "$EVIDENCE" >> "$FILE"
git add "$FILE"
git commit -q -m "activity: $AGENT $KIND"
for i in 1 2 3 4 5; do
  if git push -q; then echo "logged ($KIND)"; exit 0; fi
  sleep $((i * 2))
  git pull -q --rebase || { echo "rebase conflict: resolve by keeping both lines" >&2; exit 1; }
done
echo "push failed after retries" >&2; exit 1
