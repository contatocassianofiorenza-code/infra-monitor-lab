from flask import Flask, jsonify
from prometheus_client import Counter, Histogram, generate_latest, CONTENT_TYPE_LATEST
import time
import random

app = Flask(__name__)

# Metricas Prometheus
REQUEST_COUNT = Counter(
    "app_requests_total",
    "Total de requisicoes recebidas",
    ["method", "endpoint", "status"]
)

REQUEST_LATENCY = Histogram(
    "app_request_latency_seconds",
    "Latencia das requisicoes em segundos",
    ["endpoint"]
)


@app.route("/")
def index():
    REQUEST_COUNT.labels(method="GET", endpoint="/", status="200").inc()
    return jsonify({
        "service": "infra-monitor-lab",
        "status": "running",
        "version": "1.0.0"
    })


@app.route("/health")
def health():
    REQUEST_COUNT.labels(method="GET", endpoint="/health", status="200").inc()
    return jsonify({"status": "healthy"})


@app.route("/api/links")
def links():
    start = time.time()
    links_status = [
        {"id": 1, "name": "Link Vivo", "status": "up", "latency_ms": random.randint(5, 30)},
        {"id": 2, "name": "Link Claro", "status": "up", "latency_ms": random.randint(5, 30)},
        {"id": 3, "name": "Link Oi", "status": random.choice(["up", "down"]), "latency_ms": random.randint(5, 50)},
    ]
    duration = time.time() - start
    REQUEST_LATENCY.labels(endpoint="/api/links").observe(duration)
    REQUEST_COUNT.labels(method="GET", endpoint="/api/links", status="200").inc()
    return jsonify({"links": links_status})


@app.route("/metrics")
def metrics():
    return generate_latest(), 200, {"Content-Type": CONTENT_TYPE_LATEST}


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)