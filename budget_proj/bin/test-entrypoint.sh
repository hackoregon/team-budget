#!/bin/bash
export PATH=$PATH:~/.local/bin
source /code/bin/get-ssm-parameters.sh
## TROUBLESHOOTING ONLY
echo Did get-ssm-parameters.sh pull down the params successfully?
env
#./bin/getconfig.sh
#python manage.py migrate --noinput
#python manage.py test --no-input --keepdb
pytest
