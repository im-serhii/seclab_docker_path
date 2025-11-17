# Step 04: Instructor Guide

## Overview

This exercise introduces one of the most critical concepts for running stateful applications: data persistence. The student learns the difference between the ephemeral nature of a container and the persistent nature of a volume.

## Learning Objectives

*   Understand why volumes are necessary for databases and other stateful services.
*   Learn to create and manage named volumes (`docker volume create`, `ls`, `inspect`).
*   Learn to attach a volume to a container using the `--mount` flag.

## Solution

1.  **Create Volume:**
    ```bash
    docker volume create postgres-data
    ```

2.  **Run Container:**
    ```bash
    docker run --detach --name my-database -e POSTGRES_PASSWORD=mysecretpassword --mount source=postgres-data,target=/var/lib/postgresql/data postgres
    ```

3.  **Stop and Remove:**
    ```bash
    docker stop my-database
    docker rm my-database
    ```

4.  **Re-run Container (for verification):**
    The student must run the same command again to prove the data would persist.
    ```bash
    docker run --detach --name my-database -e POSTGRES_PASSWORD=mysecretpassword --mount source=postgres-data,target=/var/lib/postgresql/data postgres
    ```

## Core Concepts for the Instructor

*   **Named Volumes vs. Anonymous Volumes:** Explain that if you only specify `-v /var/lib/postgresql/data` without a source, Docker creates an *anonymous* volume with a random hash as a name. Named volumes are explicit and easier to manage, back up, or share.
*   **`--mount` vs. `-v`:** The `--mount` syntax is more explicit and is the currently recommended way to mount volumes. The older `-v` syntax (`-v postgres-data:/var/lib/postgresql/data`) is more concise but can be less clear. It's good to explain both exist, but that `--mount` is preferred.
*   **Where is the data?** Students might ask where the volume data is physically stored. You can show them using `docker volume inspect postgres-data`. This will return a JSON object with a `Mountpoint` key, which shows the path on the host machine where the data lives (e.g., `/var/lib/docker/volumes/postgres-data/_data`).
*   **Stateful vs. Stateless:** This is a perfect time to solidify this concept. Web servers are often stateless (any instance can handle a request). Databases are stateful (they hold unique, persistent data). Docker is great for both, but stateful services require volumes.

## How the Verification Script Works

The `verify.sh` script uses `docker inspect` to get the details of the running `my-database` container. It then parses the JSON output to check two things:
1.  That there is a mount point.
2.  That the name of the source volume is `postgres-data`.

## Resetting the Lab

1.  Stop and remove the container:
    ```bash
    docker stop my-database
    docker rm my-database
    ```
2.  Remove the volume:
    ```bash
    docker volume rm postgres-data
    ```
