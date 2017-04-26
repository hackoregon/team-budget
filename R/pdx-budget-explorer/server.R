library(shiny)
library(stringr)
library(tidyverse)
library(lubridate)
library(tidyr)
library(hrbrthemes)
library(scales)
source("./R/commonConstants.R")
source("./R/data.R")

BUDGET_PLOT_TITLE <- "Budget for the City of Portland"
PROGESS_MESSAGE <- "Retrieving budget history records ..."

# Translates budgetLevel selection to displayable name.
BUDGET_LEVEL_NAMES <- list(SERVICE_AREA_LEVEL, BUREAU_LEVEL)
names(BUDGET_LEVEL_NAMES) <- c(SERVICE_AREA_SELECTOR, BUREAU_SELECTOR)

shinyServer(function(input, output) {

  # Reactive data.
  captionText <- reactive({
    paste("By", BUDGET_LEVEL_NAMES[[input$budgetLevel]], "for", input$fiscalYear)
  })

  budgetLevelName <- reactive({
    BUDGET_LEVEL_NAMES[[input$budgetLevel]]
  })

  # Output objects.
  output$budgetPlot <- renderPlot({
    if (SERVICE_AREA_SELECTOR == input$budgetLevel) {
      budgetData <- getServiceAreaTotals(input$fiscalYear)
      ggplot(data = budgetData,
             aes(x = reorder(service_area_code, amount), y = amount)) +
        geom_bar(stat = "identity",
                 fill = SITE_COLOR,
                 colour = SITE_COLOR) +
        scale_y_continuous(limits = getAmountLimits(SERVICE_AREA_SELECTOR)) +
        coord_flip() +
        xlab(budgetLevelName()) +
        ylab("Amount") +
        ggtitle(paste0(BUDGET_PLOT_TITLE, ": ", captionText()))
    } else if (BUREAU_SELECTOR == input$budgetLevel) {
      budgetData <- getBureauTotals(input$fiscalYear)
      ggplot(data = budgetData,
             aes(x = reorder(bureau_code, amount), y = amount)) +
        geom_bar(stat = "identity",
                 fill = SITE_COLOR,
                 colour = SITE_COLOR) +
        scale_y_continuous(limits = getAmountLimits(BUREAU_SELECTOR)) +
        coord_flip() +
        xlab(budgetLevelName()) +
        ylab("Amount") +
        ggtitle(paste0(BUDGET_PLOT_TITLE, ": ", captionText()))
    }
  })

  output$personnelPlot <- renderPlot({
    shiny::withProgress({
      getBudgetHistory(
        fields = c("object_code"),
        values = c("PERSONAL"),
        progressCallback = shiny::setProgress
      ) %>%
        dplyr::mutate(amount = amount / 1000000) %>%
        ggplot(aes(fiscal_year, amount)) +
        scale_y_continuous(labels = comma) +
        geom_bar(stat = "identity",
                 fill = SITE_COLOR,
                 colour = SITE_COLOR) +
        #coord_flip() +
        facet_wrap(~ bureau_name) +
        labs(x = "Fiscal\nYear",
             y = "Millions of Dollars",
             title = "Personnel Budget by Bureau and Fiscal-Year") +
        hrbrthemes::theme_ipsum()
    },
    value = 0,
    message = PROGESS_MESSAGE)
  })
  
  output$enterprisePlot <- renderPlot({
    shiny::withProgress({
      getBudgetHistory(
        fields = c("fund_code"),
        values = c("ENTERPRISE"),
        progressCallback = shiny::setProgress
      ) %>%
        dplyr::mutate(amount = amount / 1000000) %>%
        ggplot(aes(fiscal_year, amount)) +
        geom_bar(stat = "identity",
                 fill = SITE_COLOR,
                 colour = SITE_COLOR) +
        scale_y_continuous(labels = comma) +
        coord_flip() +
        facet_wrap( ~ bureau_name) +
        labs(
          x = "Fiscal\nYear",
          y = "Millions of Dollars",
          title = "Enterprise",
          subtitle = "Could this be revenue from self-funding parts of the City's budget?"
        ) +
        hrbrthemes::theme_ipsum()
    },
    value = 0,
    message = PROGESS_MESSAGE)
  })
})
