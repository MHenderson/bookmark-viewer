library(bootstraplib)
library(shiny)

bs_theme_new()

shinyUI(
  fluidPage(

    bootstrap(),

    tags$head(
      tags$style(HTML("
       .col-sm-1:hover{
         z-index:555555 !important;
       }
    "))
    ),

    fluidRow(
      column(
        width = 12,
        uiOutput("bookmark")
      )
    ),
    #fluidRow(
    #  column(
    #    width = 12,
    #    plotOutput("image_full")
    #  )
    #),
    fluidRow(
      column(width = 1, plotOutput("image_one")),
      column(width = 1, plotOutput("image_two")),
      column(width = 1, plotOutput("image_three")),
      column(width = 1, plotOutput("image_four")),
      column(width = 1, plotOutput("image_five")),
      column(width = 1, plotOutput("image_six")),
      column(width = 1, plotOutput("image_seven")),
      column(width = 1, plotOutput("image_eight")),
    )
 ))
