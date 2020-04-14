library(fs)
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

  output$bookmark <- renderUI({
    selectInput(
      inputId = "bookmark",
      label = "",
      choices = unique(X$bookmark)
    )
  })

  output$image_front <- renderImage({
    list(
      src = X %>% filter(bookmark == input$bookmark) %>% slice(1) %>% pull(image_path),
      contentType = 'image/jpeg',
      alt = "This is alternate text",
      height = 400
    )
  }, deleteFile = FALSE)

  output$image_back <- renderImage({
    list(
      src = X %>% filter(bookmark == input$bookmark) %>% slice(2) %>% pull(image_path),
      contentType = 'image/jpeg',
      alt = "This is alternate text",
      height = 400
    )
  }, deleteFile = FALSE)

})
