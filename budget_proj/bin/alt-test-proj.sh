#! /bin/bash

# This pattern lifted straight from Dan's ecs-push assignment 7 
# https://github.com/hackoregon/hacku-devops-2017/wiki/Assignment-7

echo Starting the migration...
while ! docker-compose run budget-service python manage.py migrate >> /dev/null 2>&1 ; do
    sleep 1
done
echo Migration completed...
echo Starting the testing...
docker-compose run budget-service python manage.py test
echo Testing completed.
