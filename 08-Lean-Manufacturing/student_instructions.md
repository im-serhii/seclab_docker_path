# Step 08: Lean Manufacturing (Optimizing Images)

## The Mission

You're feeling confident after solving Ben's problem with Docker Compose, but your pride is short-lived. A new memo from Dr. Sharma arrives.

> **MEMORANDUM**
>
> **TO:** Alex
> **FROM:** Dr. A. Sharma
> **SUBJECT:** Efficiency
>
> I saw your Compose file. It works. But I also analyzed the image you built for Ben's style guide. It's bloated. It contains development dependencies and other artifacts that have no place in a production environment.
>
> For Project Phoenix, our images must be lean, secure, and efficient. They must contain only what is strictly necessary to run the application. Production is not a development playground.
>
> Your next task is to learn how to build optimized images using **multi-stage builds**. I expect a significant reduction in image size.

Your mission is to refactor your application's `Dockerfile` to use a multi-stage build, separating the build environment from the final production environment to create a lean, production-ready image.

## What You Will Learn

*   The importance of small Docker images for security and performance.
*   How to use multi-stage builds to create optimized production images.
*   How to copy build artifacts from a temporary build stage to a clean production stage.

## Your Task

Dr. Sharma's directive is clear: make it smaller. You will refactor your `Dockerfile` to achieve this.

1.  **Draft the Two-Stage Blueprint:**
    In the `app` directory, create a new `Dockerfile` with two distinct stages. The first stage, the `builder`, will be a workshop where you install everything needed to build the app. The second, `production`, will be a clean room where you copy *only* the finished product.

    ```Dockerfile
    # --- STAGE 1: The Workshop (Builder) ---
    FROM node:16-alpine AS builder
    WORKDIR /usr/src/app
    COPY package*.json ./
    # Install everything, including dev dependencies like nodemon
    RUN npm install
    COPY . .

    # --- STAGE 2: The Clean Room (Production) ---
    FROM node:16-alpine
    WORKDIR /usr/src/app
    # Copy only the necessary production artifacts from the builder stage
    COPY --from=builder /usr/src/app/node_modules ./node_modules
    COPY --from=builder /usr/src/app/package.json ./package.json
    COPY --from=builder /usr/src/app/server.js ./server.js

    # This image will NOT contain nodemon or any other dev dependencies
    CMD [ "node", "server.js" ]
    ```

2.  **Build the Optimized Image:**
    From the `08-Lean-Manufacturing` directory, build your new, optimized image.

    ```bash
    docker build -t optimized-app-image ./app
    ```

3.  **Analyze the Results:**
    You can inspect the size of your new image and compare it to an unoptimized version. The difference should be noticeable. The `devDependencies` like `nodemon` are now gone from the final image, resulting in a smaller, more secure asset.

    ```bash
    docker images optimized-app-image
    ```

## Verifying Your Success

Dr. Sharma expects to see a smaller image. The verification script will build your image and check that its size is below a reasonable threshold for a production application.

```bash
./verify.sh
```

## Next Steps

You've successfully created a lean, production-ready image. As you prepare to report your success, an automated alert from Innovatech's security team pops up, flagging your Compose file from the previous step. It seems your journey into production-readiness is not over yet.