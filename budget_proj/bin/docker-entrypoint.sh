#!/bin/bash

echo  Running docker-entrypoint.sh...

#./bin/getconfig.sh
#python manage.py migrate --no-input
#python manage.py collectstatic --no-input

# Fire up a lightweight frontend to host the Django endpoints - gunicorn was the default choice
gunicorn budget_proj.wsgi:application -b :8000 --timeout 90 -w 5 -k 'eventlet' # eventlet used to address ELB/gunicorn issue here https://github.com/benoitc/gunicorn/issues/1194
