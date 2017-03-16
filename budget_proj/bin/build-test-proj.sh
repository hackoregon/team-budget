# Troubleshooting Travis
# - we tried running just "./budget_proj/bin/test-proj.sh" that launched "docker-compose -f budget_proj/docker-compose.yml run budget-service python manage.py test"
# --- this resulted in "ImportError: cannot import name 'project_config'"
# - we tried running "./budget_proj/bin/build-proj.sh && ./budget_proj/bin/test-proj.sh"
# --- this resulted in "ERROR: No container found for budget-service_1"
# - thus we're trying to run these all in sequence in a single script, hoping the just-built container is findable

# Debugging whether project_config.py still exists
ls -la $PROJ_SETTINGS_DIR/project_config.py

# What we're expecting to happen here is build the container in step (1), launch it in step (2) and connect to it (via tty - thanks @brianhgrant) to run tests in step (3).
echo Build not executed yet...
docker-compose -f budget_proj/docker-compose.yml build budget-service
echo Build completed...
echo Start not executed yet...
docker-compose -f budget_proj/docker-compose.yml start budget-service
echo Start completed...
echo Exec not started yet...
docker-compose -f budget_proj/docker-compose.yml exec budget-service python manage.py test
echo Exec completed...
