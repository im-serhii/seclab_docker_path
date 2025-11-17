#!/bin/bash

CONTAINER_NAME="my-first-container"

# Check if a container with the specified name is running
if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Success! The container '$CONTAINER_NAME' is running."
    echo "You have completed Step 01. You are ready to move on to the next step!"
else
    echo "Verification failed. A container named '$CONTAINER_NAME' is not running."
    echo "Please check the instructions and make sure you have run the container correctly."
fi
