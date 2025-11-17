#!/bin/bash

CONTAINER_NAME="my-first-app"
IMAGE_NAME="my-first-image"

# Check if a container with the specified name is running
if ! [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Verification failed. A container named '$CONTAINER_NAME' is not running."
    exit 1
fi

# Check if the container is using the correct image
CONTAINER_IMAGE=$(docker inspect -f '{{.Config.Image}}' $CONTAINER_NAME)
if [ "$CONTAINER_IMAGE" != "$IMAGE_NAME" ]; then
    echo "Verification failed. The container '$CONTAINER_NAME' is not using the '$IMAGE_NAME' image."
    exit 1
fi

# Check if the application is responding correctly
RESPONSE=$(curl --silent http://localhost:8080)
EXPECTED_RESPONSE="Hello from inside the container! This is our first custom image."

if [ "$RESPONSE" != "$EXPECTED_RESPONSE" ]; then
    echo "Verification failed. The application is not responding with the correct message."
    echo "Expected: '$EXPECTED_RESPONSE'"
    echo "Got: '$RESPONSE'"
    exit 1
fi


echo "Success! The container '$CONTAINER_NAME' is running with the correct image and responding correctly."
echo "You have completed Step 03. You are now an image builder!"
