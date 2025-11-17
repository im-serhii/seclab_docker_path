# Step 01: Instructor Guide

## Overview

This exercise is the student's first introduction to Docker. It is designed to be simple and build confidence. The core concepts introduced are Docker images, Docker containers, and port mapping.

## Learning Objectives

*   Understand the relationship between an image and a container.
*   Learn the `docker pull` and `docker run` commands.
*   Understand the concept of port mapping.

## Solution

The student needs to execute two main commands:

1.  **Pull the image:**
    ```bash
    docker pull nginx
    ```

2.  **Run the container:**
    ```bash
    docker run --detach --publish 8080:80 --name my-first-container nginx
    ```

After running these commands, the student should be able to see the Nginx welcome page at `http://localhost:8080`.

## Core Concepts for the Instructor

*   **Docker Hub:** Explain that Docker Hub is the default public registry for Docker images, like GitHub is for code. The `docker pull` command fetches images from here unless a different registry is specified.
*   **Image vs. Container:** Reinforce the analogy: an image is a blueprint or a class, while a container is a running instance of that blueprint, like an object.
*   **Port Mapping (`-p 8080:80`):** This is often a point of confusion. Explain that the first number (`8080`) is the port on the host machine (their computer), and the second number (`80`) is the port inside the container. The mapping connects the host port to the container port, allowing external traffic to reach the application running inside the container.
*   **Detached Mode (`-d`):** Explain that this runs the container in the background. Without it, the container would run in the foreground, and their terminal would be attached to the container's output.

## How the Verification Script Works

The `verify.sh` script checks for a running container with the exact name `my-first-container`. It uses `docker ps` to list running containers and `grep` to search for the name.

## Resetting the Lab

If a student needs to reset the lab, they need to stop and remove their container. They can do this with the following commands:

```bash
docker stop my-first-container
docker rm my-first-container
```
