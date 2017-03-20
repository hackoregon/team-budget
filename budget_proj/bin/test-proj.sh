#! /bin/bash

# PURPOSE: this script is used to test that the DRF app inside the Docker container is actually responding
# Can be used in Travis build or on local developer machine

echo  Running test_proj.sh...

# Run all configured unit tests inside the Docker container
docker-compose -f $PROJ_SETTINGS_DIR/travis-docker-compose.yml run budget-service python manage.py test --no-input
