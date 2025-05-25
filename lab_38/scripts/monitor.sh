#!/bin/sh
mkdir -p /var/logs

# Wait for the flask-ready-app to be resolvable
echo "Waiting for flask-ready-app to be available..."
until nslookup flask-ready-app > /dev/null 2>&1; do
  echo "Waiting for DNS resolution of flask-ready-app..."
  sleep 2
done

echo "flask-ready-app is resolvable. Starting monitoring..."

while true; do
  echo "$(date) Checking flask-ready-app..." >> /var/logs/availability.log
  curl -s http://flask-ready-app:8080/ready >> /var/logs/availability.log 2>&1
  sleep 5
done
