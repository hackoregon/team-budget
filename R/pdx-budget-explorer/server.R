library(shiny)
library(ggplot2)
source("budgetLevels.R")
source("data.R")

# Server logic required to plot variables against total budget.
shinyServer(function(input, output) {
  BUDGET_PLOT_TITLE <- "Budget for the City of Portland"

  # color-blind-friendly palette from http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
  cbbPalette <- c(BLACK = "#000000", ORANGE = "#E69F00", LIGHT_BLUE = "#56B4E9", GREEN = "#009E73", YELLOW = "#F0E442", BLUE = "#0072B2", RED = "#D55E00", PURPLE = "#CC79A7")

  # Translates budgetLevel selection to displayable name.
  budgetLevelNameMap <- list(SERVICE_AREA_LEVEL, BUREAU_LEVEL)
  names(budgetLevelNameMap) <- c(SERVICE_AREA_SELECTOR, BUREAU_SELECTOR)

  # Computes the caption in a reactive expression, because
  # it depends on the choices of budgetLevel and fiscalYear.
  captionText <- reactive({
    paste("By", budgetLevelNameMap[[input$budgetLevel]], "for", input$fiscalYear)
  })

  budgetLevelName <- reactive({
    budgetLevelNameMap[[input$budgetLevel]]
  })

  ####################
  output$budgetPlot <- renderPlot({
    if (SERVICE_AREA_SELECTOR == input$budgetLevel) {
      budgetData <- getServiceAreaTotals(input$fiscalYear)
      ggplot(data = budgetData,
             aes(x = reorder(service_area_code, amount), y = amount)) +
        geom_bar(stat = "identity",
                 fill = cbbPalette["LIGHT_BLUE"],
                 colour = cbbPalette["LIGHT_BLUE"]) +
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
                 fill = cbbPalette["LIGHT_BLUE"],
                 colour = cbbPalette["LIGHT_BLUE"]) +
        scale_y_continuous(limits = getAmountLimits(BUREAU_SELECTOR)) +
        coord_flip() +
        xlab(budgetLevelName()) +
        ylab("Amount") +
        ggtitle(paste0(BUDGET_PLOT_TITLE, ": ", captionText()))
    }
  })

})
