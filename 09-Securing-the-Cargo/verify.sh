#!/bin/bash

# Check if the app service is up and running
APP_STATUS=$(docker-compose ps -q app)
if [ -z "$APP_STATUS" ]; then
    echo "Verification failed. The 'app' service is not running."
    echo "Please run 'docker-compose up' and try again."
    exit 1
fi

# Check if the db service is up and running
DB_STATUS=$(docker-compose ps -q db)
if [ -z "$DB_STATUS" ]; then
    echo "Verification failed. The 'db' service is not running."
    echo "Please run 'docker-compose up' and try again."
    exit 1
fi

# Check if the app is responding correctly
RESPONSE=$(curl --silent http://localhost:8080)
if [[ "$RESPONSE" != *"Database time is:"* ]]; then
    echo "Verification failed. The application is not responding correctly."
    echo "This suggests the password from the .env file was not passed to the app correctly."
    exit 1
fi

echo "Success! The application is running and secrets are being managed securely."
echo "You have completed Step 09. You are ready for the final challenge!"
