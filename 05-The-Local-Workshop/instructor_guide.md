# Step 05: Instructor Guide

## Overview

This exercise introduces bind mounts, a core concept for local development with Docker. It contrasts them with the named volumes from the previous step, highlighting their different use cases. The goal is for the student to experience a fast, efficient development loop.

## Learning Objectives

*   Understand the use case for bind mounts (local development).
*   Learn the `--mount` syntax for `type=bind`.
*   See the immediate effect of code changes in a running container.
*   Optionally, learn about development tools like `nodemon` that enable live reloading.

## Solution

1.  **Install `nodemon`:** The student must run `npm install --save-dev nodemon` inside the `app` directory.

2.  **Update `package.json`:**
    ```json
    "scripts": {
      "start": "node server.js",
      "dev": "nodemon server.js"
    },
    ```

3.  **Create `app/Dockerfile`:**
    ```Dockerfile
    FROM node:16-alpine
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    CMD [ "npm", "run", "dev" ]
    ```

4.  **Build the image:**
    ```bash
    docker build -t dev-image ./app
    ```

5.  **Run with Bind Mount:**
    The use of `$(pwd)` is important for cross-platform compatibility in shells like Git Bash or on Linux/macOS. For Windows Command Prompt, they might need to use `%cd%` or type the absolute path.
    ```bash
    docker run --detach --name dev-app --publish 8080:8080 --mount type=bind,source=$(pwd)/app,target=/usr/src/app dev-image
    ```

6.  **Test:** The student must change the `server.js` file and see the change reflected in the browser.

## Core Concepts for the Instructor

*   **Volumes vs. Bind Mounts:** This is the key takeaway.
    *   **Volumes:** Managed by Docker. Stored in a specific part of the Docker host filesystem. Great for persisting data when you don't care about the underlying location. The container owns the content.
    *   **Bind Mounts:** A direct mapping from a host directory/file to a container directory/file. The host (user) owns the content. Perfect for development when you want to edit source code on your host machine and see it reflected in the container.
*   **The `nodemon` Workflow:** Explain that the bind mount makes the host files appear inside the container. However, the Node.js process won't automatically restart. A tool like `nodemon` is needed to watch for file changes *inside the container* and restart the process. This combination of a bind mount + a file watcher is the standard for local containerized development.
*   **Permissions Issues:** On Linux, bind mounts can sometimes cause file permission issues if the user ID inside the container doesn't match the user ID on the host. This is a more advanced topic, but it's good to be aware of if a student runs into problems.

## How the Verification Script Works

The `verify.sh` script inspects the `dev-app` container and checks its `Mounts` section. It specifically looks for a mount of `type=bind`.

## Resetting the Lab

1.  Stop and remove the container:
    ```bash
    docker stop dev-app
    docker rm dev-app
    ```
2.  Remove the image:
    ```bash
    docker rmi dev-image
    ```
3.  Clean up the `app` directory:
    ```bash
    rm -rf app/node_modules app/package-lock.json
    # And reset the package.json scripts
    ```
