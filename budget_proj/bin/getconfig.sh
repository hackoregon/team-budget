#! /bin/bash

# Declare config file for de-duplication
export CONFIG_FILE='project_config.py' # with some work, env.sh could alternatively be used

# Get Configuration
echo "##############################"
echo  Running getconfig.sh...
echo  CONFIG SETTINGS
echo "##############################"
echo  PROJ_SETTINGS_DIR $PROJ_SETTINGS_DIR

if [ "$DEPLOY_TARGET" == "local" ]; then
    echo -e "#####################################################"
    echo -e  USING LOCAL CONFIG - MAKE SURE YOU HAVE A LOCAL CONFIG in bin/$CONFIG_FILE
    echo -e "#####################################################"
else
    echo  CONFIG_BUCKET $CONFIG_BUCKET
    echo  DEPLOY_TARGET $DEPLOY_TARGET
    echo -e "########################################"
    echo -e  "USING THE $CONFIG_BUCKET CONFIG BUCKET"
    echo -e  "USING $DEPLOY_TARGET CONFIG"
    echo -e "########################################"
    export PATH=$PATH:~/.local/bin # necessary to help locate the awscli binaries which are pip installed --user
    aws s3 cp \
          s3://$CONFIG_BUCKET/$DEPLOY_TARGET/$CONFIG_FILE \
          $PROJ_SETTINGS_DIR/$CONFIG_FILE;

  echo "#### CONFIG COPY COMPLETE ###"

fi
