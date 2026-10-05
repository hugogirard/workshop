#!/usr/bin/env bash
# Wrapper for send_events.py: prompts for the Custom endpoint connection string
# if EVENTSTREAM_CONN isn't set, then forwards any extra flags to the sender.
set -euo pipefail

if [[ -z "${EVENTSTREAM_CONN:-}" ]]; then
  read -r -p 'Paste the Custom endpoint connection string: ' EVENTSTREAM_CONN
  export EVENTSTREAM_CONN
fi

exec python "$(dirname "$0")/send_events.py" "$@"
