#!/bin/bash

CONTAINER_NAME="my-database"
VOLUME_NAME="postgres-data"

# Check if a container with the specified name is running
if ! [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Verification failed. A container named '$CONTAINER_NAME' is not running."
    exit 1
fi

# Inspect the container to check for the correct volume mount
MOUNT_INFO=$(docker inspect -f '{{range .Mounts}}{{if eq .Name "'$VOLUME_NAME'"}}found{{end}}{{end}}' $CONTAINER_NAME)

if [ "$MOUNT_INFO" != "found" ]; then
    echo "Verification failed. The container '$CONTAINER_NAME' is not using the named volume '$VOLUME_NAME'."
    echo "Make sure you used the --mount flag correctly."
    exit 1
fi

echo "Success! The container '$CONTAINER_NAME' is running and correctly mounted to the '$VOLUME_NAME' volume."
echo "You have completed Step 04. Your data is now safe!"
