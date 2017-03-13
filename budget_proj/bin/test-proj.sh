#! /bin/bash

# PURPOSE: used to test that the DRF app is running inside the Docker container
# Can be used in Travis build or on local developer machine

echo  Running test_proj.sh...

# Start the container separately to avoid the ImportError on project_config we experience when running "docker-compose run python manage.py test"
docker-compose -f budget_proj/docker-compose.yml start budget-service
# Run all configured unit tests inside the Docker container
docker-compose -f budget_proj/docker-compose.yml exec budget-service python manage.py test
