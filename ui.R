library(shiny)
library(shinythemes)
library(shinyhelper)

# Define UI for application that draws a histogram
navbarPage(
  theme       = shinytheme("cyborg"),
  title       = "CollimatR",
  windowTitle = "CollimatR",
  position    = "static-top",
  collapsible = TRUE,
  footer      = tags$footer(
    class = "footer",
    p("Benjamin Guiastrennec 2024", 
      style = "color: grey;font-size: 11px;text-align: center;"
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
          h4("1. Collimation Image"),
          helper(
            fileInput("img_file", label = NULL, accept = "image/*", width = "95%"), 
            type = "inline", title = "Uploading images", colour = "#D3D3D3",
            content = p("Click the", code("Browse..."), " button and select an image of your secondary mirror seen through a collimation eyepiece.")
          ),
          
          hr(),
          
          h4("2. Image Adjustments"),
          sliderInput("scale", "Scale", min = 0, max = 100, value = 100, post = "%"),
          
          helper(
            strong("Crop"), 
            type = "inline", title = "Cropping", colour = "#D3D3D3",
            content = p(p("To crop the image, select an area on the image output and double click whithin the highlighed area to validate."), br(),
                        p("The cropping can be adjused using the numeric values in the 4 boxes. The origin point (i.e., 0, 0) is the top left corner."), br(),
                        p("To reset the cropping double click on the image anywhere outside the highlighted ared"), br(),
                        em("Known limitations:", br(),
                        "- Reset the cropping before selecting a new area.", br(),
                        "- The cropping needs to be set before the rotation."))
            ),
          
          fluidRow(
            column(
              numericInput("ctop", "Top", value = 0, min = 0),
              width = 6, offset = 3, style = "margin-bottom:-15px;text-align: center;"
            )
          ),
          fluidRow(
            column(
              numericInput("cleft", "Left", value = 0, min = 0),
              width = 6, style = "margin-bottom:-15px;text-align: center;"
            ),
            column(
              numericInput("cright", "Right", value = 0, min = 0),
              width = 6, style = "margin-bottom:-15px;text-align: center;"
            )
          ),
          fluidRow(
            column(
              numericInput("cbottom", "Bottom", value = 0, min = 0),
              width = 6, offset = 3, style = "margin-bottom:-15px;text-align: center;"
            )
          ),
          helper(
          sliderInput("rotate", "Rotate", min = -180, max = 180, value = 0, post = "°"),
          type = "inline", title = "Adjusting secondary mirror orientation", colour = "#D3D3D3",
          content = p("Adjust the image orientation to align the secondary mirror mount to the x axis.")
          ),
          
          h4("3. Reticules"),
          checkboxInput("reticules", "Show reticules", value = FALSE),
          checkboxInput("grid", "Show grid", value = FALSE),
          sliderInput("focuser", "Focuser reticule size", value = 50, min = 0, max = 100, post = "%"),
          sliderInput("secondary", "Secondary reticule size", value = 30, min = 0, max = 100, post = "%"),
          sliderInput("xoffset", "X-origin offset", value = 0, min = -100, max = 100, post = "%"),
          sliderInput("yoffset", "Y-origin offset", value = 0, min = -100, max = 100, post = "%")
          
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