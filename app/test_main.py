from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_health_check():
    response = client.get("/")

    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

def test_create_task():
    response = client.post(
        "/tasks",
        json={"title": "Test Task"}
    )

    assert response.status_code == 200

    data = response.json()

    assert data["title"] == "Test Task"
    assert data["completed"] == False

def test_get_tasks():
    response = client.get("/tasks")

    assert response.status_code == 200