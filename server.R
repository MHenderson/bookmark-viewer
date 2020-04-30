library(fs)
library(magick)
library(shiny)
library(tidyverse)

bookmarks <- tibble(
    image_path = dir_ls(
         path = "bookmarks/images",
      recurse = TRUE,
         type = "file"
    )
  ) %>%
  mutate(
    bookmark = gsub(
          pattern = "bookmarks/images/",
      replacement = "",
                x = dirname(image_path)
    )
  ) %>%
  mutate(
    image = map(image_path, image_read)
  ) %>%
  mutate(
    side = rep(c("front", "back"), n()/2)
  )

full_images <- bookmarks %>%
  group_by(bookmark) %>%
  summarise(
    full_image = list(image_append(c(image[[1]], image[[2]])))
  )

get_bookmark_full <- function(name) {
  full_images %>%
    filter(bookmark == name) %>%
    pull(full_image) %>%
    first() %>%
    image_write(tempfile(fileext = 'jpg'), format = 'jpg')
}

shinyServer(function(input, output) {

  output$bookmark <- renderUI({
    selectInput(
      inputId = "bookmark",
      label = "",
      choices = unique(bookmarks$bookmark)
    )
  })

  output$image_full <- renderImage({

    list(
      src = get_bookmark_full(req(input$bookmark)),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )

  })

})
