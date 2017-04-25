library(shiny)
library(stringr)
library(tidyverse)
library(lubridate)
library(tidyr)
library(hrbrthemes)
library(scales)
source("budgetLevels.R")
source("data.R")

BUDGET_PLOT_TITLE <- "Budget for the City of Portland"

# color-blind-friendly palette from http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
CBB_PALETTE <-
  c(
    BLACK = "#000000",
    ORANGE = "#E69F00",
    LIGHT_BLUE = "#56B4E9",
    GREEN = "#009E73",
    YELLOW = "#F0E442",
    BLUE = "#0072B2",
    RED = "#D55E00",
    PURPLE = "#CC79A7"
  )

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
                 fill = CBB_PALETTE["LIGHT_BLUE"],
                 colour = CBB_PALETTE["LIGHT_BLUE"]) +
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
                 fill = CBB_PALETTE["LIGHT_BLUE"],
                 colour = CBB_PALETTE["LIGHT_BLUE"]) +
        scale_y_continuous(limits = getAmountLimits(BUREAU_SELECTOR)) +
        coord_flip() +
        xlab(budgetLevelName()) +
        ylab("Amount") +
        ggtitle(paste0(BUDGET_PLOT_TITLE, ": ", captionText()))
    }
  })

  output$personnelPlot <- renderPlot({
    getBudgetHistory(fields = c("object_code"), values = c("PERSONAL")) %>%
      mutate(amount = amount / 1000000) %>%
      ggplot(aes(fiscal_year, amount)) +
      scale_y_continuous(labels = comma) +
      geom_bar(stat = "identity") +
      #coord_flip() +
      facet_wrap( ~ bureau_name) +
      labs(x = "Fiscal\nYear", 
           y = "Millions of Dollars",
           title = "Personnel Budget by Bureau and Fiscal-Year") +
      theme_ipsum()
  })
  
  output$enterprisePlot <- renderText({
    "FIXME: Use renderPlot Enterprise Fund data here."
  })
  
})
