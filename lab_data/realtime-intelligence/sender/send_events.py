#!/usr/bin/env python3
"""Stream ContosoMart events into a Fabric Eventstream Custom endpoint.

Replays the lab's seed rows, then (optionally) generates an endless stream of
realistic synthetic events so a Real-Time Dashboard keeps moving. The JSON field
names match the Clickstream / Sensors KQL table columns, so Fabric auto-maps the
schema once real events arrive.

Get the connection string from the Eventstream Custom endpoint:
    source node (src_storefront) -> Keys / Sample code tab -> "Connection string-primary key".
Pass it with --connection-string or the EVENTSTREAM_CONN environment variable.

Examples:
    python send_events.py --dry-run --count 15
    python send_events.py --connection-string "Endpoint=sb://..." --loop --rate 2
    python send_events.py --source sensors --loop --live-timestamps
"""
from __future__ import annotations

import argparse
import json
import os
import random
import sys
import time
import uuid
from datetime import datetime, timezone
from pathlib import Path

DATA_DIR = Path(__file__).resolve().parent.parent
CLICKSTREAM_FILE = DATA_DIR / "clickstream-events.json"
SENSORS_FILE = DATA_DIR / "warehouse-sensors.csv"

# Pools reused from the seed data so synthetic rows join cleanly to the CRM/gold tables.
CUSTOMER_REFS = ["C-0007", "c-0007", "C-0044", "C-0102", "C-0211", "C-0333", "C-0450"]
PAGES = [
    "/", "/search", "/product/espresso-blend", "/product/cold-brew-kit",
    "/product/ceramic-mug", "/product/decaf-reserve", "/cart", "/checkout",
]
EVENT_TYPES = ["page_view", "add_to_cart", "purchase", "cart_abandon"]
DEVICES = ["mobile", "desktop", "tablet"]
GEOS = ["CA-ON", "CA-BC", "CA-QC", "US-WA", "US-NY"]

SENSORS = [
    {"sensor_id": "SENS-01", "warehouse": "YYZ-1", "zone": "cold-store", "base": 4.0},
    {"sensor_id": "SENS-02", "warehouse": "YYZ-1", "zone": "dry-store", "base": 19.2},
    {"sensor_id": "SENS-03", "warehouse": "SEA-2", "zone": "cold-store", "base": 4.1},
]
_sensor_state: dict[str, float] = {}


def now_iso() -> str:
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def load_clickstream_seed() -> list[dict]:
    with CLICKSTREAM_FILE.open(encoding="utf-8") as fh:
        return json.load(fh)


def load_sensors_seed() -> list[dict]:
    rows: list[dict] = []
    with SENSORS_FILE.open(encoding="utf-8") as fh:
        header = [c.strip() for c in fh.readline().split(",")]
        for line in fh:
            line = line.strip()
            if not line:
                continue
            values = line.split(",")
            row = dict(zip(header, values))
            rows.append({
                "sensor_id": row["sensor_id"],
                "ts": row["ts"],
                "warehouse": row["warehouse"],
                "zone": row["zone"],
                "temp_c": float(row["temp_c"]),
                "humidity_pct": int(row["humidity_pct"]),
                "door_open": row["door_open"] in ("1", "true", "True"),
            })
    return rows


def synth_clickstream() -> dict:
    event_type = random.choices(
        EVENT_TYPES, weights=[0.6, 0.2, 0.12, 0.08], k=1
    )[0]
    value = round(random.uniform(8, 120), 2) if event_type in ("add_to_cart", "purchase") else 0
    return {
        "event_id": f"e-{uuid.uuid4().hex[:8]}",
        "ts": now_iso(),
        "session": f"s-{random.randint(100, 999)}",
        "customer_ref": random.choice(CUSTOMER_REFS),
        "page": "/checkout" if event_type == "purchase" else random.choice(PAGES),
        "event_type": event_type,
        "device": random.choice(DEVICES),
        "geo": random.choice(GEOS),
        "value_cad": value,
    }


