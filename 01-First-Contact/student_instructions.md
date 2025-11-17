# 01-First-Contact: Your First Container

You’ve just joined Innovatech Labs as a junior DevOps engineer. On your first morning, you receive a terse email from your new mentor, Dr. A. Sharma, head of Infrastructure Engineering.

MEMORANDUM
TO: Alex
FROM: Dr. A. Sharma
SUBJECT: First Contact

Welcome to Project Phoenix. Before you touch production systems, you must prove you understand the foundation of everything we build — containers.
Begin with something simple. Launch a single, isolated service. Observe how it behaves. Learn its nature.


## What You Will Learn

In this first crucial step, you will learn the absolute basics of containerization. Specifically, you will learn how to pull a Docker image, run it as a container, and understand basic port mapping. This foundational knowledge is vital for everything that follows.

## Your Task: Launching Your First Service

Your first task is to get acquainted with Docker by launching a simple web server using an Nginx container. This will confirm your Docker environment is set up correctly and introduce you to the core concepts of Docker images and containers.

Here's what you need to do:

1.  **Pull the Nginx image:** Open your terminal or command prompt and use the Docker CLI to pull the official `nginx` image from Docker Hub. This image contains everything needed to run an Nginx web server.
    ```bash
    docker pull nginx
    ```

2.  **Run the Nginx container:** Execute the `nginx` image as a container. You'll need to run it in "detached" mode (meaning it runs in the background) and map a port from your computer to the container's port so you can access the web server.
    *   Use the `--detach` (or `-d`) flag to run the container in the background.
    *   Use the `--publish` (or `-p`) flag to map port `8080` on your local machine to port `80` inside the container.
    *   Give your container a memorable name using `--name my-first-container`.
    ```bash
    docker run --detach --publish 8080:80 --name my-first-container nginx
    ```

3.  **Verify container execution:**
    *   Open your web browser and navigate to `http://localhost:8080`. You should see the default Nginx welcome page. This confirms your container is running and accessible!
    *   You can also use `docker ps` in your terminal to see a list of running containers and confirm `my-first-container` is listed.

## Core Concepts Explained

*   **Docker Hub:** Think of Docker Hub as a public library for Docker images. When you `docker pull nginx`, you're downloading the Nginx blueprint from this library.
*   **Image vs. Container:** The `nginx` image is like a blueprint or a recipe for a web server. When you `docker run` it, you're creating an active, running instance of that blueprint – a container. You can run multiple containers from the same image.
*   **Port Mapping (`-p 8080:80`):** This is crucial for accessing services inside a container from your host machine. The first number (`8080`) is the port on *your computer* (the host), and the second number (`80`) is the port *inside the container* where Nginx is listening. This mapping allows traffic coming to `http://localhost:8080` to be directed to the Nginx server running on port 80 inside the container.
*   **Detached Mode (`--detach` or `-d`):** Running a container in detached mode means it operates in the background, freeing up your terminal for other commands. Without it, your terminal would be attached to the container's output, and you wouldn't be able to type new commands.

## Next Steps

Congratulations on launching your first container! In the next exercise, "02-The-Ships-Log," you will learn how to inspect and manage container logs, which is essential for monitoring and debugging your containerized applications.
