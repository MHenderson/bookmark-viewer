library(shiny)

shinyUI(tags$div(class="flex-container",

  tags$head(
    tags$style(HTML("
      .flex-container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        align-items: center;
      }
    "))
  ),

  tags$div(plotOutput("image_one", height = '600px')),
  tags$div(plotOutput("image_two", height = '600px')),
  tags$div(plotOutput("image_three", height = '600px')),
  tags$div(plotOutput("image_four", height = '600px')),
  tags$div(plotOutput("image_five", height = '600px')),
  tags$div(plotOutput("image_six", height = '600px')),
  tags$div(plotOutput("image_seven", height = '600px')),
  tags$div(plotOutput("image_eight", height = '600px')),

  actionButton("page", label = "Next")
))

