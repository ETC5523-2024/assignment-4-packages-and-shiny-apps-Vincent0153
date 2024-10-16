library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(marchmadness)

# Convert variables to integer
march_madness_dataset$YEAR <- as.integer(march_madness_dataset$YEAR)
march_madness_dataset$TEAMNO <- as.integer(march_madness_dataset$TEAMNO)
march_madness_dataset$SEED <- as.integer(march_madness_dataset$SEED)
march_madness_dataset$ROUND <- as.integer(march_madness_dataset$ROUND)

# Create UI
ui <- fluidPage(
  titlePanel("March Madness Data Explorer"),

  # Custom styling
  tags$head(
    tags$style(HTML("
      body { background-color: #f4f4f4; }
      .well { background-color: #ffffff; border: 1px solid #d3d3d3; border-radius: 8px; }
    "))
  ),

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

      # Field descriptions
      h4("Field Descriptions"),
      p("YEAR: Ending year of the team's season."),
      p("TEAM: Division I college basketball team."),
      p("SEED: Preliminary ranking for the March Madness tournament."),
      p("ROUND: The farthest round the team made it in the tournament."),
      p("POWER: Calculation of the team's strength relative to other teams in the tournament by Heat Check."),
      p("FINALS: The percentage of people who picked the team to win the game in the Finals."),

      # Instructions
      h4("How to Use It?"),
      p("Use the filters on the left to explore the data. For example, you can filter by year and seed range."),
      p("Click on column headers to sort by SEED, POWER, or FINALS."),
      p("Use the searching bar to look for the data you want")
    )
  )
)

# Create Server
server <- function(input, output) {
  # Reactive data filtering
  filtered_data <- reactive({
    march_madness_dataset %>%
      filter(YEAR == input$year,
             SEED >= input$seed_range[1],
             SEED <= input$seed_range[2]) %>%
      head(input$team_count)
  })

  # Render the interactive table
  output$interactiveTable <- renderDT({
    datatable(
      filtered_data(),
      options = list(
        pageLength = 10,  # Display 10 rows per page
        order = list(list(0, 'asc'))  # Default sorting by the first column (YEAR)
      ),
      rownames = FALSE  # Hide row numbers
    )
  })
}

# Activate the Shiny App
shinyApp(ui = ui, server = server)

