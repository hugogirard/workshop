# ContosoMart live event sender

Streams the Real-Time Intelligence lab's **clickstream** (and optionally **sensor**)
data into a Microsoft Fabric **Eventstream Custom endpoint** over the Event Hubs
protocol — so the lab becomes a true live-streaming demo instead of a one-shot file load.

Because the JSON field names match the `Clickstream` / `Sensors` KQL table columns,
Fabric auto-maps the schema as soon as real events arrive (this also clears the
"Add a mapper to map schema" warning on the Eventhouse destination).

## Prerequisites

- Python 3.9+
- An Eventstream with a **Custom endpoint** source routed to the `Clickstream` table
  (Module 2, step 1 of the workshop).

```bash
pip install -r requirements.txt
```

## Get the connection string

In the Eventstream editor, select the Custom endpoint source node
(`src_storefront`) → **Keys** (or **Sample code**) tab → copy
**Connection string-primary key**.

Pass it to the sender with `--connection-string` or the `EVENTSTREAM_CONN`
environment variable:

```bash
# PowerShell
$env:EVENTSTREAM_CONN = "Endpoint=sb://...;SharedAccessKeyName=...;SharedAccessKey=...;EntityPath=..."

# bash
export EVENTSTREAM_CONN="Endpoint=sb://...;SharedAccessKeyName=...;SharedAccessKey=...;EntityPath=..."
```

## Run

```bash
# Preview events without sending (no connection string needed)
python send_events.py --dry-run --count 15

# Send the 15 seed clickstream rows once
python send_events.py

# Keep a live stream flowing (synthetic events) at 2/sec
python send_events.py --loop --rate 2

# Rewrite seed timestamps to "now" so dashboards look live
python send_events.py --loop --live-timestamps

# Stream warehouse sensors (requires a SECOND Custom endpoint -> Sensors table)
python send_events.py --source sensors --loop --live-timestamps
```

The convenience wrappers `run-sender.ps1` / `run-sender.sh` prompt for the
connection string if it isn't already set and forward any extra flags.

## Options

| Flag | Default | Meaning |
| --- | --- | --- |
| `--connection-string` | `EVENTSTREAM_CONN` env | Custom endpoint connection string |
| `--eventhub-name` | (from conn string) | Entity path, if not embedded in the connection string |
| `--source` | `clickstream` | `clickstream` or `sensors` |
| `--rate` | `1.0` | Events per second |
| `--count` | (seed rows) | Total events to send |
| `--loop` | off | Stream synthetic events forever |
| `--live-timestamps` | off | Rewrite seed-row timestamps to now |
| `--dry-run` | off | Print events instead of sending |

## Docker (no local Python)

```bash
# Build from the lab_data/realtime-intelligence folder (so the data files are in context)
cd ..
docker build -t contoso-sender -f sender/Dockerfile .
docker run --rm -e EVENTSTREAM_CONN="Endpoint=sb://..." contoso-sender --loop --rate 2
```

## Verify in Fabric

```kql
Clickstream | count          // climbs as events arrive
Clickstream | top 10 by ts desc
```

For sensors, `SENS-01` periodically drifts above 6 °C with `door_open = true` to
trigger the Module 5 Activator alert.
