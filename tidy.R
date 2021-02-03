
library(shiny)
library(tidyverse)

options(shiny.launch.browser = .rs.invokeShinyPaneViewer)

write.csv(select(starwars, name:species), "starwars.csv")

ui = fluidPage(
  sidebarLayout(
    sidebarPanel(
      fileInput("upload_data", "Upload your data set"),
      radioButtons("verb_type", "Choose a new verb for the chain", 
                   choices = c("filter", "select", "mutate", 
                               "arrange", "summarise")),
      actionButton("action_add_verb", "Add selected verb"),
      actionButton("update", "Update data"),
      div(id = "option_space")
    ),
    mainPanel(
      tableOutput("preview")
    )
  )
)

server = function(input, output) {
  data = reactiveValues()
  current = NULL
  temp = NULL
  data$id = NULL
  
  observeEvent(input$upload_data, {
     data$raw = read.csv(file = input$upload_data$datapath)
  })
  
  observeEvent(input$action_add_verb, {
    if(is.null(current)) { current <<- data$raw }
    insertUI(
      selector = "#option_space",
      ui = switch(
        input$verb_type,
        filter = {div()},
        select = {data$id <- "select_ckbxgroup"; div(
          checkboxGroupInput("select_ckbxgroup", "Select columns for select", 
            choices = names(current))
        )},
        mutate = {div()},
        arrange = {data$id <- "select_rad_arrange"; div(
          checkboxGroupInput("select_rad_arrange", "Select columns for arrange",
            choices = names(current))
        )},
        summarise = {div()}
      )
    )
  })
  
  observeEvent(input$update, {
    current <<- temp
    removeUI(paste0('#',data$id))
  })
  
  output$preview = renderTable({
    if(!is.null(data$id)) {
      if(data$id == "select_ckbxgroup"){
        req(input$select_ckbxgroup)
        temp <<- current %>% select(!!input$select_ckbxgroup)
        return(temp)
      } else if(data$id == "select_rad_arrange") {
        req(input$select_rad_arrange)
        temp <<- current %>% arrange(desc(!!sym(input$select_rad_arrange)))
        return(temp)
      }
    }
  })
  
}

shinyApp(ui, server)
