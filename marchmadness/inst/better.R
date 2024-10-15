# Load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)  # For interactive tables
library(shinydashboard)  # For dashboard layout
library(marchmadness)

# Ensure data columns are properly formatted
march_madness_dataset$YEAR <- as.integer(march_madness_dataset$YEAR)
march_madness_dataset$TEAMNO <- as.integer(march_madness_dataset$TEAMNO)
march_madness_dataset$SEED <- as.integer(march_madness_dataset$SEED)
march_madness_dataset$ROUND <- as.integer(march_madness_dataset$ROUND)

# Dashboard UI
ui <- dashboardPage(
  skin = "blue",

  dashboardHeader(title = "March Madness Dashboard"),

  dashboardSidebar(
    sidebarMenu(
      menuItem("Team Power Trends", tabName = "chart", icon = icon("chart-line")),
      menuItem("Data Overview", tabName = "data", icon = icon("table"))
    )
  ),

  dashboardBody(
    tags$head(
      tags$style(HTML("
        .content-wrapper, .right-side {
          background-color: #f0f0f5;
        }
        .box {
          border-radius: 10px;
          box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.1);
        }
      "))
    ),

    tabItems(
      # Chart Tab
      tabItem(tabName = "chart",
              fluidRow(
                # Plot box
                box(
                  title = "Power Rating Trends of Teams Over Years", status = "primary", solidHeader = TRUE, width = 8,
                  plotOutput("lineChart")
                ),
                # Controls box
                box(
                  title = "Controls", status = "primary", solidHeader = TRUE, width = 4,
                  # Team selector (multi-select)
                  selectInput("team_selector", "Select Teams to Display:",
                              choices = unique(march_madness_dataset$TEAM),
                              selected = unique(march_madness_dataset$TEAM)[1:5],  # Default select first 5 teams
                              multiple = TRUE)
                )
              ),
              fluidRow(
                # Instructions box
                box(
                  title = "Instructions", status = "info", solidHeader = TRUE, width = 12,
                  h4("How to Use It?"),
                  p("This line plot illustrates each team's power rating across years."),
                  p("Use 'Controls' section to select what teams to display."),
                  p("You can click the search bar and scroll down to find the teams you want
                    or just use search it through typing.")
                )
              )
      ),

      # Data Overview Tab
      tabItem(tabName = "data",
              sidebarLayout(
                sidebarPanel(
                  # Year selector
                  selectInput("year", "Select Year:",
                              choices = unique(march_madness_dataset$YEAR),
                              selected = max(march_madness_dataset$YEAR)),

                  # Seed range slider
                  sliderInput("seed_range", "Select Seed Range:",
                              min = min(march_madness_dataset$SEED),
                              max = max(march_madness_dataset$SEED),
                              value = c(min(march_madness_dataset$SEED), max(march_madness_dataset$SEED)),
                              step = 1),

                  # Number of teams to display
                  numericInput("team_count", "Number of Teams to Display:",
                               value = 10, min = 1, max = nrow(march_madness_dataset))
                ),

                mainPanel(
                  # Interactive table output
                  DTOutput("interactiveTable"),

                  fluidRow(
                    box(
                      title = "Field Descriptions", status = "info", solidHeader = TRUE, width = 12,
                      p("YEAR: Ending year of the team's season."),
                      p("TEAM: Division I college basketball team."),
                      p("SEED: Preliminary ranking for the March Madness tournament."),
                      p("ROUND: The farthest round the team made it in the tournament."),
                      p("POWER: Calculation of the team's strength relative to other teams in the tournament by Heat Check."),
                      p("FINALS: The percentage of people who picked the team to win the game in the Finals.")
                    )
                  ),

                  fluidRow(
                    box(
                      title = "How to Use It?", status = "info", solidHeader = TRUE, width = 12,
                      p("Use the filters on the left to explore the data. For example, you can filter by year and seed range."),
                      p("Click on column headers to sort by SEED, POWER, or FINALS."),
                      p("Use the searching bar to look for the data you want.")

                )
              )
      )
    )

    )
    )
    )
  )



# Server Logic
server <- function(input, output) {
  # Reactive data filtering for Data Overview
  filtered_data <- reactive({
    march_madness_dataset %>%
      filter(YEAR == input$year,
             SEED >= input$seed_range[1],
             SEED <= input$seed_range[2]) %>%
      head(input$team_count)
  })

  # Render Interactive Data Table
  output$interactiveTable <- renderDT({
    datatable(
      filtered_data(),
      options = list(
        pageLength = 10,
        order = list(list(0, 'asc'))
      ),
      rownames = FALSE
    )
  })

  # Reactive data filtering for Line Chart
  line_chart_data <- reactive({
    march_madness_dataset %>%
      filter(TEAM %in% input$team_selector) %>%
      arrange(YEAR)
  })

  # Render Line Chart
  output$lineChart <- renderPlot({
    data <- line_chart_data()
    ggplot(data, aes(x = YEAR, y = POWER, color = TEAM, group = TEAM)) +
      geom_line(size = 1) +
      labs(title = "Power Rating Trends of Teams Over Years",
           x = "Year", y = "Power Rating") +
      theme_minimal()
  })
}

# Run the App
shinyApp(ui = ui, server = server)
