#! /bin/bash

usage() { echo "Usage: $0 [-l] for a local build or [-t] for a travis build " 1>&2; exit 1; }

# PURPOSE: used to launch the Django app inside the Docker container
# Can be used on local developer machine; if used in Travis build, will fail the build after 10min timeout

echo  Running start-proj.sh...

# Builds and launches the Docker container to be run in daemon mode - requires [CTRL]-C to stop the container
while getopts ":lt" opt; do
    case "$opt" in
        l)
          docker-compose -f $PROJ_SETTINGS_DIR/local-docker-compose.yml up --build
          ;;
        t)
          docker-compose -f $PROJ_SETTINGS_DIR/travis-docker-compose.yml up
          ;;
        *)
          usage
          ;;
    esac
done
