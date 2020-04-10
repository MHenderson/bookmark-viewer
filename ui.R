library(shiny)

shinyUI(
  fluidPage(

    titlePanel(""),

    fluidRow(
      plotOutput("image"),
      actionButton("action", label = "Next")
    )

 ))
