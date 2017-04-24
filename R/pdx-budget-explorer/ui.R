library(shiny)
source("budgetLevels.R")

BUDGET_LEVEL_SELECTIONS <- list(SERVICE_AREA_SELECTOR, BUREAU_SELECTOR)
names(BUDGET_LEVEL_SELECTIONS) <- list(SERVICE_AREA_LEVEL, BUREAU_LEVEL)

# Displays budget data for the City of Portland.
shinyUI(fluidPage(
  titlePanel("PDX Budget Explorer"),
  sidebarLayout(
    # Controls to select the level of the budget to be plotted.
    sidebarPanel(
      p(h4(em("Prototype only!"))),
      selectInput("budgetLevel", "Level:", BUDGET_LEVEL_SELECTIONS),
      selectInput("fiscalYear", "Fiscal Year:",
                  list("2015-16" = "2015-16",
                       "2014-15" = "2014-15",
                       "2013-14" = "2013-14",
                       "2012-13" = "2012-13",
                       "2011-12" = "2011-12",
                       "2010-11" = "2010-11",
                       "2009-10" = "2009-10",
                       "2008-09" = "2008-09",
                       "2007-08" = "2007-08",
                       "2006-07" = "2006-07"))
    ),

    # Shows the caption and plot of the requested variable.
    mainPanel(
      plotOutput("budgetPlot")
    )
  )
))
