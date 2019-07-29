#!/bin/bash
export PATH=$PATH:~/.local/bin
# https://matthew-brett.github.io/pydagogue/installing_on_debian.html
export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PATH=$PY_USER_BIN:$PATH
source /code/bin/get-ssm-parameters.sh
## TROUBLESHOOTING ONLY
echo Did get-ssm-parameters.sh pull down the params successfully?
env
#./bin/getconfig.sh
#python manage.py migrate --noinput
#python manage.py test --no-input --keepdb
pytest
