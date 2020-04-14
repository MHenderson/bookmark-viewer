library(bootstraplib)
library(shiny)

bs_theme_new()

shinyUI(
  fluidPage(

    bootstrap(),

    titlePanel(""),

    fluidRow(
      column(
        width = 2,
        uiOutput("bookmark")
      ),
      column(
        width = 5,
        wellPanel(plotOutput("image_front"))
      ),
      column(
        width = 5,
        wellPanel(plotOutput("image_back"))
      )
    )

 ))
