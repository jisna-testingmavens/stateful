# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /app

# Enable universe repo and install dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update && \
    apt-get install -y \
        python3.10 \
        python3-pip \
        python3.10-venv \
        xvfb \
        x11vnc \
        websockify \
        x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy your application code
COPY . .

# Expose ports
EXPOSE 8000 5901

# Set DISPLAY environment variable
ENV DISPLAY=:0

# Start services and run xeyes for verification
CMD bash -c "\
Xvfb :0 -screen 0 1920x1080x24 & \
x11vnc -display :0 -nopw -forever -shared & \
websockify 5901 localhost:5900 & \
sleep 2 && xeyes & \
wait"
