library(httr)
library(jsonlite)
library(magrittr)
library(dplyr)
source("./R/commonConstants.R")

BASE_URL <- "http://service.civicpdx.org/budget"
HISTORY_PATH <- paste0(BASE_URL, "/history")
SERVICE_AREA_PATH <- paste0(BASE_URL, "/history/service_area")
BUREAU_PATH <- paste0(BASE_URL, "/history/bureau")
ENCODING <- "UTF-8"

MAX_DOLLARS_PER_YEAR <- data.frame(c(2000000000), c(1500000000))
colnames(MAX_DOLLARS_PER_YEAR) <- c(SERVICE_AREA_SELECTOR, BUREAU_SELECTOR)

#' Builds the query part of an HTTP call, matching up each field 
#' with its corresponding value to build query parameters.
#' 
#' @param fields array of string field names.
#' @param values array of string values.
#' @return string starting with "?", followed by pairs of field
#' names and values conjoined with "=" and pairs are separated
#' by "&". For example,
#' "?fiscal_year=2014-15&object_code=PERSONAL".
#' Returns empty string when no fields and values are given.
#' @export
buildQueryString <- function(fields = c(), values = c()) {
  query <- ""
  if (!is.null(fields) && length(fields) > 0 &&
      !is.null(values) && length(values) > 0) {
    firstParameter <- TRUE
    for (i in 1:length(fields)) {
      if (i <= length(values)) {
        if (firstParameter) {
          query <- paste0(query, "?")
          firstParameter <- FALSE
        } else {
          query <- paste0(query, "&")
        }
        query <- paste0(query, fields[[i]], "=", values[[i]])
      }
    }
  }
  return(query)
}

#' All Budget History columns, filtered by arbitrary choice of
#' field names and their associated values.
#' 
#' Returns the following fields:
#'   accounting_object_name (name for 'object_code'),
#'   amount,
#'   bureau_code,
#'   bureau_name,
#'   division_code,
#'   fiscal_year,
#'   functional_area_code,
#'   functional_area_name,
#'   fund_center,
#'   fund_center_code,
#'   fund_center_name,
#'   fund_code,
#'   fund_name,
#'   object_code,
#'   program_code,
#'   service_area_code,
#'   sub_program_code
#' @param fields array of string field names for filtering.
#' @param values array of string values for filtering.
#' @param progressCallback function to be called to report incremental progress.
#' The callback function must follow the protocol of shiny::setProgress().
#' @return data.frame with rows that passed the filtering
#' by field=value pairs. Returns empty data.frame when no rows
#' pass the filter criteria.
#' @export
getBudgetHistory <- function(fields = c(), values = c(), progressCallback = NULL) {
  history <- data.frame()
  nextPage <- paste0(HISTORY_PATH, buildQueryString(fields = fields, values = values))
  receivedCount <- 0
  totalCount <- 0
  while (!is.null(nextPage)) {
    response <-
      httr::GET(nextPage) %>%
      httr::content(type = "text", encoding = ENCODING) %>%
      jsonlite::fromJSON()
    nextPage <- response$'next'
    nextBatch <- response$results
    history <- rbind(history, nextBatch)
    if (!is.null(progressCallback)) {
      totalCount <- response$count
      receivedCount <- dim(history)[[1]]
      progressCallback(
        value = receivedCount / totalCount,
        message = paste("Retrieving", totalCount, "budget history records ...")
      )
    }
  }
  return(history)
}

#' Aggregates budget amounts by Service Area for a given year.
#' 
#' @param fiscalYear string representation must be 4 digits, dash,
#' 2 digits. For example, "2006-07".
#' @return data.frame with column names:
#'   amount,
#'   fiscal_year,
#'   service_area_code,
#' where the 'amount' is aggregated by service_area_code.
#' @export
getServiceAreaTotals <- function(fiscalYear = "2015-16") {
  return(
    httr::GET(SERVICE_AREA_PATH, query = list(fiscal_year = fiscalYear)) %>%
      httr::content(type = "text", encoding = ENCODING) %>%
      jsonlite::fromJSON() %>%
      with(results)
  )
}

#' Aggregates budget amounts by Bureau for a given year.
#' 
#' @param fiscalYear string representation must be 4 digits, dash,
#' 2 digits. For example, "2006-07".
#' @return data.frame with column names:
#'   amount,
#'   bureau_code,
#'   bureau_name,
#'   fiscal_year,
#'   service_area_code,
#' where the 'amount' is aggregated by bureau_code.
#' @export
getBureauTotals <- function(fiscalYear = "2015-16") {
  return(
    httr::GET(BUREAU_PATH, query = list(fiscal_year = fiscalYear)) %>%
      httr::content(type = "text", encoding = ENCODING) %>%
      jsonlite::fromJSON() %>%
      with(results)
  )
}

#' Returns amount limits for each level of the budget.
#' 
#' This is useful when specifying the limits for a plot.
#' @param budgetLevel one of [SERVICE_AREA_SELECTOR, BUREAU_SELECTOR].
#' @return 2-element vector with c(min, max) amounts expected
#' for the range of possible budget amount for the given budgetLevel.
#' @export
getAmountLimits <- function(budgetLevel = SERVICE_AREA_SELECTOR) {
  # TODO: Calculate this dynamically from the history table.
  return(c(0, MAX_DOLLARS_PER_YEAR[[budgetLevel]]))
}
