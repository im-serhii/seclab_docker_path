# Step 03: The Blueprint (A Colleague's Challenge)

## The Mission

You've just finished familiarizing yourself with the basics of container management when a message from your colleague, Ben, pops up.

> **Ben:** "Hey Alex, I heard you're the one getting into all that Docker stuff. Listen, I'm in a bit of a jam. I built this simple Node.js app to serve as a style guide for the new intern, but I can't get it to run on their machine without a bunch of node version errors. It works on my machine, of course. Any chance your 'Docker magic' can help? I just need a way to package this app so it runs anywhere, no excuses."

This is your first real test. Dr. Sharma's exercises are one thing, but solving a real problem for a colleague is another. You realize this is the perfect opportunity to move from being a consumer of images to a creator.

Your mission: Write a `Dockerfile` for Ben's application to package it into a reliable, portable image.

## What You Will Learn

*   How to solve the "it works on my machine" problem.
*   The basic syntax of a `Dockerfile` (`FROM`, `WORKDIR`, `COPY`, `RUN`, `CMD`).
*   How to build a Docker image from a `Dockerfile` using `docker build`.
*   How to run a container from your own custom image.

## Your Task

Ben has sent you the code, which you can find in the `app` directory. It's a very simple Node.js application. Your task is to create a `Dockerfile` inside that same `app` directory to containerize it.

1.  **Create the `Dockerfile`:**
    In the `app` directory, create a new file named `Dockerfile` (no file extension). This file will be the blueprint for your image.

2.  **Write the Blueprint:**
    Add the following content to your `Dockerfile`. Each line is an instruction that tells Docker how to build the image, step-by-step.

    ```Dockerfile
    # 1. Every great project starts from a solid foundation. We'll use an official Node.js base image.
    FROM node:16-alpine

    # 2. Let's create a dedicated workshop inside the container for our app.
    WORKDIR /usr/src/app

    # 3. To be efficient, we'll copy the manifest first. This lets Docker cache our dependencies.
    COPY package*.json ./

    # 4. Now, we run the installer. This is like setting up your local project.
    RUN npm install

    # 5. With the workshop set up, we can bring in the rest of the source code.
    COPY . .

    # 6. Finally, we tell the container what to do when it starts.
    CMD [ "node", "server.js" ]
    ```

3.  **Build the Image:**
    Time to turn your blueprint into a reality. From your terminal, navigate to the `03-The-Blueprint` directory. Use the `docker build` command to create the image. You'll "tag" it with a name so you can easily refer to it later.

    ```bash
    # Let's name it something Ben will recognize.
    docker build -t ben-style-guide ./app
    ```

4.  **Run the Containerized App:**
    You've built the image! Now, run it as a container to make sure it works.

    ```bash
    docker run --detach --publish 8080:8080 --name style-guide-app ben-style-guide
    ```

5.  **Verify It Works:**
    Open your web browser and navigate to `http://localhost:8080`. You should see the message: "Hello from inside the container! This is our first custom image."

    It works! You can now confidently go back to Ben and tell him you've solved his problem.

## Verifying Your Success

Run the verification script to get official confirmation of your success.

```bash
./verify.sh
```

## Next Steps

A message from Dr. Sharma arrives as you're about to message Ben.

> **Memo from Dr. Sharma:** "I saw you helped Ben. Good initiative. Collaboration is key. Now, back to Project Phoenix. Our new backend will need a database. A database without data is useless. Your next task is to create a database container where the data *persists*. The soul of the application must not be ephemeral."