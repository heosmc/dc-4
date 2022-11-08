#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Blood Storage Data"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = "radio_button1",
                   label = "RBC Age Group",
                   choices = c("≤ 13 days (Younger)" , "13 - 18 days(Middle)", "≥ 18 days (Older)"),
                   selected = "≤ 13 days (Younger)"),
      radioButtons(inputId = "radio_button2",
                   label = "Age Group",
                   choiceNames = c("30-49" , "50-59", "60-69", "70-79"),
                   choiceValues = c("1", "2", "3", "4"),
                   selected = "1"),
      sliderInput("numbin", "Number of bins:", min = 5, max = 50, value = 25)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("boxplot1"),
      plotOutput("boxplot2"),
      plotlyOutput("histgram")
    )
  )
))