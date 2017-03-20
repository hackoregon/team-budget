#! /bin/bash

# Declare environment file for de-duplication
export CONFIG_FILE='project_config.py'

# Get Configuration
echo "##############################"
echo  Running getconfig.sh...
echo  CONFIG SETTINGS
echo "##############################"
echo  PROJ_SETTINGS_DIR $PROJ_SETTINGS_DIR
echo  DEPLOY_TARGET $DEPLOY_TARGET
echo  CONFIG_BUCKET $CONFIG_BUCKET

if [ "$DEPLOY_TARGET" == "local" ]; then
    echo -e "#####################################################"
    echo -e  USING LOCAL CONFIG - MAKE SURE YOU HAVE A LOCAL CONFIG in bin/$CONFIG_FILE
    echo -e "#####################################################"
else
    echo -e "########################################"
    echo -e  "USING $DEPLOY_TARGET CONFIG"
    echo -e  "USING THE $CONFIG_BUCKET CONFIG BUCKET"
    echo -e "########################################"
    export PATH=$PATH:~/.local/bin
    aws s3 cp \
          s3://$CONFIG_BUCKET/$DEPLOY_TARGET/$CONFIG_FILE \
          $PROJ_SETTINGS_DIR/budget_config/$CONFIG_FILE;
    # Debugging just to make sure the file is where and how we expect it to be, at least until this script finishes
    ls -la $PROJ_SETTINGS_DIR/budget_proj/$CONFIG_FILE
    echo Here are all files in CWD...
    ls -la .
    echo Here are all files in budget_proj...
    ls -la budget_proj
    echo And here are all the files in budget_proj/budget_proj...
    ls -la budget_proj/budget_proj
    
fi

# Load environment variables
#source $PROJ_SETTINGS_DIR/bin/$CONFIG_FILE
#echo DATABASE_PORT $DATABASE_PORT
