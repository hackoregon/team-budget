library(shiny)
library(ggplot2)
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

# Plot variables against total budget.
shinyServer(function(input, output) {
  # Computes the caption in a reactive expression, because
  # it depends on the choices of budgetLevel and fiscalYear.
  captionText <- reactive({
    paste("By", BUDGET_LEVEL_NAMES[[input$budgetLevel]], "for", input$fiscalYear)
  })
  
  budgetLevelName <- reactive({
    BUDGET_LEVEL_NAMES[[input$budgetLevel]]
  })
  
  ####################
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
  
  output$personnelPlot <- renderText({
    "FIXME: Use renderPlot Personnel data here."
  })
  
  output$enterprisePlot <- renderText({
    "FIXME: Use renderPlot Enterprise Fund data here."
  })
  
})
