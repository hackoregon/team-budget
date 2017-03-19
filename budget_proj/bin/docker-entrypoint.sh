#!/bin/bash

echo  Running docker-entrypoint.sh...

export PATH=$PATH:~/.local/bin
./budget_proj/bin/getconfig.sh
python manage.py collectstatic --noinput
# Fire up a lightweight frontend to host the DRF endpoints - gunicorn is convenient but other engines can be considered
#gunicorn homelessAPI.wsgi:application -b :8000
python manage.py test --no-input