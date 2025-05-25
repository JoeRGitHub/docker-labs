### **Mini Project: Docker-Based Monitoring for a Flask Application (Using Docker Networks)**

This mini-project will use Docker to run both a Flask application and a monitoring script, which checks the availability of the Flask app. We will use Docker networks for container-to-container communication.

---

### **Step 1: Create a Docker Network**

First, create a custom Docker network for communication between the Flask app and the monitoring script.

```bash
docker network create app-network
```

---

### **Step 2: Flask Application**

We will create a simple Flask application that responds with a "Ready" status on the `/ready` endpoint.

### **Flask App (`app.py`)**:

```python
from flask import Flask, jsonify
import signal
import threading
import time
import os

app = Flask(__name__)
shutdown_flag = threading.Event()

@app.route('/')
def home():
    return "Hi there!"

@app.route('/ready')
def ready():
    if not shutdown_flag.is_set():
        return jsonify({"status": 'Ready'}), 200
    else:
        return jsonify({"status": 'NotReady'}), 503

def shutdown_server():
    shutdown_flag.set()
    print('Handling the last server requests...')
    time.sleep(30)
    print('Serve now should not receive any new incoming requests')
    os._exit(0)

def handle_sigterm(signum, frame):
    print(f"SIGTERM received. {signum} {frame}. Shutting down in 30 seconds...")
    threading.Thread(target=shutdown_server).start()

if __name__ == "__main__":
    signal.signal(signal.SIGTERM, handle_sigterm)
    print(f'Server PID={os.getpid()}')
    app.run(host='0.0.0.0', port=8080)

```

### **Requirements File (`requirements.txt`)**:

```
Flask
```

### **Dockerfile for Flask App**:

```
# Write the Dockerfile
```

### **Commands**:

1. **Build the Docker image for the Flask app**:

   ```bash
   docker build -t flask-app .
   ```

2. **Run the Flask app in a Docker container and attach it to the network**:

   ```bash
   # Run the container
   ```

---

### **Step 3: Monitoring Script**

The monitoring script will check the availability of the Flask app by sending an HTTP request to the `/ready` endpoint every 5 minutes and logging the status to a file.

### **Availability Script (`availability.sh`)**:

```bash
# Write a bash script to monitor the Flask App and Print out if the app is up/down
```

![](../../../images/mini-project-docker.png)

### **Dockerfile for Monitoring Script**:

```

# Write a Dockerfile to Run the script.

```

### **Commands**:

1. **Build the Docker image for the monitoring script**:

   ```bash
   docker build -f availability.Dockerfile -t availability-monitor .
   ```

2. **Run the monitoring script in a container, connected to the same network as the Flask app**:

   ```bash
   docker run -d --name availability-monitor --network app-network availability-monitor
   ```

---

### **Step 4: Verify the Setup**

- The **Flask app** should be running on `http://localhost:8080`.
- The **monitoring script** should be running in the background and logging the status of the Flask app to `/var/log/availability.log`.

### **Check the Flask app**:

Visit `http://localhost:8080` or `http://<your-EC2-instance-IP>:8080` to see the Flask app response.

### **Check the Logs**:

To see if the monitoring script is working, you can view the logs inside the `availability-monitor` container:

```bash
docker exec -it availability-monitor cat /var/log/availability.log
```

---

### **Summary**

1. **Docker Network**: We used a Docker network (`app-network`) to enable communication between the Flask app and the monitoring script.
2. **Flask App**: A simple Flask app was created and containerized using Docker.
3. **Monitoring Script**: A Bash script continuously monitors the Flask app's `/ready` endpoint and logs the results.
4. **Containers**: Both the Flask app and the monitoring script are running in separate containers, but they can communicate via the Docker network.
