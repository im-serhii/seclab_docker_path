# Step 04: The Soul of the Application (Using Volumes)

## The Mission

Just as you hit 'send' on your message to Ben with the solution, a new memo from Dr. Sharma arrives.

> **MEMORANDUM**
>
> **TO:** Alex
> **FROM:** Dr. A. Sharma
> **SUBJECT:** Initiative
>
> I saw you helped Ben. Good initiative. Collaboration and unblocking others are key traits for a technical lead.
>
> Now, back to Project Phoenix. The application you built for Ben was stateless. If you destroy the container, nothing of value is lost. This is not true for a database. A database without data is just an empty shell. Its data is its soul.
>
> Your next task is to create a database container for Project Phoenix where the data **persists**. The container can be destroyed, recreated, or updated, but the data must remain. I expect you to learn how to manage the soul of the application.

Your mission is to run a `postgres` database container and use a Docker Volume to ensure its data is persistent.

## What You Will Learn

*   The concept of stateless vs. stateful containers.
*   What Docker Volumes are and why they are the key to data persistence.
*   How to create and manage a named volume (`docker volume create`).
*   How to attach a volume to a container to safeguard its data.

## Your Task

Dr. Sharma's message is clear: the data is everything. You need to create a volume and attach it to a Postgres container.

1.  **Forge the Soul-Safe (Create a Named Volume):**
    You will create a "named" volume. Think of it as a secure, managed vault for your data that lives outside the container.

    ```bash
    docker volume create postgres-data
    ```

2.  **Launch the Database Guardian:**
    Run the official `postgres` container. You must provide a password for the database user and, most importantly, connect your volume to the container's data directory.

    *   `--mount source=postgres-data,target=/var/lib/postgresql/data`: This command tells the container "Store your critical data not inside yourself, but in the `postgres-data` vault."

    ```bash
    docker run --detach --name my-database -e POSTGRES_PASSWORD=mysecretpassword --mount source=postgres-data,target=/var/lib/postgresql/data postgres
    ```

3.  **Simulate a Catastrophe:**
    The container is running. Let's test your setup. What if someone accidentally removes the container?

    ```bash
    docker stop my-database
    docker rm my-database
    ```
    The container is gone. In a normal setup, all data would be lost.

4.  **Resurrect the Guardian:**
    Launch a new container with the *exact same* `docker run` command from Step 2. Because the command points to the same vault (`postgres-data`), the new container will pick up right where the old one left off, with all the data intact.

    ```bash
    docker run --detach --name my-database -e POSTGRES_PASSWORD=mysecretpassword --mount source=postgres-data,target=/var/lib/postgresql/data postgres
    ```

## Verifying Your Success

Run the verification script. It will confirm that your new database guardian is running and is correctly connected to the `postgres-data` vault.

```bash
./verify.sh
```

## Next Steps

You've successfully protected the application's soul. You now understand how to manage stateful services. As you ponder this, you realize how slow it was to rebuild Ben's app every time you made a change. There must be a better way for local development...
