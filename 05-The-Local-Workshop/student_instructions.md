# Step 05: The Local Workshop (A Developer's Insight)

## The Mission

You've successfully created a persistent database, a critical step for Project Phoenix. But something has been bothering you. When you helped Ben back in Step 03, you had to rebuild the entire Docker image every time you made a small code change. It was slow and clunky.

"There has to be a better way," you think to yourself. "How can I work on my code locally and see the changes inside the container instantly?"

After some research, you discover the answer: a **Bind Mount**. Unlike a volume, which is managed by Docker, a bind mount maps a directory from your own computer directly into the container. It's like creating a live portal between your code editor and the running container.

Your mission: To prove this concept, you decide to set up a local development environment for a Node.js app that features instant, live reloading.

## What You Will Learn

*   The difference between a Docker Volume (for data) and a Bind Mount (for code).
*   How to use a bind mount to create an efficient development loop.
*   How a file-watching tool like `nodemon` complements a bind mount.

## Your Task

You decide to experiment with the app you built for Ben.

1.  **Upgrade the Toolkit (`nodemon`):**
    You realize that just seeing the files change isn't enough; the server process inside the container needs to restart. You find a tool called `nodemon` that does exactly this. You'll add it to the project as a development dependency. In your terminal, navigate to the `05-The-Local-Workshop/app` directory.

    ```bash
    cd app
    npm install --save-dev nodemon
    cd ..
    ```
    Then, you'll add a `dev` script to the `package.json` to run it.

    ```json
    "scripts": {
      "start": "node server.js",
      "dev": "nodemon server.js"
    },
    ```

2.  **Create a Development Blueprint:**
    You need a `Dockerfile` that uses this new tool. You create one in the `app` directory.

    ```Dockerfile
    FROM node:16-alpine
    WORKDIR /usr/src/app
    COPY package*.json ./
    RUN npm install
    COPY . .
    # The key is to run the 'dev' script!
    CMD [ "npm", "run", "dev" ]
    ```
    Now, build the development-focused image from the `05-The-Local-Workshop` directory:
    ```bash
    docker build -t dev-image ./app
    ```

3.  **Open the Portal (Run with a Bind Mount):**
    This is your "Aha!" moment. You'll run the container, but this time you'll use `--mount` with `type=bind` to create a live link between your local `app` directory and the `/usr/src/app` directory inside the container.

    ```bash
    docker run --detach --name dev-app --publish 8080:8080 --mount type=bind,source=$(pwd)/app,target=/usr/src/app dev-image
    ```

4.  **Witness the Magic:**
    *   Visit `http://localhost:8080`. It shows the original message.
    *   Now, open `app/server.js` in your code editor and change the message inside `res.send()` to "This is so much faster!"
    *   Save the file.
    *   Refresh your browser. The change is there instantly. No rebuild. No waiting.

## Verifying Your Success

Run the verification script to confirm that your live-reloading environment is set up correctly.

```bash
./verify.sh
```

## Next Steps

This discovery is a game-changer for your workflow. You make a note to share it with Ben later. Just then, a new memo from Dr. Sharma arrives, pulling you back to the main mission for Project Phoenix.

> **MEMORANDUM**
>
> **SUBJECT:** Architecture
>
> The pieces exist: your application, the database. But they are islands. An application is a conversation. Your next task is to build the bridges between them. Make them talk.