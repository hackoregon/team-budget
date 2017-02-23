#! /bin/bash
source ../bin/env.sh

# doing this here only for local builds, shouldn't be needed for Travis
sudo chmod +x ../docker-entrypoint.sh
sudo chmod +x ../bin/start-proj.sh
docker-compose up
