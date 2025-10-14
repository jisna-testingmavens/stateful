# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        python3.10 \
        python3-pip \
        python3.10-venv \
        xvfb \
        x11vnc \
        websockify \
        && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy the rest of your code
COPY . .

# Expose app and VNC ports
EXPOSE 8000 5901

# Start all services
CMD bash -c "\
Xvfb :0 -screen 0 1920x1080x24 & \
x11vnc -display :0 -nopw -forever -shared & \
websockify 5901 localhost:5900 & \
wait"
