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
HISTORY_PROGESS_MESSAGE <- "Retrieving budget history records ..."
YEAR_PROGESS_MESSAGE <- "Retrieving budget records by year ..."

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
    message = HISTORY_PROGESS_MESSAGE)
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
    message = HISTORY_PROGESS_MESSAGE)
  })

  output$yearEndBalancesPlot <- renderPlot({
    shiny::withProgress({
      getBudgetHistory(
        fields = c("object_code"),
        values = c("ENDBAL"),
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
        labs(x = "Fiscal\nYear", y = "Millions of Dollars",
             title = "Year-End Fund Balance by Fiscal Year") +
        hrbrthemes::theme_ipsum()
    },
    value = 0,
    message = HISTORY_PROGESS_MESSAGE)
  })
  
  output$serviceAreaByYearPlot <- renderPlot({
    shiny::withProgress({
      getAllServiceAreaTotals(progressCallback = shiny::setProgress) %>%
        dplyr::mutate(amount = amount / 1000000) %>%
        ggplot(
          aes(
            x = fiscal_year,
            y = amount,
            group = service_area_code,
            colour = service_area_code
          )
        ) +
        geom_line(stat = "identity") +
        scale_y_continuous(labels = comma) +
        labs(x = "Fiscal\nYear", y = "Millions of Dollars",
             title = "Service Areas by Fiscal Year") +
        hrbrthemes::theme_ipsum()
    },
    value = 0,
    message = YEAR_PROGESS_MESSAGE)
  })
  
})
