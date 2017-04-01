# Data Sources

`HackOregon_hx_budget_data_ASV2_extracted.csv` is a CSV export from the [Hack Oregon hx budget data ASV2.xlsx](https://drive.google.com/open?id=0B7CgmR-dA_1KV2p6MzRaenM1VHc) spreadsheet, which contains `Actual` historical data exported from the Portland City Budget database. Unfortunately, we do not have any documentation of the database query that produced the spreadsheet.

`HackOregon_hx_budget_data_ASV2_transformed.csv` and `HackOregon_hx_budget_data_ASV2_nonzero.csv` were derived from the `HackOregon_hx_budget_data_ASV2_extracted.csv` file, using the R script `HackOregon_hx_budget_data_ASV2_transform.R`. See that script in the R directory for an explanation of how "extracted" data was made into "tidy" data in the "transformed" file. Rows with zero amounts were then removed to create the "nonzero" file to be used to load the database.
