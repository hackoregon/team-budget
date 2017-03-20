# Running the APIs in Docker
You can develop and test against the entire set of dependencies for the Django APIs using a Docker container.

This reduces the amount of software you'll have to install and keep running correctly on your system, and improve your ability to stay current with your fellow developers.

## Prerequisites
You'll need to install two pieces of software:
- Docker
- Docker Compose

If you're running Mac OS X on a MacBook from 2010 or later, the install for both of these is simple:
- download the Docker DMG file [here](https://docs.docker.com/docker-for-mac/install/)
- install and you're ready to go!

If you're running an older MacBook, or running Windows, see [here](https://github.com/hackoregon/devops-17/blob/master/HOWTO%20Guides/HOWTO-Docker-on-OSX-with-Docker-Toolbox.md) for instructions on using the Docker Toolkit and still get the same basic experience.

If you're running a friendly Linux:
- installing Docker - try one of these links [here](https://www.docker.com/community-edition) (Note: we've never tried this - send us feedback on the #dev-ops channel)
- installing Docker Compose - use the `curl` command you'll find [here](https://github.com/docker/compose/releases)

Ping us if you need instructions on installing Docker on Linux.

## Build the Docker container
At present, each developer will have to build the docker container on their own computer.  (In the future, based on demand, we may pre-build the container image and enable developers to download the latest.)

Here's how:

1. clone the current repo to your local system (or `git pull` if you already have it cloned and just need to update to latest code)
2. run `cd team-budget` (i.e. into the folder where you find the repo)
3. run `cp ./budget_proj/bin/env-template.sh ./budget_proj/bin/env.sh`
4. run `cp ./budget_proj/budget_proj/project_config_template.py ./budget_proj/budget_proj/project_config.py`
5. edit `project_config.py` to add the values for your chosen database plus the Django secret
6. run `source budget_proj/bin/env.sh`
7. run `./budget_proj/bin/start-proj.sh -l`
    - This script already includes the `--build` parameter for `docker-compose`, so that if you've made changes to the Django code or anything else used by Docker to build the container, Docker will include the changes made since the last start (build) of the container

Once the container is running, you'll find the API endpoints at http://127.0.0.1:8000.  (If you're using Docker Toolbox, they'll be available at  http://192.168.99.100:8000 instead).

## How can you interrogate the running server in the container?

Sometimes you'll have to troubleshoot the server - look at log files, look for a missing file, whatever.

This is when you use the Docker cli:

```
docker exec -it [container_id or name] /bin/bash
```

(Getting the container_id or name for the running Docker container is easy - just run `docker ps`.)

## Further info
[Tips for Docker Toolbox on OS X](https://github.com/hackoregon/devops-17/blob/master/HOWTO%20Guides/HOWTO-Docker-on-OSX-with-Docker-Toolbox.md)
[Cleaning up Docker Containers and Images](https://github.com/hackoregon/devops-17/blob/master/HOWTO%20Guides/HOWTO%20Cleanup%20Docker%20Containers%20and%20Images.md)
