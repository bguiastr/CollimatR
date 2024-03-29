# Define UI
ui <- function(request) {
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
        
        # Inline CSS
        tags$head(tags$style(HTML(
          "#mytoggle {font-size:16px;color:#ffffff;font-weight: 400;}",
          "h1 {font-size:0px;}", ## Make the title disappear in the app
          "h2 {font-size:36px;}"))),
        
        # Sidebar with a slider input for number of bins
        sidebarLayout(
          sidebarPanel(
            width = 3,
            
            ## Section 1: Import image ---
            collapse_toggle(id = "sec1", label = "1. Collimation Image", value = TRUE),
            conditionalPanel(
              condition = "input.sec1 == true",
              helper(
                shinyFilesButton("img_name", label = "Select image", title = NULL, multiple = FALSE, icon = icon("image")), 
                type = "inline", title = "Select input file", colour = "#D3D3D3",
                content = p(
                  p("Click the", code("Select image"), " button and select an image of your secondary mirror seen through a collimation eyepiece. Supported formats are", code(".jpg"), code(".png"), ", and", code(".heic"), ".")
                )
              ),
              wellPanel("Imported image:", br(), em(htmlOutput("filename"))),
              helper(
                strong("Image auto-reload"),
                type = "inline", title = "Image auto-reload", colour = "#D3D3D3",
                content = p(
                  p("When the", code("Image auto-reload"), "box is checked the collimation image will reloaded from the file based on the", code("interval (mg)"), ". This is intended to be used together with an external program automatically capturing images from a camera.")
                )
              ),
              fluidRow(
                column(width = 6, checkboxInput("refresh", "Active", value = FALSE)),
                column(width = 6, numericInput("delay", "Interval (ms)", value = 100, min = 0, step = 50))
              ),
              hr()
            ),
            
            ## Section 2: Image adjustments ---
            collapse_toggle(id = "sec2", label = "2. Image Adjustments", value = TRUE),
            conditionalPanel(
              condition = "input.sec2 == true",
              sliderInput("scale", "Scale", value = 100, min = 0, max = 100, step = 0.5, post = "%"),
              
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
                sliderInput("rotate", "Rotate", min = -180, max = 180, value = 0, step = 0.5, post = "°"),
                type = "inline", title = "Adjusting secondary mirror orientation", colour = "#D3D3D3",
                content = p("Adjust the image orientation to align the secondary mirror mount to the x axis.")
              ),
              hr()
            ),
            
            ## Section 3: Reticules ---
            collapse_toggle(id = "sec3", label = "3. Reticules", value = TRUE),
            conditionalPanel(
              condition = "input.sec3 == true",
              fluidRow(
                column(checkboxInput("grid", "Show grid", value = FALSE), width = 6),
                column(checkboxInput("reticules", "Show reticules", value = FALSE), width = 6)
              ),
              sliderInput("grid_size", "Grid size", value = 5, min = 0, max = 100, post = "%"),
              
              fluidRow(
                column(sliderInput("xoffset", "X-origin offset", value = 0, min = -100, max = 100, step = 0.5, post = "%"), width = 6),
                column(sliderInput("yoffset", "Y-origin offset", value = 0, min = -100, max = 100, step = 0.5, post = "%"), width = 6)
              ),
              sliderInput("focuser", HTML("<span style=\"color:red\">Focuser</span> reticule size"), value = 50, min = 0, max = 100, step = 0.5, post = "%"),
              sliderInput("secondary", HTML("<span style=\"color:yellow\">Secondary mirror</span> reticule size"), value = 30, min = 0, max = 100, step = 0.5, post = "%"),
              sliderInput("primary", HTML("<span style=\"color:green\">Primary mirror</span> reticule size"), value = 20, min = 0, max = 100, step = 0.5, post = "%")
            ),
            hr(),
            
            ## Section 4: Save ---
            collapse_toggle(id = "sec4", label = "4. Save", value = TRUE),
            conditionalPanel(
              condition = "input.sec4 == true",
              downloadButton(outputId = "save_image", label = "Download image", class = "btn-primary"),
              bookmarkButton()
            )
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
             fluidPage(
               column(
                 width  = 8, 
                 offset = 2,
                 includeMarkdown("README.md"), 
                 br(), br()
               )
             )
    )
  )
}