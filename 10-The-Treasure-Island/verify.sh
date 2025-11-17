#!/bin/bash

echo "Starting verification for the Capstone Project..."

# Step 1: Build and start the services
echo "Attempting to build and launch the application stack with docker-compose..."
docker-compose up --build -d

if [ $? -ne 0 ]; then
    echo "Verification failed. 'docker-compose up' command failed. Please check your docker-compose.yml and Dockerfiles."
    exit 1
fi

# Step 2: Check if all services are running
echo "Checking if all services are running..."
FRONTEND_STATUS=$(docker-compose ps -q frontend)
BACKEND_STATUS=$(docker-compose ps -q backend)
DB_STATUS=$(docker-compose ps -q db)

if [ -z "$FRONTEND_STATUS" ] || [ -z "$BACKEND_STATUS" ] || [ -z "$DB_STATUS" ]; then
    echo "Verification failed. Not all services (frontend, backend, db) are running."
    docker-compose ps
    exit 1
fi

echo "All services are running."

# Step 3: Wait for services to be ready
echo "Waiting for services to initialize... (10 seconds)"
sleep 10

# Step 4: Check the backend API endpoint
echo "Checking the backend API..."
BACKEND_RESPONSE=$(curl --silent http://localhost:3001/api/data)

if [[ "$BACKEND_RESPONSE" != *"message"* ]]; then
    echo "Verification failed. The backend API at http://localhost:3001/api/data is not returning the expected JSON data."
    echo "Response was: $BACKEND_RESPONSE"
    exit 1
fi

echo "Backend API is responding correctly."

# Step 5: Check the frontend
echo "Checking the frontend application..."
FRONTEND_RESPONSE=$(curl --silent http://localhost)

if [[ "$FRONTEND_RESPONSE" != *"Capstone Project"* ]]; then
    echo "Verification failed. The frontend at http://localhost is not serving the correct HTML."
    exit 1
fi

echo "Frontend is being served correctly."

# Final success message
echo "-----------------------------------------------------"
echo "SUCCESS! You have completed the DevOps Journey!"
echo "All services are running and communicating correctly."
echo "You are a containerization champion!"
echo "-----------------------------------------------------"

# Optional: bring the services down
# echo "Bringing the application stack down..."
# docker-compose down -v
