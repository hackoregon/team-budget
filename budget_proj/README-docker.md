# Running the APIs in Docker
You can develop and test against the entire set of dependencies for the Django APIs using a Docker container.

This reduces the amount of software you'll have to install and keep running correctly on your system, and improve your ability to stay current with your fellow developers.

## Prerequisites
You'll need to install two pieces of software: Docker and Docker Compose.

If you're running a MacBook from 2010 or later, the install is simple:
- download the Docker DMG file [here](https://docs.docker.com/docker-for-mac/install/)
- install and you're ready to go!

If you're running an older MacBook, or running Windows, see [here](https://github.com/hackoregon/devops-17/blob/master/HOWTO%20Guides/HOWTO-Docker-on-OSX-with-Docker-Toolbox.md) for instructions on using the Docker Toolkit and still get the same basic experience.

Ping us if you need instructions on installing Docker on Linux.

## Build the Docker container
At present, each developer will have to build the docker container on their own computer.  (In the future, based on demand, we may pre-build the container image and enable developers to download the latest.)

Here's how:

- clone the current repo to your local system (or `git pull` if you need to update to latest code)
- `cd` into the folder where you find `Dockerfile`
- run `docker-compose up` if you're building from fresh files
- run `docker-compose up --build` if you've made changes to the Django code or anything else used by Docker to build the container, so that it picks up any changes

You'll find the Django endpoints at http://127.0.0.1:8000 (or http://192.168.99.100:8000 if you're using Docker Toolbox).

## How can you interrogate the running server in the container?

Sometimes you'll have to check into the server - look at log files, look for a missing file, whatever.

Here's where you use the docker cli:

```
docker exec -it [container_id or name] /bin/bash
```

(And getting the container_id or name is easy - just run `docker ps`)

## Further info
[Tips for Docker Toolbox on OS X](https://github.com/hackoregon/devops-17/blob/master/HOWTO%20Guides/HOWTO-Docker-on-OSX-with-Docker-Toolbox.md)
[Cleaning up Docker Containers and Images](https://github.com/hackoregon/devops-17/blob/master/HOWTO%20Guides/HOWTO%20Cleanup%20Docker%20Containers%20and%20Images.md)
