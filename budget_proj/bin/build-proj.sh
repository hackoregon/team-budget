#! /bin/bash

echo  Running build-proj.sh...

docker-compose -f budget_proj/docker-compose.yml build
