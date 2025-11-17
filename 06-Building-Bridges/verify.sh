#!/bin/bash

APP_CONTAINER="my-app"
DB_CONTAINER="my-database"
NETWORK_NAME="my-app-net"

# Check if app container is running
if ! [ "$(docker ps -q -f name=$APP_CONTAINER)" ]; then
    echo "Verification failed. Container '$APP_CONTAINER' is not running."
    exit 1
fi

# Check if db container is running
if ! [ "$(docker ps -q -f name=$DB_CONTAINER)" ]; then
    echo "Verification failed. Container '$DB_CONTAINER' is not running."
    exit 1
fi

# Check if app container is on the correct network
APP_NETWORK=$(docker inspect -f '{{.HostConfig.NetworkMode}}' $APP_CONTAINER)
if [ "$APP_NETWORK" != "$NETWORK_NAME" ]; then
    echo "Verification failed. Container '$APP_CONTAINER' is not on the '$NETWORK_NAME' network."
    exit 1
fi

# Check if db container is on the correct network
DB_NETWORK=$(docker inspect -f '{{.HostConfig.NetworkMode}}' $DB_CONTAINER)
if [ "$DB_NETWORK" != "$NETWORK_NAME" ]; then
    echo "Verification failed. Container '$DB_CONTAINER' is not on the '$NETWORK_NAME' network."
    exit 1
fi

# Check if the app is responding
RESPONSE=$(curl --silent http://localhost:8080)
if [[ "$RESPONSE" != *"Database time is:"* ]]; then
    echo "Verification failed. The application is not responding correctly."
    echo "It seems it cannot connect to the database."
    exit 1
fi

echo "Success! Both containers are running on the '$NETWORK_NAME' network and can communicate."
echo "You have completed Step 06. Your application is now multi-service!"
