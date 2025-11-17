# Step 09: Securing the Cargo (Managing Secrets)

## The Mission

You're feeling good about your lean, optimized image. As you're about to report your success to Dr. Sharma, an automated, high-priority alert appears in your inbox.

> **SECURITY ALERT - CRITICAL**
>
> **Scanner:** CodeGuard AI
> **Finding:** Hardcoded Secret Detected in `innovatech/project-phoenix/compose/docker-compose.yml`
> **Severity:** CRITICAL
> **Action Required:** Remediate immediately. Do not commit secrets to version control.

Your heart sinks. The password in your `docker-compose.yml` file has been flagged. You realize that in your focus on functionality and optimization, you overlooked a critical security principle. You cannot store secrets directly in your orchestration files.

Your mission is to remediate this critical security flaw by separating your secrets from your configuration using a `.env` file.

## What You Will Learn

*   Why committing secrets to version control is a critical security risk.
*   How to use a `.env` file to manage secrets for local development.
*   How to use the `env_file` directive in Docker Compose to securely inject secrets into your services.

## Your Task

You need to fix the security flaw before anyone notices. You'll use a `.env` file to hold the password and modify your `docker-compose.yml` to read from it.

1.  **Examine the Evidence (`.env` file):**
    A `.env` file has been provided for you. This file is where your secrets will now live. Notice how it defines the passwords for both the database and the application.

    ```
    # This file should be added to .gitignore!
    POSTGRES_PASSWORD=a_very_secure_password_123
    DB_PASSWORD=a_very_secure_password_123
    DB_HOST=db
    ```

2.  **Remediate the Vulnerability (`docker-compose.yml`):**
    Open the `docker-compose.yml` file. It has been pre-configured to use `env_file` for both services. This tells Compose to load the variables from the `.env` file and pass them into the containers.

    ```yaml
    services:
      app:
        build: ./app
        ports:
          - "8080:8080"
        # This line loads the .env file into the container
        env_file:
          - ./.env
        depends_on:
          - db

      db:
        image: postgres
        # This service also needs the password
        env_file:
          - ./.env
        volumes:
          - postgres-data:/var/lib/postgresql/data
    ```
    There is nothing for you to change here, but you must understand *why* this is the secure solution.

3.  **Confirm the Fix:**
    Launch the stack. If the `env_file` directive works as expected, the application should start up and connect to the database successfully, just as it did before.

    ```bash
    docker-compose up --build -d
    ```

4.  **Verify in Your Browser:**
    Navigate to `http://localhost:8080`. The database time proves your application received the password from the `.env` file and connected successfully.

## Verifying Your Success

Run the verification script to confirm that the security vulnerability has been remediated and the application is fully functional.

```bash
./verify.sh
```

## Next Steps

You breathe a sigh of relief. The security alert is resolved. You have learned a vital lesson in production readiness. A final memo from Dr. Sharma arrives.

> **MEMORANDUM**
>
> **SUBJECT:** Final Assessment
>
> I saw the security alert. I also saw your rapid remediation. Learning from mistakes is a sign of a good engineer. You have learned to build, to manage, to connect, to optimize, and to secure.
>
> You are ready for your final assessment. This is not a drill. This is Project Phoenix.