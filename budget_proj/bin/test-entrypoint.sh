#!/bin/bash
export PATH=$PATH:~/.local/bin # necessary to help locate the awscli binaries which are pip installed --user
./bin/getconfig.sh
#python manage.py migrate --noinput
python manage.py test --no-input
