#!/bin/bash

CONTAINER_NAME="my-first-container"

# Check if a container with the specified name exists (running or stopped)
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Verification failed. The container '$CONTAINER_NAME' still exists."
    echo "Please make sure you have stopped and removed the container."
else
    echo "Success! The container '$CONTAINER_NAME' has been removed."
    echo "You have completed Step 02. You are ready to build your own image!"
fi
