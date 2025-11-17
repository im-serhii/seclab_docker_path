# Step 02: The Ship's Log (Mastering Control)

## The Mission

As promised, a new memo from Dr. Sharma appears.

> **MEMORANDUM**
>
> **TO:** Alex
> **FROM:** Dr. A. Sharma
> **SUBJECT:** Re: First Contact
>
> Acceptable. You can follow instructions. But creation is easy. Control is harder. An uncontrolled tool is a liability. A server you cannot stop or inspect is a rogue element.
>
> Your next task is to learn to be the master of the asset you just deployed. Start it. Stop it. Listen to what it's telling you by reading its logs. And finally, learn how to decommission it cleanly.
>
> Do not proceed until you have full control.

Your mission is to learn the commands that manage a container's lifecycle, using the `my-first-container` you deployed in the last step.

## What You Will Learn

*   How to list running and stopped containers.
*   How to stop a running container.
*   How to start a stopped container.
*   How to view the logs of a container.
*   How to remove a container.

## Your Task

Dr. Sharma expects you to have complete mastery. Practice these commands on the `my-first-container`.

1.  **Conduct a Status Check:**
    First, see what's currently running. The `docker ps` command is your control panel.

    ```bash
    docker ps
    ```

2.  **Review the Ship's Log:**
    Every action on the server is logged. You need to know how to read these logs. Use the `docker logs` command.

    ```bash
    docker logs my-first-container
    ```

3.  **Cease Operations:**
    A critical skill is knowing how to stop a service. Use the `docker stop` command.

    ```bash
    docker stop my-first-container
    ```
    Verify that `http://localhost:8080` is now offline.

4.  **Account for All Assets:**
    The container is stopped, but it still exists. Use the `--all` flag to see all assets, running or not.

    ```bash
    docker ps --all
    ```

5.  **Re-activate the Service:**
    An operator must also know how to restart a service. Use `docker start`.

    ```bash
    docker start my-first-container
    ```
    Verify that `http://localhost:8080` is back online.

6.  **Decommission the Asset:**
    For this training exercise, the final step is to decommission the container. This requires stopping it and then removing it permanently with `docker rm`.

    ```bash
    docker stop my-first-container
    docker rm my-first-container
    ```

## Verifying Your Success

To prove to Dr. Sharma that you have full control, you must successfully decommission the asset. The verification script will check that the container has been properly removed.

```bash
./verify.sh
```

## Next Steps

You've demonstrated control. As you're about to report back to Dr. Sharma, a message from your colleague Ben pops up, presenting you with a new, unexpected challenge...