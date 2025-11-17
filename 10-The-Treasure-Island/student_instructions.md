# Step 10: The Phoenix Rises (The Capstone Project)

## The Final Mission

The final memo from Dr. Sharma arrives. This is the one that matters.

> **MEMORANDUM**
>
> **TO:** Alex
> **FROM:** Dr. A. Sharma
> **SUBJECT:** Final Assessment: Project Phoenix
>
> I saw the security alert. I also saw your rapid remediation. Learning from mistakes is a sign of a good engineer. 
>
> You have learned to build, to manage, to connect, to optimize, and to secure. You have helped your colleagues and strengthened your own workflow. The training is over.
>
> Now, the real work begins. I have given you access to the initial source code for the authentication service of Project Phoenix. It is a three-tier application: a frontend, a backend API, and a database.
>
> Your final assessment is this: **Containerize it. Orchestrate it.**
>
> I am not providing a step-by-step guide. I am providing requirements. You have all the skills you need. Show me you are ready to lead this initiative.

This is it. Your mission is to take the provided source code and, from scratch, create the Dockerfiles and Docker Compose file to run the entire application stack, applying all the best practices you have learned.

## What You Will Accomplish

*   Demonstrate mastery of Docker and Docker Compose.
*   Architect a containerization strategy for a real-world, multi-tier application.
*   Solidify your position as a technical leader at Innovatech.

## Project Phoenix: Service Requirements

Dr. Sharma has laid out the specifications. You must meet them all.

1.  **Orchestration:** Create a `docker-compose.yml` file in the root `10-The-Treasure-Island` directory.

2.  **Secrets Management:** Create a `.env` file in the root directory to store all passwords, users, and other configuration. This file must not contain any hardcoded secrets.

3.  **Database Service (`db`):**
    *   Image: `postgres:13-alpine`
    *   Data: Must persist in a named volume called `capstone-db-data`.
    *   Configuration: All settings (user, password, db name) must be loaded from your `.env` file.

4.  **Backend Service (`backend`):**
    *   Build: Must be built from a `Dockerfile` you create in the `backend` directory.
    *   Optimization: The `Dockerfile` must use a multi-stage build to create a lean production image.
    *   Networking: Must be able to communicate with the `db` service.
    *   Configuration: Must get all database connection details from the `.env` file.

5.  **Frontend Service (`frontend`):**
    *   Build: Must be built from a `Dockerfile` you create in the `frontend` directory.
    *   Technology: Use an `nginx:alpine` image to serve the static `index.html` and `app.js` files.
    *   Accessibility: Must be accessible from your browser on port `80`.

## Your Task

This is your canvas. You know what to do.

1.  Analyze the source code in the `frontend` and `backend` directories.
2.  Architect and create the `Dockerfile` for the `backend`.
3.  Architect and create the `Dockerfile` for the `frontend`.
4.  Define all secrets and configurations in your `.env` file.
5.  Construct the `docker-compose.yml` file to bring all services, networks, and volumes together.
6.  Launch the Phoenix: `docker-compose up --build -d`.
7.  Verify that `http://localhost` shows the frontend, and that clicking the button successfully retrieves and displays data from the database via the backend.

## Verifying Your Success

This is the final test. Run the verification script. It will perform a full integration test on your running application stack.

```bash
./verify.sh
```

## Congratulations!

As the verification script returns a success message, you see an email notification from HR and Dr. Sharma. The subject: "Promotion: Technical Lead, Project Phoenix." 

You have completed the DevOps Journey. You are no longer just a developer; you are an architect of modern applications.