# Step 10: Instructor Guide (Capstone Project)

## Overview

This is the final exam. It requires the student to apply all the skills they have learned throughout the path without a step-by-step guide. They must analyze the provided source code and create the necessary Dockerfiles and Docker Compose file from scratch.

## Learning Objectives

*   Synthesize knowledge of Dockerfiles, Docker Compose, networking, volumes, and secrets management.
*   Independently containerize a multi-tier application.
*   Troubleshoot connections between services.

## Solution

Here is the complete set of files the student needs to create.

### 1. `.env` file

Located in the root directory (`10-The-Treasure-Island/.env`)

```
# Database Connection Details
POSTGRES_USER=admin
POSTGRES_PASSWORD=supersecret
POSTGRES_DB=capstone_db

# Backend Configuration
DB_HOST=db
DB_USER=admin
DB_PASSWORD=supersecret
DB_NAME=capstone_db
```

### 2. `backend/Dockerfile`

```Dockerfile
# Build stage
FROM node:16-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Production stage
FROM node:16-alpine
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/package.json ./package.json
COPY --from=builder /usr/src/app/server.js ./server.js

CMD ["node", "server.js"]
```

### 3. `frontend/Dockerfile`

```Dockerfile
# Use Nginx to serve static files
FROM nginx:1.21-alpine

# Copy the static files from the frontend directory to the Nginx html directory
COPY . /usr/share/nginx/html
```

### 4. `docker-compose.yml`

Located in the root directory.

```yaml
version: '3.8'

services:
  frontend:
    build: ./frontend
    ports:
      - "80:80"
    depends_on:
      - backend

  backend:
    build: ./backend
    ports:
      - "3001:3001"
    env_file:
      - ./.env
    depends_on:
      - db

  db:
    image: postgres:13-alpine
    env_file:
      - ./.env
    volumes:
      - capstone-db-data:/var/lib/postgresql/data

volumes:
  capstone-db-data:
```

## How the Verification Script Works

The `verify.sh` script is comprehensive:
1.  It runs `docker-compose up` to build and start the services.
2.  It checks that all three services (`frontend`, `backend`, `db`) are running.
3.  It makes a `curl` request to the frontend on `localhost:80`.
4.  It makes a `curl` request to the backend on `localhost:3001/api/data`.
5.  It checks that the response from the backend contains the expected data, which proves the entire chain from frontend to backend to database is working.

## Resetting the Lab

1.  Tear down the stack and remove volumes:
    ```bash
    docker-compose down -v
    ```
2.  Delete the student-created files:
    *   `docker-compose.yml`
    *   `.env`
    *   `frontend/Dockerfile`
    *   `backend/Dockerfile`
