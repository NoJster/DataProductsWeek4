#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Add Markers to Worldmap"),
  
  # Sidebar with two text boxes and an action button for adding new markers 
  sidebarLayout(
    sidebarPanel(
      h4("Add your own marker"),
      textInput("lat",
                "Latitude:"),
      textInput("lng",
                "Longitude:"),
      actionButton("addmarker", "Add Marker"),
      h4("Add a predefined capital"),
      selectInput("preselect", "(Some) Capitals of the World", c("Amsterdam", "Berlin", "Paris", "Tokyo", "Ankara", "Beijing", "Washington")),
      actionButton("addcapital", "Add Capital"),
      br(),
      actionButton("clearmarkers", "Clear Markers")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      leafletOutput("mymap")
    )
  )
))
