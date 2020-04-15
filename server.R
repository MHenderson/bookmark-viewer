library(fs)
library(magick)
library(shiny)
library(tidyverse)

X <- tibble(
  image_path = dir_ls("bookmarks/images",recurse = TRUE, type = "file")
) %>%
  mutate(
    bookmark = gsub("bookmarks/images/", "", dirname(image_path))
  )

N <- nrow(X)

shinyServer(function(input, output) {

  image_front <- reactive({
    X %>%
      filter(bookmark == req(input$bookmark)) %>%
      slice(1) %>%
      pull(image_path) %>%
      image_read()
  })

  image_back <- reactive({
    X %>%
      filter(bookmark == req(input$bookmark)) %>%
      slice(2) %>%
      pull(image_path) %>%
      image_read()
  })

  image_full <- reactive({
    c(image_front(), image_back()) %>%
      image_append() %>%
      image_write(tempfile(fileext = 'jpg'), format = 'jpg')

  })

  output$bookmark <- renderUI({
    selectInput(
      inputId = "bookmark",
      label = "",
      choices = unique(X$bookmark)
    )
  })

  output$image_full <- renderImage({

    list(
      src = image_full(),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )

  })

})
