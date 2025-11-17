# Step 02: Instructor Guide

## Overview

This exercise builds directly on the previous one. It introduces the student to the basic commands for managing the container they just created. This reinforces the idea that containers are manageable objects with a lifecycle.

## Learning Objectives

*   Learn `docker ps` to list containers.
*   Learn `docker logs` to view container output.
*   Learn `docker stop`, `docker start`, and `docker rm` to manage the container lifecycle.

## Solution

The student will execute a series of commands. The final state required for verification is that the `my-first-container` is removed.

1.  **List running containers:**
    ```bash
    docker ps
    ```

2.  **View logs:**
    ```bash
    docker logs my-first-container
    ```

3.  **Stop the container:**
    ```bash
    docker stop my-first-container
    ```

4.  **List all containers:**
    ```bash
    docker ps -a
    ```

5.  **Start the container:**
    ```bash
    docker start my-first-container
    ```

6.  **Stop and remove the container (for verification):**
    ```bash
    docker stop my-first-container
    docker rm my-first-container
    ```

## Core Concepts for the Instructor

*   **Container State:** Emphasize the different states a container can be in: running, stopped (exited), and removed. Use `docker ps` and `docker ps -a` to demonstrate this.
*   **Logs:** Explain that `docker logs` is the primary way to debug an application running inside a container. It shows the `STDOUT` and `STDERR` streams from the main process in the container.
*   **Immutability (of sorts):** When a container is removed, any changes made inside its filesystem are lost (unless using volumes, which is a future topic). This is a key concept of containerization.
*   **Forced Removal:** Mention that you can use `docker rm -f my-first-container` to force the removal of a *running* container, which combines the `stop` and `rm` steps. However, it's good practice to stop it gracefully first.

## How the Verification Script Works

The `verify.sh` script checks that no container with the name `my-first-container` exists (neither running nor stopped). It does this by checking the output of `docker ps -a -f name=my-first-container`.

## Resetting the Lab

This lab's goal is to clean up the previous lab. If a student gets stuck, they may need to re-create the container from Step 01 to practice the commands again:

```bash
docker run --detach --publish 8080:80 --name my-first-container nginx
```
