# Step 06: Instructor Guide

## Overview

This exercise introduces container-to-container communication, a fundamental requirement for microservice architectures. Students learn that while containers are isolated by default, they can be connected via virtual networks.

## Learning Objectives

*   Understand the purpose of Docker networks.
*   Learn to create a bridge network with `docker network create`.
*   Learn to attach containers to a network with the `--network` flag.
*   Understand that containers on the same network can use each other's names for DNS resolution.

## Solution

1.  **Create Network:**
    ```bash
    docker network create my-app-net
    ```

2.  **Run Database:**
    ```bash
    docker run --detach --name my-database --network my-app-net -e POSTGRES_PASSWORD=mysecretpassword postgres
    ```

3.  **Create `app/Dockerfile`:**
    ```Dockerfile
    FROM node:16-alpine
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    CMD [ "node", "server.js" ]
    ```

4.  **Build App Image:**
    ```bash
    docker build -t db-app-image ./app
    ```

5.  **Run App Container:**
    ```bash
    docker run --detach --name my-app --network my-app-net --publish 8080:8080 db-app-image
    ```

After these steps, `http://localhost:8080` should show the database time.

## Core Concepts for the Instructor

*   **The Default Bridge Network:** Explain that even without creating a network, containers can run on a `default` bridge network. However, automatic DNS resolution by container name is not supported on the default bridge. This is a key reason to create your own custom bridge networks.
*   **DNS Resolution:** This is the magic. When containers are on the same custom bridge network, Docker provides a built-in DNS server. This server resolves the container's name (e.g., `my-database`) to its internal IP address on that network. This is why the connection string `host: 'my-database'` works in the `server.js` file.
*   **Network Isolation:** You can create multiple networks. Containers on different networks cannot communicate with each other, providing a strong security boundary. A container can, however, be attached to multiple networks if needed.
*   **Other Network Drivers:** Briefly mention that `bridge` is the most common driver, but others exist, like `host` (removes network isolation, can be risky) and `overlay` (for multi-host communication in Docker Swarm).

## How the Verification Script Works

The `verify.sh` script uses `docker inspect` on both the `my-app` and `my-database` containers. It parses the JSON output to find the `Networks` section and confirms that both containers are attached to `my-app-net`.

## Resetting the Lab

1.  Stop and remove the containers:
    ```bash
    docker stop my-app my-database
    docker rm my-app my-database
    ```
2.  Remove the image:
    ```bash
    docker rmi db-app-image
    ```
3.  Remove the network:
    ```bash
    docker network rm my-app-net
    ```
