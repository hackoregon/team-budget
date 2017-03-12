#!/bin/bash

echo  Running docker-entrypoint.sh...

./bin/getconfig.sh

# TODO: determine which of these steps is necessary at every launch of the endpoints:
# https://github.com/hackoregon/team-budget/issues/51
python3 manage.py migrate
python3 manage.py importcsv budget_app.OCRB /Data/Budget_in_Brief_OCRB_data_All_Years.csv "Source document:source_document" "Service Area:service_area" "Bureau:bureau" "Budget Category:budget_category" "Amount:amount" "FY:fy" "Budget Type:budget_type"

# Fire up a lightweight frontend to host the DRF endpoints - gunicorn is convenient but other engines can be considered
gunicorn budget_proj.wsgi:application -b :8000