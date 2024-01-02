library(shiny)
library(magick)

function(input, output, session) {
  
  # Initialize reactive values
  ## Image cropping value
  crop    <- reactiveValues(x = NULL, y = NULL)
  
  ## When a double-click happens, check if there's a brush on the image
  observeEvent(input$img_dblclick, {
    brush <- input$img_brush
    if (!is.null(brush)) {
      crop$x <- c(brush$xmin, brush$xmax)
      crop$y <- c(brush$ymin, brush$ymax)
    } else {
      crop$x <- NULL
      crop$y <- NULL
    }
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
    if (!is.null(crop$x)) {
      img_obj <- image_crop(img_obj, geometry_area(width = diff(crop$x), height = diff(crop$y), x_off = min(crop$x), y_off = min(crop$y)))
    }
    
    ## Rotate image [destructive]
    if (input$rotate != 0) {
      img_obj <- image_rotate(img_obj, input$rotate)
    }      
    
    img_obj
  })
  
  output$img_out <- renderImage({
    # Input check
    validate(need(inherits(img_process(), "magick-image"), "No image loaded"))
    
    # Create the final image
    tmpfile <- image_write(
      image  = img_process(), 
      path   = tempfile(fileext = "jpg"), 
      format = "jpg"
    )
    
    # Return a list
    list(src = tmpfile, contentType = "image/jpeg")
  }, 
  deleteFile = TRUE
  )
  
}