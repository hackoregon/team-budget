library(shiny)
source("./R/commonConstants.R")

BUDGET_LEVEL_SELECTIONS <-
  list(SERVICE_AREA_SELECTOR, BUREAU_SELECTOR)
names(BUDGET_LEVEL_SELECTIONS) <-
  list(SERVICE_AREA_LEVEL, BUREAU_LEVEL)

# Displays budget data for the City of Portland.
shinyUI(fluidPage(
  titlePanel("PDX Budget Explorer"),
  p(h4(em("Prototype ... work in progress!"))),
  
  tabsetPanel(
    tabPanel("By Year", plotOutput("serviceAreaByYearPlot")),
    
    tabPanel("Service/Bureau",
             sidebarLayout(
               # Controls to select the level of the budget to be plotted.
               sidebarPanel(
                 selectInput(
                   inputId = "budgetLevel",
                   label = "Level:",
                   choices = BUDGET_LEVEL_SELECTIONS
                 ),
                 selectInput(
                   inputId = "fiscalYear",
                   label = "Fiscal Year:",
                   choices = FISCAL_YEARS
                 )
               ),
               
               # Shows the caption and plot of the requested variable.
               mainPanel(plotOutput("budgetPlot"))
             )),
    
    tabPanel("Personnel", plotOutput("personnelPlot")),
    
    tabPanel("Enterprise Fund", plotOutput("enterprisePlot")),
    
    tabPanel("Year End Balances", plotOutput("yearEndBalancesPlot")),
    
    tags$head(tags$style(
      type = "text/css",
      paste0("li a{color: ", SITE_COLOR, ";}")
    ))
  )
))
