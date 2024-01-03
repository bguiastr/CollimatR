# Helpers
my_col <- function(color, alpha) {
  do.call(rgb,c(as.list(col2rgb(color)/255), alpha))
}

# Define the app backend
function(input, output, session) {
  
  # Required by shinyhelper
  observe_helpers()
  
  # Initialize reactive values
  ## Image cropping value
  crop    <- reactiveValues(x = c(0, 0), y = c(0, 0))
  
  ## Update cropping value if done via the mouse cursor
  observeEvent(input$img_dblclick, {
    brush <- input$img_brush
    if (!is.null(brush)) {
      crop <- c(sort(c(brush$xmin, brush$xmax)), sort(c(brush$ymin, brush$ymax)))
    } else {
      crop <- c(0, 0, 0, 0)
    }
    
    ## Update the UI accordingly
    updateNumericInput(session, "cleft",   value = crop[1])
    updateNumericInput(session, "cright",  value = crop[2])
    updateNumericInput(session, "ctop",    value = crop[3])
    updateNumericInput(session, "cbottom", value = crop[4])
  })
  
  # Import image
  img_raw <- reactive({
    validate(
      need(is.character(input$img_file$datapath), "Please select and upload a collimation image to get started.")
    )
    
    # Read image file 
    image_read(input$img_file$datapath)
  })
  
  
  # Image processing
  img_process <- reactive({
    
    # Input check
    validate(need(inherits(img_raw(), "magick-image"), "No image loaded"))
    
    # Initialize image
    img_obj <- img_raw()
    
    ## Scale image [destructive]
    if (input$scale != 100) {
      w       <- image_info(img_obj)$width # Original image width in pixels
      img_obj <- image_scale(img_obj, w*input$scale/100)
    }
    
    ## Crop image [destructive]
    if (sum(c(input$cright, input$cleft, input$cbottom, input$ctop)) > 0) {
      img_obj <- image_crop(
        image = img_obj, 
        geometry = geometry_area(
          width  = diff(c(input$cleft, input$cright)), 
          height = diff(c(input$ctop, input$cbottom)), 
          x_off  = input$cleft, 
          y_off  = input$ctop
        )
      )
    }
    
    ## Rotate image [destructive]
    if (input$rotate != 0) {
      img_obj <- img_obj %>% 
        image_background(color = "black") %>% # Avoid white areas added by default when rotating the object
        image_rotate(input$rotate)
    }  
    
    img_obj
  })
  
  
  img_final <- reactive({
    # Input check
    validate(need(inherits(img_process(), "magick-image"), "No image loaded"))
    
    # Initialize the image
    img_inf <- image_info(img_process())
    img_obj <- image_draw(img_process())
    
    # Store center point coordinates
    x_center <- img_inf$width * (input$xoffset + 100)/200
    y_center <- img_inf$height * (input$yoffset + 100)/200
    
    ## Draw the grid
    ## Note: the grid is centered around the center point
    if (input$grid) {
      abline(v = c(
        seq(from = x_center, to = 0, by = -img_inf$width*input$grid_size/200), 
        seq(from = x_center, to = img_inf$width, by = img_inf$width*input$grid_size/200)
      ), col = my_col("grey50", alpha = 0.5))
      abline(h = c(
        seq(from = y_center, to = 0, by = -img_inf$height*input$grid_size/200), 
        seq(from = y_center, to = img_inf$height, by = img_inf$height*input$grid_size/200)
      ), col = my_col("grey50", alpha = 0.5))
    }
    
    ## Draw the reference axis
    if (input$reticules) {
      
      ## Focuser
      abline(v = x_center, col = "red")
      abline(h = y_center, col = "red")
      draw.circle(
        x = x_center, y = y_center, 
        radius = img_inf$width * input$focuser/200, 
        border = "red"
      )
      
      ## Secondary mirror
      draw.circle(
        x = x_center, y = y_center, 
        radius = img_inf$width * input$secondary/200, 
        border = "green"
      )
    }
    dev.off()
    
    img_obj
  })
  
  output$img_out <- renderImage({
    
    # Input check
    validate(need(inherits(img_final(), "magick-image"), "No image loaded"))
    
    # Create the final image
    tmpfile <- image_write(
      image  = img_final(), 
      path   = tempfile(fileext = "jpg"), 
      format = "jpg"
    )
    
    # Return a list
    list(src = tmpfile, contentType = "image/jpeg")
  }, 
  deleteFile = TRUE
  )
  
  output$save_image <- downloadHandler(
    filename = function() { 
      paste0("CollimatR_", format(Sys.time(), "%b-%d-%Y_%Hh%M"), ".jpg")
      },
    content = function(file) {
      image_write(image = img_final(), path = file, format = "jpeg")
    }
  )
  
  
}