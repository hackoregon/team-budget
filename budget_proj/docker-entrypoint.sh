#!/bin/bash
./bin/getconfig.sh
python3 manage.py migrate
python3 manage.py importcsv budget_app.OCRB /Data/Budget_in_Brief_OCRB_data_All_Years.csv "Source document:source_document" "Service Area:service_area" "Bureau:bureau" "Budget Category:budget_category" "Amount:amount" "FY:fy" "Budget Type:budget_type"
gunicorn budget_proj.wsgi:application -b :8000