def synth_sensors() -> dict:
    sensor = random.choice(SENSORS)
    sid = sensor["sensor_id"]
    current = _sensor_state.get(sid, sensor["base"])
    # Random walk with an occasional cold-store excursion on SENS-01.
    excursion = sid == "SENS-01" and random.random() < 0.15
    drift = random.uniform(0.6, 2.2) if excursion else random.uniform(-0.3, 0.3)
    temp = max(sensor["base"] - 1, min(sensor["base"] + 6, current + drift))
    _sensor_state[sid] = temp
    return {
        "sensor_id": sid,
        "ts": now_iso(),
        "warehouse": sensor["warehouse"],
        "zone": sensor["zone"],
        "temp_c": round(temp, 1),
        "humidity_pct": random.randint(40, 70),
        "door_open": excursion or random.random() < 0.1,
    }


def apply_live_ts(event: dict, live_ts: bool) -> dict:
    if live_ts:
        event = dict(event)
        event["ts"] = now_iso()
    return event


def iter_events(source: str, loop: bool, count: int | None, live_ts: bool):
    """Yield seed rows first, then synthetic rows until count/loop is satisfied."""
    seed = load_clickstream_seed() if source == "clickstream" else load_sensors_seed()
    synth = synth_clickstream if source == "clickstream" else synth_sensors

    sent = 0
    for event in seed:
        if count is not None and sent >= count:
            return
        yield apply_live_ts(event, live_ts)
        sent += 1

    if not loop and count is None:
        return  # seed-only, single pass

    while loop or (count is not None and sent < count):
        if count is not None and sent >= count:
            return
        yield synth()
        sent += 1


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Stream ContosoMart events into a Fabric Eventstream Custom endpoint.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "--connection-string",
        default=os.environ.get("EVENTSTREAM_CONN"),
        help="Custom endpoint connection string (or set EVENTSTREAM_CONN).",
    )
    parser.add_argument("--eventhub-name", default=None,
                        help="Event hub / entity path, if not embedded in the connection string.")
    parser.add_argument("--source", choices=["clickstream", "sensors"], default="clickstream")
    parser.add_argument("--rate", type=float, default=1.0, help="Events per second.")
    parser.add_argument("--count", type=int, default=None, help="Total events to send.")
    parser.add_argument("--loop", action="store_true", help="Stream synthetic events forever.")
    parser.add_argument("--live-timestamps", action="store_true",
                        help="Rewrite seed-row timestamps to now.")
    parser.add_argument("--dry-run", action="store_true", help="Print events instead of sending.")
    args = parser.parse_args(argv)

    delay = 1.0 / args.rate if args.rate > 0 else 0.0
    events = iter_events(args.source, args.loop, args.count, args.live_timestamps)

    if args.dry_run:
        sent = 0
        for event in events:
            print(json.dumps(event))
            sent += 1
            if delay:
                time.sleep(delay)
        print(f"[dry-run] {sent} {args.source} event(s) printed; nothing sent.", file=sys.stderr)
        return 0

    if not args.connection_string:
        parser.error("No connection string. Pass --connection-string or set EVENTSTREAM_CONN.")

    try:
        from azure.eventhub import EventData, EventHubProducerClient
    except ImportError:
        print("Missing dependency. Run: pip install -r requirements.txt", file=sys.stderr)
        return 2

    client_kwargs = {"conn_str": args.connection_string}
    if args.eventhub_name:
        client_kwargs["eventhub_name"] = args.eventhub_name
    producer = EventHubProducerClient.from_connection_string(**client_kwargs)

    sent = 0
    print(f"Streaming {args.source} events to the Custom endpoint "
          f"(rate={args.rate}/s, loop={args.loop}). Ctrl+C to stop.", file=sys.stderr)
    try:
        with producer:
            for event in events:
                producer.send_batch([EventData(json.dumps(event))])
                sent += 1
                if sent % 10 == 0:
                    print(f"  sent {sent} events...", file=sys.stderr)
                if delay:
                    time.sleep(delay)
    except KeyboardInterrupt:
        print("\nStopped.", file=sys.stderr)
    finally:
        print(f"Done. {sent} {args.source} event(s) sent.", file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
