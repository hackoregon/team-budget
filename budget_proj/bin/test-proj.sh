#! /bin/bash

# Get environment variables if running script in LOCAL (not INTEGRATION or PRODUCTION)
source ./budget_proj/bin/env.sh

# Run all configured unit tests inside the Docker container
docker-compose -f budget_proj/docker-compose.yml run budget-service python manage.py test