# Build from the lab_data/realtime-intelligence folder so the data files are in context:
#   docker build -t contoso-sender -f sender/Dockerfile .
#   docker run --rm -e EVENTSTREAM_CONN="Endpoint=sb://..." contoso-sender --loop --rate 2
FROM python:3.12-slim

WORKDIR /app
COPY sender/requirements.txt sender/requirements.txt
RUN pip install --no-cache-dir -r sender/requirements.txt

COPY clickstream-events.json warehouse-sensors.csv ./
COPY sender/send_events.py sender/send_events.py

WORKDIR /app/sender
ENTRYPOINT ["python", "send_events.py"]
