#!/bin/bash

echo  Running docker-entrypoint.sh...

set -e

echo Debug: $DEBUG

# Pull in environment variables values from AWS Parameter Store, and preserve the exports
# source usage per https://stackoverflow.com/q/14742358/452120
source /code/bin/get-ssm-parameters.sh
echo Did get-ssm-parameters.sh pull down the params successfully?
env

python manage.py migrate --no-input
python manage.py collectstatic --no-input

# Fire up a lightweight frontend to host the Django endpoints - gunicorn was the default choice
# gevent used to address ELB/gunicorn issue here https://github.com/benoitc/gunicorn/issues/1194
gunicorn $PROJECT_NAME.wsgi:application -b :8000 --worker-class 'gevent' --workers 1

# The access-log settings will enable detailed logging in CloudWatch to trap every incoming HTTP request - useful for debugging
# Output looks like this:
#
# 10.180.12.63 [21/Apr/2017:15:16:44 +0000] GET /budget/ HTTP/1.1 200 3698 - ELB-HealthChecker/2.0 0.022691
#
# gunicorn budget_proj.wsgi:application -b :8000 --worker-class 'gevent' --workers 1 --access-logfile - --access-logformat '%(h)s %(t)s %(m)s %(U)s %(q)s %(H)s %(s)s %(B)s %(f)s %(a)s %(L)s'
