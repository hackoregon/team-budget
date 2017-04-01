
# This R code transforms a CSV file of historical Portland Budget data.
# Execute the script by sourcing the file in an R shell:
#   > source("./HackOregon_hx_budget_data_ASV2_transform.R")
# or by executing the code line-by-line within RStudio.
#
# Assumptions:
# The working directory is the top-level of the 'team-budget' project.
#   See https://github.com/hackoregon/team-budget/ for the directory
#   structure of the project.
# The originally extracted data has column headers like, 'FY 2014-15', with
#   monetary amounts in those columns. Those columns need to be transformed to
#   two columns:
#     (a) 'fiscal_year' with values like '2014-15'.
#     (b) 'amount' column with monetary amounts.
#
# Limitations:
# This is not a generalized function. It is meant to work with one
#   specific data extract and we are executing the code interactively
#   in an R shell. If future extracts follow the same format,
#   then maybe this code can be generalized into a packaged function
#   for transforming the extracts. For now, it is intended to be used
#   once, but we documented it, so that the transformations are clear.
#   And we hope that it can be generalized and reused in the future.
#
# References:
# This code is derived from:
#   https://github.com/smithjd/hack_or_budget/blob/master/tidy_spreadsheet.R

library(tidyverse)
library(stringr)

dataDirectory <- "Data/"
baseFileName <- "HackOregon_hx_budget_data_ASV2"
csvSuffix <- ".csv"
originalModifier <- "_extracted"
transformedModifier <- "_transformed"
nonzeroModifier <- "_nonzero"

dfExtracted <- read.csv(paste0(dataDirectory, baseFileName, originalModifier, csvSuffix), stringsAsFactors = FALSE)

# Transforms column names to have underscore as the word separator, rather
# than a space, because we want these column names to used as field names in
# a relational database.
names(dfExtracted) <- tolower(str_replace_all(names(dfExtracted),"[ -.]", "_"))

# The 'gather' function introduces many more rows than were present
# in dfExtracted, i.e. the resulting dfTidy contains many rows
# with 'amount' of 0.
# TODO: Consider removing rows with amount == 0.
dfTidy <- gather(dfExtracted, fiscal_year, amount,
  -fund_center_code,
  -fund_code,
  -functional_area_code,
  -object_code,
  -fund_center_name,
  -fund_name,
  -functional_area_name,
  -accounting_object_name,
  -service_area_code,
  -program_code,
  -sub_program_code,
  -fund_center,
  -division_code,
  -bureau_code,
  -bureau_name
)

# fiscal_year values are transformed from values like "fy_2015_16"
# to values like "2015-16".
dfTidy$fiscal_year <- str_replace_all(dfTidy$fiscal_year,"^fy_", "")
dfTidy$fiscal_year <- str_replace_all(dfTidy$fiscal_year,"_", "-")

# Displays structure of transformed data for visual review.
dim(dfTidy)
str(dfTidy)

write.csv(dfTidy, paste0(dataDirectory, baseFileName, transformedModifier, csvSuffix), row.names = FALSE)

# Removes rows with zero amount.
dfTidyNonZero <- dfTidy[dfTidy$amount != 0, ]
dim(dfTidyNonZero)
write.csv(dfTidyNonZero, paste0(dataDirectory, baseFileName, nonzeroModifier, csvSuffix), row.names = FALSE)
