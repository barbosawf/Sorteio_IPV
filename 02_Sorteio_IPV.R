package.check <- function(packages) {
  for (x in packages) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
    }
    library(x, character.only = TRUE)
  }
}

packages <- c("tidyverse", "rstudioapi", "magick", "cowplot", "shiny")

package.check(packages)

set_wd_here <- function (path = NULL) 
{
  if (!requireNamespace("rstudioapi", quietly = TRUE)) {
    if (interactive() == TRUE) {
      inst <- switch(menu(c("Yes", "No"), title = "Package {rstudioapi} required but not installed.\nDo you want to install it now?"), 
                     "yes", "no")
      if (inst == "yes") {
        install.packages("rstudioapi", quiet = TRUE)
      }
      else {
        message("To use `set_wd_here()`, first install {rstudioapi}.")
      }
    }
  }
  else {
    dir_path <- dirname(rstudioapi::documentPath())
    if (!is.null(path)) {
      dir_path <- paste0(dir_path, "/", path)
    }
    d <- try(setwd(dir_path), TRUE)
    if (inherits(d, "try-error")) {
      cat(paste0("Cannot change working directory to '", 
                 dir_path, "'."))
      done <- readline(prompt = "Do you want to create this folder now? (y/n) ")
      if (done == "y") {
        dir.create(dir_path)
        message("Directory '", dir_path, "' created.")
        setwd(dir_path)
        message("Working directory set to '", dir_path, 
                "'")
      }
    }
    else {
      message("Working directory set to '", dir_path, "'")
    }
  }
}
  


GraphMyDataPlease <- function(df){

  ipv <- magick::image_read("ipv.jpg")
  nomes <- unique(df[[1]])
  nomes <- sub(" +$", "", nomes) 
  t = seq(0.9, 0.05, -0.09)^2
  
  x11()
  cowplot::ggdraw()
  for (i in t) {
    
    nomes |>
      sample(1) -> s_name
    cowplot::ggdraw() +
      cowplot::draw_image(ipv,  x = 0., y = 0, scale = .9) +
      geom_label(aes(x = 0.5, y = 0.12, label = s_name), 
                 size = 10,
                 color = "black", 
                 label.padding = unit(1.5, "lines"),
                 label.r = unit(0.55, "lines"),
                 label.size = 1) -> p
    
    plot(p)
    Sys.sleep(i)
    if (i > min(t)) {
      cowplot::ggdraw() %>% plot()
    }
  }

}



# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Graph me up"),
  
  # Sidebar with a tool to upload a csv file
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Choose CSV File",
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    req(input$file1)  # Don't do anything until the file has been chosen
    df <- read.csv(input$file1$datapath)  # Read in the csv file selected
    GraphMyDataPlease(df)  # Make a graph of the data
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
