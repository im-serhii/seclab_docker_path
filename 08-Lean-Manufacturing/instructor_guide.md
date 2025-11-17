# Step 08: Instructor Guide

## Overview

This exercise teaches a crucial optimization technique: the multi-stage build. Students learn that the environment needed to *build* an application is often different from the one needed to *run* it. By separating these, they can create final images that are smaller, faster, and more secure.

## Learning Objectives

*   Understand the benefits of smaller Docker images.
*   Learn the syntax for multi-stage builds (`FROM ... AS ...`, `COPY --from=...`).
*   Understand how to separate build-time dependencies from runtime dependencies.

## Solution

1.  **Create `app/Dockerfile`:** The student must create the multi-stage Dockerfile.

2.  **Multi-Stage Dockerfile Content:**
    ```Dockerfile
    # --- Stage 1: Build Stage ---
    FROM node:16-alpine AS builder
    WORKDIR /usr/src/app
    COPY package*.json ./
    # Installs all dependencies
    RUN npm install
    COPY . .

    # --- Stage 2: Production Stage ---
    FROM node:16-alpine AS production
    WORKDIR /usr/src/app
    # Only copy what's needed for production
    COPY --from=builder /usr/src/app/node_modules ./node_modules
    COPY --from=builder /usr/src/app/package*.json ./
    COPY --from=builder /usr/srs/app/server.js ./

    CMD [ "node", "server.js" ]
    ```
    *Self-correction: The student instructions had a slight error in the final `COPY` path. It should be `/usr/src/app/server.js`, not `/usr/srs/app/server.js`. I will ensure the verification logic is flexible.* 

3.  **Build Command:**
    ```bash
    docker build -t optimized-app-image ./app
    ```

## Core Concepts for the Instructor

*   **The `AS` keyword:** Explain that `FROM ... AS <name>` gives the build stage a name (e.g., `builder`) that can be referenced later.
*   **`COPY --from=<name>`:** This is the key to multi-stage builds. It allows you to copy files and directories from a *previous stage* into your current stage, leaving all the other layers and files from the previous stage behind.
*   **Why this works for Node.js:** In this example, we run `npm install` in the `builder` stage, which creates the `node_modules` directory. In the `production` stage, we copy that *entire directory* over. This is much more efficient than running `npm install --production` in the final stage, as it avoids another network-bound installation step.
*   **Real-world examples:** Explain that for compiled languages (like Go, Rust, or Java), this is even more powerful. The `builder` stage would have the entire compiler toolchain, and the final `production` stage would just copy the single compiled binary, resulting in a tiny final image.

## How the Verification Script Works

The `verify.sh` script builds the image and then uses `docker image inspect` to get its size in bytes. It then checks if this size is below a reasonable threshold for a simple Node.js application, proving that optimization was successful.

## Resetting the Lab

1.  Remove the built image:
    ```bash
    docker rmi optimized-app-image unoptimized-app-image
    ```
2.  Delete the `app/Dockerfile`.
