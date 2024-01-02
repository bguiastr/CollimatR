library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
navbarPage(
  theme       = shinytheme("slate"),
  title       = "CollimatR",
  windowTitle = "CollimatR",
  position    = "static-top",
  collapsible = TRUE,
  footer      = tags$footer(
    class = "footer",
    p("Benjamin Guiastrennec 2024", 
      style = "color: grey;font-size: 11px;text-align: center;position: relative;min-height: 100%;"
      #style = "display: block; margin: auto; margin-top: 14px;"
    )
  ),
  
  tabPanel(
    title = "Collimation",
    icon  = icon("bullseye"),
    fluidPage(
      
      # Sidebar with a slider input for number of bins
      sidebarLayout(
        sidebarPanel(
          width = 3,
          h4("1. Select Collimation Image"),
          fileInput("img_file", label = NULL, accept = "image/*"),
          
          hr(),
          
          h4("2. Image Adjustments"),
          sliderInput("scale", "Scale", min = 0, max = 100, value = 100, post = "%"),
          
          strong("Crop"),
          helpText("Note: select an area on the image and double click to validate"),
          fluidRow(
            column(
              numericInput("ctop", "Top", value = 0),
              width = 6, offset = 3, style = "margin-bottom:-15px;"
            ), 
          ),
          fluidRow(
            column(
              numericInput("cleft", "Left", value = 0),
              width = 6, style = "margin-bottom:-15px;"
            ),
            column(
              numericInput("cright", "Right", value = 0),
              width = 6, style = "margin-bottom:-15px;"
            )
          ),
          fluidRow(
            column(
              numericInput("cbottom", "Bottom", value = 0),
              width = 6, offset = 3, style = "margin-bottom:-15px;"
            )
          ),
          sliderInput("rotate", "Rotate", min = -180, max = 180, value = 0, post = "°")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          width = 9,
          imageOutput(
            "img_out",
            dblclick = "img_dblclick",
            brush = brushOpts(
              id = "img_brush",
              resetOnNew = TRUE
            )
          ) # Ignores the width/height arguments...
        )
      )
    )
  ),
  tabPanel(title = "About",
           icon  = icon("circle-info"),
           p("Coming Soon")
  )
)