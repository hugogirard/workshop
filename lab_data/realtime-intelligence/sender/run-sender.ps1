#!/usr/bin/env pwsh
# Wrapper for send_events.py: prompts for the Custom endpoint connection string
# if EVENTSTREAM_CONN isn't set, then forwards any extra flags to the sender.
$ErrorActionPreference = 'Stop'

if (-not $env:EVENTSTREAM_CONN) {
    $env:EVENTSTREAM_CONN = Read-Host 'Paste the Custom endpoint connection string'
}

python "$PSScriptRoot/send_events.py" @args
