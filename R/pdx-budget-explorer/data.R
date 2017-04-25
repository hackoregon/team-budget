library(httr)
library(jsonlite)
library(magrittr)
library(dplyr)
source("budgetLevels.R")

BASE_URL <- "http://service.civicpdx.org/budget"
HISTORY_PATH <- paste0(BASE_URL, "/history")
SERVICE_AREA_PATH <- paste0(BASE_URL, "/history/service_area")
BUREAU_PATH <- paste0(BASE_URL, "/history/bureau")
ENCODING <- "UTF-8"

MAX_DOLLARS_PER_YEAR <- data.frame(c(2000000000), c(1500000000))
colnames(MAX_DOLLARS_PER_YEAR) <- c(SERVICE_AREA_SELECTOR, BUREAU_SELECTOR)

#' Returns data.frame with column names:
#'   accounting_object_name (name for 'object_code')
#'   amount
#'   bureau_code
#'   bureau_name
#'   division_code
#'   fiscal_year
#'   functional_area_code
#'   functional_area_name
#'   fund_center
#'   fund_center_code
#'   fund_center_name
#'   fund_code
#'   fund_name
#'   object_code
#'   program_code
#'   service_area_code
#'   sub_program_code
getBudgetHistory <- function(fiscalYear = "2015-16") {
  return(
    httr::GET(HISTORY_PATH, query = list(fiscal_year = fiscalYear)) %>%
      httr::content(type = "text", encoding = ENCODING) %>%
      jsonlite::fromJSON() %>%
      with(results)
  )
}

#' Returns data.frame with column names:
#'   amount
#'   fiscal_year
#'   service_area_code
getServiceAreaTotals <- function(fiscalYear = "2015-16") {
  return(
    httr::GET(SERVICE_AREA_PATH, query = list(fiscal_year = fiscalYear)) %>%
      httr::content(type = "text", encoding = ENCODING) %>%
      jsonlite::fromJSON() %>%
      with(results)
  )
}

#' Returns data.frame with column names:
#'   amount
#'   bureau_code
#'   bureau_name
#'   fiscal_year
#'   service_area_code
getBureauTotals <- function(fiscalYear = "2015-16") {
  return(
    httr::GET(BUREAU_PATH, query = list(fiscal_year = fiscalYear)) %>%
      httr::content(type = "text", encoding = ENCODING) %>%
      jsonlite::fromJSON() %>%
      with(results)
  )
}

getAmountLimits <- function(budgetLevel = SERVICE_AREA_SELECTOR) {
  # TODO: Calculate this dynamically from the history table.
  return(c(0, MAX_DOLLARS_PER_YEAR[[budgetLevel]]))
}
