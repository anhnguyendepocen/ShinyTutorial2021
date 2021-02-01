
library(shiny)
library(tidyverse)

options(shiny.launch.browser = .rs.invokeShinyWindowViewer)

# User interface source

# Fluid page -
#  - Sidebar layout
#    - sidebar panel
#      - Upload data
#      - Select verb
#      - Add verb
#      - Update output
#    - Main panel
#      - Output preview
ui = fluidPage()


# Server source

server = function(input, output) {
  # data - store read data and verb ID
  # set current data, temp. data, and ID to NULL
  
  # Observe file input button
  #  - read and store data from file input object
  
  # Observe action button add verb
  #  - check current data for validity
  #  - insert UI element for very
  #    - switch between selected verb
  #      for each verb type, update ID and return 
  #      verb UI element
  
  # Observe update data
  #  - set current data to temp data
  #  - remove the previous UI element (clean up)
  
  # Preview verb applied to the data
  #  - If data ID is not NULL
  #    - if/else if to select the correct verb ID
  #      - Update temp data by applying the verb
  #      - return temp
}


# Launch app
shinyApp(ui, server)

