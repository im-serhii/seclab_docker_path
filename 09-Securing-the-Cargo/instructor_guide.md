# Step 09: Instructor Guide

## Overview

This exercise teaches a fundamental security practice: separating configuration and secrets from code and orchestration files. The student learns to use `.env` files with Docker Compose, which is a standard pattern for local development.

## Learning Objectives

*   Understand the security risks of hardcoding secrets.
*   Learn how to create and use an `.env` file.
*   Learn the `env_file` directive in `docker-compose.yml`.

## Solution

1.  **Inspect Files:** The student should first look at the `.env` file to see the variables.

2.  **Modify `docker-compose.yml`:** The main task is to modify the `app` service definition to use `env_file`.

    *Initial State (Incorrect):*
    ```yaml
    # services:
    #   app:
    #     ...
    #     environment:
    #       - DB_HOST=db
    #       - DB_PASSWORD=a_very_secure_password_123 # Hardcoded!
    ```

    *Final State (Correct):*
    ```yaml
    services:
      app:
        build: ./app
        ports:
          - "8080:8080"
        env_file:
          - ./.env
        depends_on:
          - db
    ```

3.  **Run Compose:**
    ```bash
    docker-compose up --build -d
    ```

After this, `http://localhost:8080` should show the database time, proving the `app` service successfully read the `DB_PASSWORD` from the `.env` file.

## Core Concepts for the Instructor

*   **The `.env` file:** Explain that Docker Compose automatically looks for a file named `.env` in the project directory and makes its variables available for substitution within the `docker-compose.yml` file. It can also be loaded directly into containers with `env_file`.
*   **`.gitignore`:** This is a critical point. Emphasize that the `.env` file should **always** be added to the project's `.gitignore` file. This prevents it from ever being committed to version control. A common practice is to commit a `.env.example` file that shows the required variables without their values.
*   **Production Secrets:** Stress that `env_file` is great for local development, but it is **not** a secure way to manage secrets in production. In production, orchestration platforms like Kubernetes, or cloud provider services (like AWS Secrets Manager, Azure Key Vault, or GCP Secret Manager) should be used. This is an advanced topic, but it's important to set the right context.

## How the Verification Script Works

The `verify.sh` script is similar to the one from Step 07. It uses `docker-compose ps` to ensure the services are running and then `curl` to check that the application can successfully connect to the database, which implicitly proves that the environment variables were loaded correctly.

## Resetting the Lab

1.  Tear down the stack:
    ```bash
    docker-compose down -v
    ```
2.  The student can then be asked to revert the `docker-compose.yml` file to its initial incorrect state to try again.
