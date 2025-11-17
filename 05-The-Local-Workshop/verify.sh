#!/bin/bash

CONTAINER_NAME="dev-app"

# Check if a container with the specified name is running
if ! [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Verification failed. A container named '$CONTAINER_NAME' is not running."
    exit 1
fi

# Inspect the container to check for a bind mount
MOUNT_TYPE=$(docker inspect -f '{{range .Mounts}}{{if eq .Type "bind"}}found{{end}}{{end}}' $CONTAINER_NAME)

if [ "$MOUNT_TYPE" != "found" ]; then
    echo "Verification failed. The container '$CONTAINER_NAME' is not using a bind mount."
    echo "Make sure you used the --mount flag with type=bind."
    exit 1
fi

echo "Success! The container '$CONTAINER_NAME' is running with a bind mount."
echo "You have completed Step 05. Happy developing!"
