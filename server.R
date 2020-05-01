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
    image = map(image_path, image_read),
  ) %>%
  mutate(
    image = map(image, image_scale, "x600")
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

images_grid <- full_images %>%
  mutate(
    page = rep(0:1, each = 8),
    position = rep(1:8, 2)
  )

get_image_grid <- function(page_, position_) {
  images_grid %>%
    filter(page == page_, position == position_) %>%
    pull(full_image) %>%
    first() %>%
    image_write(tempfile(fileext = 'jpg'), format = 'jpg')
}

shinyServer(function(input, output) {

  output$image_one <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 1),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_two <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 2),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_three <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 3),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_four <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 4),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_five <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 5),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_six <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 6),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_seven <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 7),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })

  output$image_eight <- renderImage({
    list(
      src = get_image_grid(input$page %% 2, 8),
      contentType = "image/jpeg",
      alt = "This is alternate text",
      height = 600
    )
  })


})
