row1 <- bookmarks$image[[1]]

for(i in 2:16) {
  row1 <- image_append(c(row1, bookmarks$image[[i]]))
}

row2 <- bookmarks$image[[17]]

for(i in 18:32) {
  row2 <- image_append(c(row2, bookmarks$image[[i]]))
}

Y <- image_append(c(row1, row2), stack = TRUE)
