#! /bin/bash

echo Running test-in-docker.sh...

#source /code/bin/env.sh

#echo Did source expose the env vars?
echo DATABASE_PORT $DATABASE_PORT

docker-compose -f budget_proj/docker-compose.yml run budget-service python manage.py test