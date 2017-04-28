# Data Sources

`HackOregon_hx_budget_data_ASV2_extracted.csv` is a CSV export from the [Hack Oregon hx budget data ASV2.xlsx](https://drive.google.com/open?id=0B7CgmR-dA_1KV2p6MzRaenM1VHc) spreadsheet, which contains `Actual` historical data exported from the Portland City Budget database. Unfortunately, we do not have any documentation of the database query that produced the spreadsheet.

`HackOregon_hx_budget_data_ASV2_transformed.csv` was derived from the `HackOregon_hx_budget_data_ASV2_extracted.csv` file, using the R script `HackOregon_hx_budget_data_ASV2_transform.R`.

`DemoData-20170501.csv` is a very small subset of `HackOregon_hx_budget_data_ASV2_transformed.csv` for viewing as a CSV file during Demo Day. Having a small file allows us to open it quickly and browse around to see the format. We do not care about the actual data in this file. It is just to demonstrate the format of the larger history file.
