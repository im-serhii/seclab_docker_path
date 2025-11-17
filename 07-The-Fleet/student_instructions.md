# Step 07: The Fleet (Orchestrating with Compose)

## The Mission

As you're admiring your handiwork from the last step, Ben, your frontend colleague, walks over to your desk.

> **Ben:** "Alex, you're a lifesaver. That containerized style guide was perfect. But I have a bigger challenge now. My new prototype has a React frontend and a separate mock API server that it needs to talk to. I'm tired of running `npm start` in two different terminals. Is there a way your Docker magic can run *both* of them with a single command? Like a fleet?"

Ben's question makes you think about the series of `docker` commands you just ran to get your own app and database running. It was clumsy. There must be a way to define a whole multi-container application in one place.

Your research leads you to the perfect tool: **Docker Compose**. It's a tool for defining and running multi-container applications using a single, declarative file.

Your mission: Solve your own problem (and Ben's) by defining your application and database as a fleet of services in a `docker-compose.yml` file.

## What You Will Learn

*   How to manage a multi-container application from a single file.
*   The syntax of `docker-compose.yml` to define services, builds, ports, and volumes.
*   How to use `docker-compose up` to launch an entire application stack.

## Your Task

You'll now codify the architecture you built manually in the last step into a `docker-compose.yml` file.

1.  **Draft the Fleet Blueprint (`docker-compose.yml`):**
    In the `07-The-Fleet` directory, create a `docker-compose.yml` file. This YAML file will describe your entire application stack.

    ```yaml
    version: '3.8'

    services:
      app: # You can name this service anything, e.g., 'backend'
        build: ./app
        ports:
          - "8080:8080"
        environment:
          - DB_HOST=db
          - DB_PASSWORD=mysecretpassword
        depends_on:
          - db

      db: # The service name 'db' becomes its hostname
        image: postgres
        environment:
          - POSTGRES_PASSWORD=mysecretpassword
        volumes:
          - postgres-data:/var/lib/postgresql/data

    volumes:
      postgres-data:
    ```

2.  **Launch the Fleet:**
    This is the moment of truth. From the `07-The-Fleet` directory, run one command to launch everything.

    ```bash
    docker-compose up --build -d
    ```
    Watch as Docker Compose builds your app image, creates a network, creates a volume, and starts both the `db` and `app` containers in the correct order.

3.  **Confirm Operational Status:**
    Navigate to `http://localhost:8080`. You should see the database time, proving that your entire fleet is operational and communicating correctly.

4.  **Decommission the Fleet:**
    To stop and remove everything created by Compose, there's an equally simple command.

    ```bash
    docker-compose down
    ```

## Verifying Your Success

With your stack running, run the verification script to confirm your success.

```bash
./verify.sh
```

## Next Steps

You show your solution to Ben, who is amazed. You've just taken a massive leap in your DevOps journey. A new memo from Dr. Sharma arrives, her timing as impeccable as ever.

> **MEMORANDUM**
>
> **SUBJECT:** Efficiency
>
> I saw your Compose file. It works. But I also saw the image you built for Ben's style guide. It's bloated with things that are not needed to run the application. For Project Phoenix, our images must be lean, secure, and efficient. Production is not a development environment. Optimize it.