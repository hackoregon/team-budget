#! /bin/bash

# PURPOSE: this script is used to test that the Django app inside the Docker container is actually responding

usage() { echo "Usage: $0 [-l] for a local test or [-t] for a travis test " 1>&2; exit 1; }

echo  Running test_proj.sh...

# Run all configured unit tests inside the Docker container
while getopts ":lt" opt; do
    case "$opt" in
        l)
          docker-compose -f $PROJ_SETTINGS_DIR/local-docker-compose.yml \
          run $DOCKER_IMAGE python manage.py test --no-input
          ;;
        t)
          docker-compose -f $PROJ_SETTINGS_DIR/travis-docker-compose.yml \
          run $DOCKER_IMAGE python manage.py test --no-input
          ;;
        *)
          usage
          ;;
    esac
done
