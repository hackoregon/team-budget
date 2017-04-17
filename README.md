# Budget team project repository

This repository contains two major components:
- code for the backend (API) layer of the Budget project
- issue tracking for all aspects (API, Frontend, data, deployment) of the Budget project

## Deployed Code!
Here's the backend API in the Integration environment: http://service.civicpdx.org/budget (or this older URL which points to the same instance: http://hacko-integration-658279555.us-west-2.elb.amazonaws.com/budget) 

## Team Budget source repositories
Per the current recommended approach for organizing code for Hack Oregon projects, Budget team will use two repositories:

- [team-budget](https://github.com/hackoregon/team-budget) for all code related to the RESTful web service built with Django and a SQL database.
- [team-budget-frontend](https://github.com/hackoregon/team-budget-frontend) for all code related to the frontend web application (React/HTML/CSS/JavaScript).

## Development environment prerequisites

To work on code in this [team-budget](https://github.com/hackoregon/team-budget) (backend) repository, you must have:

- [Python 3.5.3](https://www.python.org/downloads/release/python-353/)<br>The deployed code is a [Django](https://www.djangoproject.com/) web service, running under [Python 3.5.3](https://www.python.org/downloads/release/python-353/), but some of us use [Python 3.6.X](https://www.python.org/downloads/) for development and that does not seem to be a problem.
- [Git](https://git-scm.com/)<br>See "[How to contribute to the project](https://github.com/hackoregon/team-budget/wiki/How-to-contribute-to-the-project)" for how we use [Git](https://git-scm.com/) and [GitHub](https://help.github.com/categories/collaborating-with-issues-and-pull-requests/) for version control and Pull Requests.

To run the build scripts, you need certain tools, but you can run locally while developing without these:

- [bash](https://www.gnu.org/software/bash/) shell<br>The build scripts are written for [bash](https://www.gnu.org/software/bash/). We would love for someone to write equivalent scripts for building on Windows machines. However, you can do development without executing the build scripts, so it is not absolutely required to have [bash](https://www.gnu.org/software/bash/) on your machine.
- [Docker Compose](https://docs.docker.com/compose/)<br>The build artifact for the API is a Docker image, but you can do development without building a Docker image.

For production data storage, we use:

- [PostgreSQL 9.5.5](https://www.postgresql.org/) running on an [AWS EC2](https://aws.amazon.com/products/compute/#ec2) instance.<br>You do _not_ need either of these for development. Some of us run a local instance of [PostgreSQL](https://www.postgresql.org/) for development, but others use the default embedded [SQLite](https://www.sqlite.org/) database that comes with [Django](https://www.djangoproject.com/) for development.

## Setting up your development environment

Please follow these instructions carefully, so that your environment will be configured correctly and you can start contributing as soon as possible.

### (1) Clone or fork this repository:
```
# If you just want to browse the code and run it:
git clone git@github.com:hackoregon/team-budget.git
# -or- If you want to be a contributer,
# Fork this repository, then:
git clone git@github.com:YourGitHubName/team-budget.git
```

### (2) Configure Python's virtual environment and install required Python modules
```
cd team-budget
virtualenv -p python3 budget_venv
source budget_venv/bin/activate
pip install -r budget_proj/requirements/dev.txt
```

### (3) Configure your environment for the database management system that you will use
```
cp budget_proj/budget_proj/project_config_template.py budget_proj/budget_proj/project_config.py
```

The default values in the `project_config.py` file that you just created are configured for using an embedded [SQLite](https://www.sqlite.org/) database, which works fine for development. If you need to use some other database, modify `project_config.py` as needed. This file is listed in `.gitignore`, so you will not accidentally commit database connection information that contains the username and password, because the `project_config.py` file is never committed to the source repository.

### (4) Install the database schema
If you are configured to use a local database for development, you need to run the migrate scripts before you run the API application for the first time. You also need to run this whenever the models have changed:
```
./budget_proj/manage.py makemigrations
./budget_proj/manage.py migrate
```

### (5) Run the app server
```
./budget_proj/manage.py runserver
```

Type [Control-C] when you want to stop the server.

### (6) Import data into your local database instance

If you are using a local database for development, rather than accessing the integration database or production database, you need to import data into your local dev database, because the embedded [SQLite](https://www.sqlite.org/) database used for development has no data when you clone the project repository. From the top-level directory of this project, run the following command to 
load the Operating and Capital Requirements by Bureau (OCRB) data into the database specified in your `budget_proj/budget_proj/project_config.py` file:
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

Run this command to load the lookup codes into the database:
```
./budget_proj/manage.py importcsv budget_app.lookupcode ./Data/lookupcode.csv "id:id" "code_type:code_type" "code:code" "description:description"
```

### (7) Download budget data formatted as [JSON](http://www.json.org/)
You now have the web service running and you loaded the database with data.

Launch a web browser and browse to one of the web service endpoints to _retrieve_ budget data.

Currently, the web service only provides data in JavaScript Object Notation ([JSON](http://www.json.org/)). It is _not_ possible to request comma-separated values (CSV), tab-delimited values, plain text, XML, HTML, or any other data format. The web service _only_ produces JSON at this time, although we would love for someone to help implement other response formats, especially CSV.

#### (7.1) Download all Operating and Capital Requirements by Bureau (OCRB) data
```
http://127.0.0.1:8000/ocrb
```

#### (7.2) Use query parameters to select a subset of the historical budget data
```
# To get the 'Actual' budget information for all bureaus in the 
# 'Public Safety' service area for fiscal year '2015-16':
http://127.0.0.1:8000/budget/history?fiscal_year=2015-16&service_area_code=PS

# To get all historical information for the 'Portland Bureau of Emergency Management'
# for all years of available data.
http://127.0.0.1:8000/budget/history?bureau_code=EM
```

The sort order returned by /history is always the same, i.e. you are not allowed to pass parameters
to change the sort order. However, that could be an enhancement in the future.

#### (7.3) Download all codes and their descriptions
Use these codes in your queries for historical data in (7.2) above.
```
http://127.0.0.1:8000/budget/code/
```

#### (7.4) Download all Key Performance Measure (KPM) data
No query parameters are accepted.
```
http://127.0.0.1:8000/kpm
```

# Endpoint map
- kpm: provides data from City of Portland "Budget in Brief" documents (e.g. [FY 2016-17](https://www.portlandoregon.gov/cbo/article/584584)) for all Service Area sections from the tables named, "Key Performance Measures".
- ocrb: provides data from City of Portland "Budget in Brief" documents (e.g. [FY 2016-17](https://www.portlandoregon.gov/cbo/article/584584)) for all Service Area sections from the tables named, "Operating and Capital Requirements by Bureau".
- history: uses query parameters to return subsets of the budget data from the past 10 years.
- code: returns codes used in other tables along with their descriptions.

# Using Docker
See [README-docker.md](https://github.com/hackoregon/team-budget/blob/master/README-docker.md) if you want to run the application from a Docker image, rather than using the Django `runserver` method as above.

# License
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
