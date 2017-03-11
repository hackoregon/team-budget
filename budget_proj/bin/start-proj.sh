#! /bin/bash
source ./budget_proj/bin/env.sh

docker-compose -f budget_proj/docker-compose.yml up --build
