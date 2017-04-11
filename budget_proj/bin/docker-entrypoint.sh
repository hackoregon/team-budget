#!/bin/bash

echo  Running docker-entrypoint.sh...

#./bin/getconfig.sh
#python manage.py migrate --no-input
python manage.py collectstatic --no-input

# 2017-04-08 troubleshooting the internal behaviour of the app in AWS
# Prepare log files and start outputting logs to stdout
#touch ./gunicorn.log
#touch ./gunicorn-access.log
#tail -n 0 -f ./gunicorn*.log &

# Fire up a lightweight frontend to host the Django endpoints - gunicorn was the default choice
gunicorn budget_proj.wsgi:application -b :8000 --keep-alive 60 --workers 3 --worker-class 'gevent' # gevent used to address ELB/gunicorn issue here https://github.com/benoitc/gunicorn/issues/1194
# other options to try to get past initial ALB health check when deploying a new container image:
# --workers 3 (enough for the # of cores)
# --timeout 90
# vary the keep-alive (up or down?)
# --log-file -
# --log-level=debug,info