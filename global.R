# Load dependencies
library(shiny)
library(shinythemes)
library(shinyhelper)
library(shinyWidgets)
library(shinyFiles)
library(magick)
library(plotrix)


# Define helpers functions
collapse_toggle <- function(id, label, value = TRUE) {
  prettyToggle(
    inputId    = id,
    value      = value,
    label_on   = span(id = "mytoggle", label),
    label_off  = span(id = "mytoggle", label),
    icon_on    = icon("angle-down"),
    icon_off   = icon("angle-right"),
    status_on  = "info",
    status_off = "info",
    outline    = TRUE,
    thick      = TRUE,
    plain      = TRUE,
    inline     = FALSE,
    animation  = "rotate")
}

# Helpers
my_col <- function(color, alpha) {
  do.call(rgb,c(as.list(col2rgb(color)/255), alpha))
}

# Enable bookmarking
enableBookmarking(store = "url")

# Set starting directory for folder
roots <- c(Home = "~")
