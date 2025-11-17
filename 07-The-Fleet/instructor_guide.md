# Step 07: Instructor Guide

## Overview

This exercise introduces Docker Compose, a critical tool for orchestrating multi-container applications. It abstracts away the manual `docker run` and `docker network` commands the student used in previous steps into a single, declarative YAML file.

## Learning Objectives

*   Understand the role of Docker Compose in a development workflow.
*   Learn the basic structure of a `docker-compose.yml` file (`version`, `services`, `volumes`).
*   Learn how to define a service that builds from a Dockerfile vs. one that uses a pre-built image.
*   Understand service dependency with `depends_on`.
*   Learn the `docker-compose up` and `docker-compose down` commands.

## Solution

1.  **Create `docker-compose.yml`:** The student must create this file in the root directory.

2.  **YAML Content:**
    ```yaml
    version: '3.8'

    services:
      app:
        build: ./app
        ports:
          - "8080:8080"
        environment:
          - DB_HOST=db
          - DB_PASSWORD=mysecretpassword
        depends_on:
          - db

      db:
        image: postgres
        environment:
          - POSTGRES_PASSWORD=mysecretpassword
        volumes:
          - postgres-data:/var/lib/postgresql/data

    volumes:
      postgres-data:
    ```

3.  **Run Compose:**
    ```bash
    docker-compose up --build -d
    ```

After this, `http://localhost:8080` should show the application's message.

## Core Concepts for the Instructor

*   **Declarative vs. Imperative:** The `docker run` commands were *imperative* (you told Docker *how* to do something). Docker Compose is *declarative* (you tell Docker *what* you want the end state to be). This is a fundamental concept in modern DevOps (Infrastructure as Code).
*   **Service Names as Hostnames:** Reiterate that Compose creates a network automatically. The name of the service in the YAML file (e.g., `db`) becomes the hostname for that service on the network. This is why `DB_HOST=db` works.
*   **`depends_on`:** Explain that `depends_on` only controls the *startup order* of the services. It does **not** wait for the `db` service to be fully ready and accepting connections. For production, more robust health checks are needed, but for local development, `depends_on` is usually sufficient.
*   **Top-Level Keys:** Explain the different top-level keys. `services` is where you define your containers. `volumes` and `networks` are where you define named volumes and networks that can be referenced by your services. In this case, Compose creates a default network, but we explicitly define the volume.

## How the Verification Script Works

The `verify.sh` script uses `docker-compose ps` to check the status of the services. It checks that both an `app` and a `db` service are running.

## Resetting the Lab

Resetting is simple with Docker Compose.

1.  Tear down the stack and remove volumes:
    ```bash
    # The -v flag removes the named volumes defined in the compose file
    docker-compose down -v
    ```
2.  Remove the `docker-compose.yml` file.
