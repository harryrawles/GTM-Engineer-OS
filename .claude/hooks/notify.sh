#!/bin/bash

# =============================================================================
# Notify — Desktop Notification Hook
# =============================================================================
# Desktop notification when Claude finishes, needs approval, or starts/ends.
# Cross-platform: macOS (osascript), Linux (notify-send), Windows (PowerShell).
# =============================================================================

INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // "unknown"' 2>/dev/null)

case "$EVENT" in
  Stop)              TITLE="Claude finished"      ; MSG="Response complete" ;;
  PermissionRequest) TITLE="Claude needs approval" ; MSG="Permission requested — check Claude Code" ;;
  SessionStart)      TITLE="Claude session started"; MSG="Client OS active" ;;
  SessionEnd)        TITLE="Claude session ended"  ; MSG="Session complete" ;;
  SubagentStop)      TITLE="Sub-agent finished"    ; MSG="Background task complete" ;;
  Notification)
    MSG=$(echo "$INPUT" | jq -r '.message // "Notification"' 2>/dev/null)
    TITLE="Claude"
    ;;
  *) exit 0 ;;
esac

if command -v osascript &>/dev/null; then
  osascript -e "display notification \"$MSG\" with title \"$TITLE\"" 2>/dev/null; exit 0
fi
if command -v notify-send &>/dev/null; then
  notify-send "$TITLE" "$MSG" 2>/dev/null; exit 0
fi
if command -v powershell.exe &>/dev/null; then
  powershell.exe -Command "
    Add-Type -AssemblyName System.Windows.Forms
    \$n = New-Object System.Windows.Forms.NotifyIcon
    \$n.Icon = [System.Drawing.SystemIcons]::Information
    \$n.Visible = \$true
    \$n.ShowBalloonTip(3000, '$TITLE', '$MSG', [System.Windows.Forms.ToolTipIcon]::Info)
    Start-Sleep -Milliseconds 3500
    \$n.Dispose()
  " 2>/dev/null; exit 0
fi

exit 0
