#!/bin/bash
./bin/getconfig.sh
#python manage.py migrate --noinput
python manage.py test --no-input
