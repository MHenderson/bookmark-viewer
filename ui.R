library(bootstraplib)
library(shiny)

bs_theme_new()

shinyUI(
  fluidPage(

    bootstrap(),

    titlePanel("Bookmarks"),

    fluidRow(
      column(
        width = 12,
        uiOutput("bookmark")
      )
    ),
    fluidRow(
      column(
        width = 12,
        plotOutput("image_full")
      )
    )
 ))
