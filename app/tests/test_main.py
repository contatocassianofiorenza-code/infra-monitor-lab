import sys
import os
import json

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from main import app


def test_index():
    client = app.test_client()
    response = client.get("/")
    data = json.loads(response.data)

    assert response.status_code == 200
    assert data["service"] == "infra-monitor-lab"
    assert data["status"] == "running"


def test_health_endpoint():
    client = app.test_client()
    response = client.get("/health")
    data = json.loads(response.data)

    assert response.status_code == 200
    assert data["status"] == "healthy"


def test_links_endpoint():
    client = app.test_client()
    response = client.get("/api/links")
    data = json.loads(response.data)

    assert response.status_code == 200
    assert "links" in data
    assert len(data["links"]) == 3


def test_metrics_endpoint():
    client = app.test_client()
    response = client.get("/metrics")

    assert response.status_code == 200
    assert b"app_requests_total" in response.data