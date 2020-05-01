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

  output$image_full <- renderImage({

    list(
              src = get_bookmark_full(req(input$bookmark)),
      contentType = "image/jpeg",
              alt = "This is alternate text",
           height = 600
    )

  })

  output$image_one <- renderImage({
    list(
      src = get_bookmark_full("barter-books"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_two <- renderImage({
    list(
      src = get_bookmark_full("bbc-gardening"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_three <- renderImage({
    list(
      src = get_bookmark_full("blackwells"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_four <- renderImage({
    list(
      src = get_bookmark_full("book-depository"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_five <- renderImage({
    list(
      src = get_bookmark_full("book-depository-fish"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_six <- renderImage({
    list(
      src = get_bookmark_full("california-redwoods"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_seven <- renderImage({
    list(
      src = get_bookmark_full("city-lights"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_eight <- renderImage({
    list(
      src = get_bookmark_full("keplers"),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })


})
