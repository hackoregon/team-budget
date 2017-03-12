#! /bin/bash

# PURPOSE: used to test that the DRF app is running inside the Docker container
# Can be used in Travis build or on local developer machine

echo  Running test_proj.sh...

# Get environment variables if running script in LOCAL (not INTEGRATION or PRODUCTION)
source ./budget_proj/bin/env.sh

# Run all configured unit tests inside the Docker container
docker-compose -f budget_proj/docker-compose.yml --verbose run budget-service python manage.py test