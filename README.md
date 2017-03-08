# Budget team project repo

This repo contains code and documents for all aspects of the Budget team project.

Per the current recommended approach for organizing code in repos, Budget team will use two repos: team-budget and team-budget-frontend.

## Team Budget repos
- team-budget: repo for all code related to backend (Django, API) and data/database
- team-budget-frontend: repo for all code related to frontend (React/HTML/CSS/JS)

# Setting up local development

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

If you are using a local database for development, rather than accessing the production database, you probably want to import data into your local dev database. From the top level directory of this project, run the following script to 
load the Operating and Capital Requirements by Bureau (OCRB) data into the database specified in your `settings.py` file:
```
./budget_proj/manage.py importcsv budget_app.OCRB ./Data/Budget_in_Brief_OCRB_data_All_Years.csv "Source document:source_document" "Service Area:service_area" "Bureau:bureau" "Budget Category:budget_category" "Amount:amount" "FY:fy" "Budget Type:budget_type"
```

Run this script to load the Key Performance Measures (KPM) data into the database:
```
./budget_proj/manage.py importcsv budget_app.KPM ./Data/Budget_in_Brief_KPM_data_All_Years.csv "Source Document:source_document" "Service Area:service_area" "Bureau:bureau" "Key Performance Measure:key_performance_measures" "FY:fy" "Budget Type:budget_type" "Amount:amount" "Units:units"
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
- ocrb: provides data from City of Portland Budget in Brief documents (e.g. FY 2016-17), all Service Area sections, table "Operating and Capital Requirements by Bureau".
- summary: uses query parameters to return subsets of the budget data given by the 'ocrb' endpoint.
- kpm: provides data from City of Portland Budget in Brief documents (e.g. FY 2016-17), all Service Area sections, table "Key Performance Measures".
