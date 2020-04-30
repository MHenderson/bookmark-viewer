library(fs)
library(magick)
library(shiny)
library(tidyverse)

bookmarks <- tibble(
    image_path = dir_ls("bookmarks/images", recurse = TRUE, type = "file")
  ) %>%
  mutate(
    bookmark = gsub("bookmarks/images/", "", dirname(image_path))
  ) %>%
  mutate(
    image = map(image_path, image_read)
  )

shinyServer(function(input, output) {

  image_front <- reactive({
    bookmarks %>%
      filter(bookmark == req(input$bookmark)) %>%
      slice(1) %>%
      pull(image) %>%
      first()
  })

  image_back <- reactive({
    bookmarks %>%
      filter(bookmark == req(input$bookmark)) %>%
      slice(2) %>%
      pull(image) %>%
      first()
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
      choices = unique(bookmarks$bookmark)
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
