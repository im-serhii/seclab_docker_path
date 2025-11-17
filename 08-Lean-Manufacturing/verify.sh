#!/bin/bash

IMAGE_NAME="optimized-app-image"
MAX_SIZE_MB=150 # Set a reasonable max size in MB for a simple Node.js app

# Build the student's Dockerfile
echo "Building the Docker image..."
docker build -t $IMAGE_NAME ./app > /dev/null

if [ $? -ne 0 ]; then
    echo "Verification failed. The Docker image could not be built. Please check your Dockerfile for errors."
    exit 1
fi

# Get the image size in bytes
IMAGE_SIZE_BYTES=$(docker image inspect -f '{{.Size}}' $IMAGE_NAME)

# Convert max size to bytes
MAX_SIZE_BYTES=$((MAX_SIZE_MB * 1024 * 1024))

# Compare the sizes
if [ "$IMAGE_SIZE_BYTES" -gt "$MAX_SIZE_BYTES" ]; then
    echo "Verification failed. The image size (${IMAGE_SIZE_BYTES} bytes) is larger than the allowed maximum of ${MAX_SIZE_MB}MB."
    echo "This suggests that the multi-stage build was not successful in creating a smaller image."
    exit 1
fi

IMAGE_SIZE_MB_ACTUAL=$(($IMAGE_SIZE_BYTES / 1024 / 1024))
echo "Success! The image '$IMAGE_NAME' was built successfully with a size of ${IMAGE_SIZE_MB_ACTUAL}MB, which is under the ${MAX_SIZE_MB}MB limit."
echo "You have completed Step 08. Your images are now lean and mean!"
