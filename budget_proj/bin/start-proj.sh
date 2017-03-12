#! /bin/bash

# PURPOSE: used to launch the DRF app inside the Docker container
# Can be used on local developer machine; if used in Travis build, will fail the build after 10min timeout

echo  Running start-proj.sh...

# Get environment variables if running script in LOCAL (not INTEGRATION or PRODUCTION)
source ./budget_proj/bin/env.sh

# Builds and launches the Docker container to be run in daemon mode - requires [CTRL]-C to stop the container
docker-compose -f budget_proj/docker-compose.yml up --build
