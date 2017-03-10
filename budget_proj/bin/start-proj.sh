#! /bin/bash
source ./bin/env.sh

docker-compose -f budget_proj/docker-compose.yml up --build
