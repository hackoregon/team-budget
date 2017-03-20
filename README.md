# Budget team project repo

This repo contains code and documents for all aspects of the Budget team project.

Per the current recommended approach for organizing code in repos, Budget team will use two repos: team-budget and team-budget-frontend.

## Team Budget repos
- team-budget: repo for all code related to backend (Django, API) and data/database
- team-budget-frontend: repo for all code related to frontend (React/HTML/CSS/JS)

## Setting up local development

Clone, configure your virtual environment and install requirements:
```
git clone https://github.com/hackoregon/team-budget.git
cd team-budget
virtualenv -p python3 budget_venv
source budget_venv/bin/activate
pip install -r requirements.txt
```

If you are configured to use a local database for development, you might need to run the migrate scripts. You only need to run this when the models have changed:
```
python3 budget_proj/manage.py makemigrations
python3 budget_proj/manage.py migrate
```

Run the app server:
```
python3 budget_proj/manage.py runserver
```

(You can also try this using a local Docker container, if you'd prefer to keep all locally-installed dependencies and commands to a minimum.  See README-docker.md in the `budget_proj` folder.)

If you are using a local database for development, rather than accessing the production database, you probably want to import data into your local dev database. From the top level directory of this project, run the following command to 
load the Operating and Capital Requirements by Bureau (OCRB) data into the database specified in your `settings.py` file:
```
./budget_proj/manage.py importcsv budget_app.OCRB ./Data/Budget_in_Brief_OCRB_data_All_Years.csv "Source document:source_document" "Service Area:service_area" "Bureau:bureau" "Budget Category:budget_category" "Amount:amount" "FY:fy" "Budget Type:budget_type"
```

Run this command to load the Key Performance Measures (KPM) data into the database:
```
./budget_proj/manage.py importcsv budget_app.KPM ./Data/Budget_in_Brief_KPM_data_All_Years.csv "Source Document:source_document" "Service Area:service_area" "Bureau:bureau" "Key Performance Measure:key_performance_measures" "FY:fy" "Budget Type:budget_type" "Amount:amount" "Units:units"
```

Run this command to load the historical data into the database:
```
./budget_proj/manage.py importcsv budget_app.BudgetHistory ./Data/HackOregon_hx_budget_data_ASV2_transformed.csv "fund_center_code:fund_center_code" "fund_code:fund_code" "functional_area_code:functional_area_code" "object_code:object_code" "fund_center:fund_center" "fund_name:fund_name" "functional_area_name:functional_area_name" "accounting_object_name:accounting_object_name" "service_area:service_area" "program_code:program_code" "sub_program_code:sub_program_code" "fund_center:fund_center" "division_code:division_code" "bureau_code:bureau_code" "bureau_name:bureau_name" "fiscal_year:fiscal_year" "amount:amount"
```

Then launch your browser and browse to one of several endpoints:<br>
(1) Download all OCRB data. No query parameters are accepted.
```
http://127.0.0.1:8000/ocrb
```

(2) Use query parameters to select a subset of the budget data summarized by bureau.
```
# To get all summary data, which is the same as for the /ocrb endpoint, except that /summary sorts the data:
http://127.0.0.1:8000/summary
# To get the 'Adopted' budget information for all bureaus in the 
# 'City Support Services' service area for fiscal year '2015-16':
http://127.0.0.1:8000/summary?fy=2015-16&service_area=City Support Services&budget_type=Adopted
# To get all summary information for the 'Portland Bureau of Emergency Management'
# for all years of available data.
http://127.0.0.1:8000/summary?bureau=Portland Bureau of Emergency Management
# To get all summary information for the 'Bureau of Fire & Police Disability & Retirement'
# for all years of available data. Note that '&' embedded in the name must be URI encoded to '%26':
http://127.0.0.1:8000/summary?bureau=Bureau of Fire %26 Police Disability %26 Retirement
```

The sort order returned by /summary is always the same, i.e. you are not allowed to pass parameters
to change the sort order. However, that could be an enhancement in the future.

(3) Download all Key Performance Measure (KPM) data.
```
http://127.0.0.1:8000/kpm
```

# Endpoint map
- kpm: provides data from City of Portland Budget in Brief documents (e.g. FY 2016-17), all Service Area sections, table "Key Performance Measures".
- ocrb: provides data from City of Portland Budget in Brief documents (e.g. FY 2016-17), all Service Area sections, table "Operating and Capital Requirements by Bureau".
- summary: uses query parameters to return subsets of the budget data given by the 'ocrb' endpoint.

## License
This project is licensed under the terms of the MIT license.

# Sample Endpoint data
- KPM:
```json
[
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Public Safety",
    "bureau": "Bureau of Emergency Communications",
    "key_performance_measures": "BOEC - % of priority medical calls dispatched within 90 seconds",
    "fy": "2013-14",
    "budget_type": "Actual ",
    "amount": 72,
    "units": "%"
  },
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Public Safety",
    "bureau": "Bureau of Fire & Police Disability & Retirement",
    "key_performance_measures": "FPDR - Tax levy rate per $1,000 of Real Market Value",
    "fy": "2013-14",
    "budget_type": "Actual ",
    "amount": 1.62,
    "units": "$"
  },
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Transportation & Parking",
    "bureau": "Portland Bureau of Transportation",
    "key_performance_measures": "BOT – % of bridges in non-distressed condition",
    "fy": "2013-14",
    "budget_type": "Actual ",
    "amount": null,
    "units": ""
  }
]
```
- OCRB: 
```json
[
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Public Safety",
    "bureau": "Bureau of Emergency Communications",
    "budget_category": "Capital",
    "amount": 0,
    "fy": "2013-14",
    "budget_type": "Actual"
  },
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Public Safety",
    "bureau": "Bureau of Fire & Police Disability & Retirement",
    "budget_category": "Capital",
    "amount": 232658,
    "fy": "2013-14",
    "budget_type": "Actual"
  },
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Public Safety",
    "bureau": "Bureau of Emergency Communications",
    "budget_category": "Operating",
    "amount": 23346735,
    "fy": "2013-14",
    "budget_type": "Actual"
  },
  {
    "source_document": "FY 2015-16 Budget in Brief",
    "service_area": "Public Safety",
    "bureau": "Bureau of Fire & Police Disability & Retirement",
    "budget_category": "Operating",
    "amount": 162156833,
    "fy": "2013-14",
    "budget_type": "Actual"
  }
]
```
