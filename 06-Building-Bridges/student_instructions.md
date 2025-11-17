# Step 06: Building Bridges (Container Networking)

## The Mission

Your discovery of bind mounts was a personal breakthrough, but the memo from Dr. Sharma brings you back to the main architecture of Project Phoenix.

> **MEMORANDUM**
>
> **TO:** Alex
> **FROM:** Dr. A. Sharma
> **SUBJECT:** Architecture
>
> The pieces exist: your application, the database. But they are islands, isolated from each other. An application is a conversation. A frontend must talk to a backend; a backend must talk to a database.
>
> By default, my containers provide isolation. This is a feature, not a bug. It is your job to build the bridges between them in a controlled manner.
>
> Your next task is to create a dedicated virtual network and place both your application and database containers on it. They must be able to communicate.

Your mission is to make the app and database containers talk to each other by connecting them to the same Docker network.

## What You Will Learn

*   The basics of Docker networking.
*   How to create a custom bridge network.
*   How to attach containers to a network at runtime.
*   How Docker provides automatic DNS resolution for containers on the same network.

## Your Task

Dr. Sharma has given you the blueprint. Now you need to build the bridge.

1.  **Survey the Land (Create a Docker Network):**
    First, you need to lay the foundation for your bridge. Create a new network for your application.

    ```bash
    docker network create my-app-net
    ```

2.  **Deploy the First Pier (The Database):**
    Run the `postgres` container. Crucially, use the `--network` flag to attach it to the network you just created. Give it a name that your app can use to find it.

    ```bash
    docker run --detach --name my-database --network my-app-net -e POSTGRES_PASSWORD=mysecretpassword postgres
    ```

3.  **Prepare the Second Pier (The Application):**
    The `app` directory contains a new version of the application that knows how to talk to a database. You need to build the image for it. Create an `app/Dockerfile`:

    ```Dockerfile
    FROM node:16-alpine
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    CMD [ "node", "server.js" ]
    ```
    And build it (from the `06-Building-Bridges` directory):
    ```bash
    docker build -t db-app-image ./app
    ```

4.  **Connect the Bridge (Run the App):**
    Run your application container, attaching it to the *same network*. This is what completes the connection, allowing the two containers to communicate.

    ```bash
    docker run --detach --name my-app --network my-app-net --publish 8080:8080 db-app-image
    ```

5.  **Confirm the Connection:**
    Open `http://localhost:8080`. If the bridge is built correctly, you will see a message showing the current time from the database. This proves your `my-app` container found and communicated with the `my-database` container across the network.

## Verifying Your Success

Run the verification script to confirm to Dr. Sharma that your architecture is sound.

```bash
./verify.sh
```

## Next Steps

You watch the successful response from the server. It feels good. But as you look at the series of commands you had to run, you can't help but think it's clumsy. Just then, Ben walks over. "Hey Alex, that Docker thing was great! Now I have a frontend app *and* a mock API server that need to run together. Can you make them both run with one command?" His question sparks an idea...