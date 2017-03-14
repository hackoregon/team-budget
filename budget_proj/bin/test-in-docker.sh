#! /bin/bash

echo Running test-in-docker.sh...

source /code/bin/env.sh

echo Did source expose the env vars?
echo DATABASE_PORT $DATABASE_PORT

python manage.py test