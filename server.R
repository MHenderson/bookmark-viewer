library(fs)
library(shiny)
library(tidyverse)

X <- tibble(
  image_path = dir_ls("bookmarks/images", recurse = TRUE, type = "file")
)

N <- nrow(X)

shinyServer(function(input, output) {

  output$image <- renderImage({
    list(
              src = X %>% slice((input$action %% N) + 1) %>% pull(image_path),
      contentType = 'image/jpeg',
              alt = "This is alternate text",
              height = 800
    )
  }, deleteFile = FALSE)

})
