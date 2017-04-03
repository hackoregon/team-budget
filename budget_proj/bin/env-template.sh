#! /bin/bash

export PROJ_SETTINGS_DIR=budget_proj # This sets up access for other scripts to the app's subdirectory
export DOCKER_IMAGE=budget-service # This is used to identify the service being run by test-proj.sh

###############
# NOTE: as of 2017-03-20, the following configuration pattern is not in use for secrets management
# see budget_proj/project_config_template.py for the supported configuration file

# To connect to database, make a copy of this file as "env.sh" and replace VALUES as noted.
# Then source the file in the shell where you will build or run the server. For example:
# $ source ./build_proj/bin/env.sh

export DATABASE_ENGINE='PUT_DATABASE_ENGINE_HERE' # e.g. django.db.backends.postgresql
export DATABASE_NAME='PUT_DATABASE_NAME_HERE'
export DATABASE_HOST='PUT_HOST_FQDN_OR_IP_ADDRESS_HERE'
export DATABASE_PORT='5432'
export DATABASE_USER='PUT_DATABASE_LOGIN_ID_HERE'
export DATABASE_PASSWORD='PUT_DATABASE_PASSWORD_HERE'
export DJANGO_SECRET_KEY='PUT_DJANGO_SECRET_HERE'
###############

echo "##############################"
echo  LOCAL CONFIG SETTINGS
echo "##############################"
#echo  DATABASE_ENGINE $DATABASE_ENGINE
#echo  DATABASE_NAME $DATABASE_NAME
#echo  DATABASE_HOST $DATABASE_HOST
#echo  DATABASE_PORT $DATABASE_PORT
#echo  DATABASE_USER $DATABASE_USER
#echo  DATABASE_PASSWORD $DATABASE_PASSWORD
#echo  DJANGO_SECRET_KEY $DJANGO_SECRET_KEY
echo  DOCKER_IMAGE $DOCKER_IMAGE
echo  PROJ_SETTINGS_DIR $PROJ_SETTINGS_DIR
