#! /bin/bash

# Load all local CSV data into your chosen local database
echo "Importing OCRB data..."
./budget_proj/manage.py importcsv budget_app.OCRB ./Data/Budget_in_Brief_OCRB_data_All_Years.csv "Source document:source_document" "Service Area:service_area" "Bureau:bureau" "Budget Category:budget_category" "Amount:amount" "Fiscal Year:fiscal_year" "Budget Type:budget_type"
echo "Importing KPM data..."
./budget_proj/manage.py importcsv budget_app.KPM ./Data/Budget_in_Brief_KPM_data_All_Years.csv "Source Document:source_document" "Service Area:service_area" "Bureau:bureau" "Key Performance Measure:key_performance_measures" "Fiscal Year:fiscal_year" "Budget Type:budget_type" "Amount:amount" "Units:units"
echo "Importing Budget History data..."
./budget_proj/manage.py importcsv budget_app.BudgetHistory ./Data/HackOregon_hx_budget_data_ASV2_transformed.csv "fund_center_code:fund_center_code" "fund_code:fund_code" "functional_area_code:functional_area_code" "object_code:object_code" "fund_center:fund_center" "fund_name:fund_name" "functional_area_name:functional_area_name" "accounting_object_name:accounting_object_name" "service_area:service_area" "program_code:program_code" "sub_program_code:sub_program_code" "fund_center:fund_center" "division_code:division_code" "bureau_code:bureau_code" "bureau_name:bureau_name" "fiscal_year:fiscal_year" "amount:amount"
echo "Importing Codes data..."
./budget_proj/manage.py importcsv budget_app.lookupcode ./Data/lookupcode.csv "id:id" "code_type:code_type" "code:code" "description:description"
