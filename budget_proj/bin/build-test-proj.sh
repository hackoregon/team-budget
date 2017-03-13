# Troubleshooting Travis
# - we tried running just "./budget_proj/bin/test-proj.sh" that launched "docker-compose -f budget_proj/docker-compose.yml run budget-service python manage.py test"
# --- this resulted in "ImportError: cannot import name 'project_config'"
# - we tried running "./budget_proj/bin/build-proj.sh && ./budget_proj/bin/test-proj.sh"
# --- this resulted in "ERROR: No container found for budget-service_1"
# - thus we're trying to run these all in sequence in a single script, hoping the just-built container is findable

echo Build not started yet...
pwd
ls -la
docker-compose -f budget_proj/docker-compose.yml build budget-service
echo Build completed...
pwd
ls -la
echo Start not executed yet...
docker-compose -f budget_proj/docker-compose.yml start budget-service
echo Start completed...
pwd
ls -la 
echo Exec not started yet...
docker-compose -f budget_proj/docker-compose.yml exec budget-service python manage.py test
echo Exec completed...
