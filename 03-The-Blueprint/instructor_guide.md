# Step 03: Instructor Guide

## Overview

This is arguably the most important foundational step in the learning path. The student moves from being a consumer of images to a creator. This exercise introduces the `Dockerfile` and the `docker build` command.

## Learning Objectives

*   Understand the purpose and basic structure of a `Dockerfile`.
*   Learn the core `Dockerfile` instructions: `FROM`, `WORKDIR`, `COPY`, `RUN`, `CMD`.
*   Learn how to build a custom image with `docker build`.
*   Run a container from a custom-built image.

## Solution

1.  **Create `app/Dockerfile`:** The student must create this file.

2.  **Dockerfile Content:**
    ```Dockerfile
    FROM node:16-alpine
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    CMD [ "node", "server.js" ]
    ```

3.  **Build Command:** The student must run this from the `03-The-Blueprint` directory.
    ```bash
    docker build -t my-first-image ./app
    ```

4.  **Run Command:**
    ```bash
    docker run --detach --publish 8080:8080 --name my-first-app my-first-image
    ```

After these steps, `http://localhost:8080` should show the application's message.

## Core Concepts for the Instructor

*   **`FROM`:** Every `Dockerfile` must start with a `FROM` instruction. It defines the base image for your build.
*   **`WORKDIR`:** Sets the working directory for any subsequent `RUN`, `CMD`, `COPY` instructions. It's a good practice to set this early.
*   **`COPY` vs. `RUN`:** `COPY` copies files from the host machine's build context into the image. `RUN` executes a command inside the image during the build process (e.g., installing dependencies).
*   **Cache Optimization:** Explain why `COPY package*.json ./` and `RUN npm install` come *before* `COPY . .`. Docker builds in layers and caches them. If `package.json` hasn't changed, Docker will reuse the cached `npm install` layer, making subsequent builds much faster. If we copied all the source code first, any change to any file would invalidate the cache for the `npm install` step.
*   **`CMD`:** This specifies the default command to run when a container is started from the image. There can only be one `CMD` in a `Dockerfile`.
*   **Build Context:** Explain that the path at the end of the `docker build` command (`./app`) is the "build context." All files in this directory are sent to the Docker daemon. This is why the `COPY` command can see the application files.

## Resetting the Lab

1.  Stop and remove the container:
    ```bash
    docker stop my-first-app
    docker rm my-first-app
    ```
2.  Remove the built image (optional, but good for a clean start):
    ```bash
    docker rmi my-first-image
    ```
3.  Delete the `app/Dockerfile` and have the student recreate it.
