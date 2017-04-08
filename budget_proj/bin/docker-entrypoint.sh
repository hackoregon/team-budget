#!/bin/bash

echo  Running docker-entrypoint.sh...

#./bin/getconfig.sh
#python manage.py migrate --no-input
python manage.py collectstatic --no-input

# Fire up a lightweight frontend to host the Django endpoints - gunicorn was the default choice
gunicorn budget_proj.wsgi:application -b :8000 --keep-alive 60 --workers 5 --worker-class 'gevent' # gevent used to address ELB/gunicorn issue here https://github.com/benoitc/gunicorn/issues/1194
# other options to try to get past initial ALB health check when deploying a new container image:
# --workers 3 (enough for the # of cores)
# --timeout 90
# vary the keep-alive (up or down?)
