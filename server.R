#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Setup lat/lng structure of some world capitals
names <- c("Amsterdam", "Berlin", "Paris", "Tokyo", "Ankara", "Beijing", "Washington")
coordinates <- list(
  c(52.3546273,4.8284122), 
  c(52.506761,13.2843076),
  c(48.8588376,2.276849),
  c(35.6732615,139.569962),
  c(39.933333,32.866667),
  c(39.916667,116.383333),
  c(38.904722,-77.016389)
)
capitals <- setNames(coordinates, names)

# Define server logic required to draw our map
shinyServer(function(input, output) {
  
  points <- reactiveValues(lats = c(), lngs = c())
  
  observeEvent(input$clearmarkers, {
    points$lats <- c()
    points$lngs <- c()
  })
  
  observeEvent(input$addmarker, {
    points$lats <- c(points$lats, as.numeric(input$lat))
    points$lngs <- c(points$lngs, as.numeric(input$lng))
  })
  
  observeEvent(input$addcapital, {
    coords <- capitals[[input$preselect]]
    
    if (!is.null(coords)) {
      points$lats <- c(points$lats, coords[1])
      points$lngs <- c(points$lngs, coords[2])
    }
    else {
      points$lats <- c(points$lats, 10)
      points$lngs <- c(points$lngs, 10)
    }
  })
  
  output$mymap <- renderLeaflet({
    
    if (any(is.null(points$lats), is.null(points$lngs))) {
      leaflet() %>% addTiles()
    }
    else {
      leaflet() %>% addTiles() %>%
        
        # add new markers
        addMarkers(lat = points$lats, lng = points$lngs)  
    }
    
  })
})
