#! /bin/bash

# PURPOSE: used to test that the DRF app is running inside the Docker container
# Can be used in Travis build or on local developer machine

echo  Running test_proj.sh...

# Run all configured unit tests inside the Docker container

# ??? how to feed the built image into this step ???

docker-compose -f budget_proj/docker-compose.yml start budget-service
docker-compose -f budget_proj/docker-compose.yml exec budget-service python manage.py test
