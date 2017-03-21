#!/bin/bash

echo  Running docker-entrypoint.sh...

export PATH=$PATH:~/.local/bin # necessary to help locate the awscli binaries which are pip installed --user
#./bin/getconfig.sh
#python manage.py migrate --no-input
#python manage.py collectstatic --no-input

# Fire up a lightweight frontend to host the Django endpoints - gunicorn was the default choice
gunicorn budget_proj.wsgi:application -b :8000
