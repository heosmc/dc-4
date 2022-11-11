#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(medicaldata)
library(plotly)

blood_storage <- medicaldata::blood_storage
blood_storage2 <- blood_storage %>%
  mutate(RBC.Age.Group2 = case_when(blood_storage$RBC.Age.Group == 1 ~ "≤ 13 days (Younger)",
                                    blood_storage$RBC.Age.Group == 2 ~ "13 - 18 days(Middle)",
                                    blood_storage$RBC.Age.Group == 3 ~ "≥ 18 days (Older)")) %>%
  mutate(Age_group = cut(Age, breaks = c(30, 50, 60, 70, 80),
                         right=FALSE,
                         labels=c("1", "2", "3", "4"))) %>% 
  select(RBC.Age.Group2, Age_group, PreopPSA, TimeToRecurrence) %>% 
  na.omit()


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$description1 <- renderText({
    "The plot shows the preoperative prostate	specific	antigen	(PSA) versus RBC
    storage	duration	group. Feel free to choose the random RBC Age Group"
  })
  
  output$description2 <- renderText({
    "The plot shows the preoperative	prostate	specific	antigen	(PSA) versus
    age categories. Feel free to choose the random Age Group"
  })
  
  output$description3 <- renderText({
    "The plot shows the histogram of time	to	biochemical	recurrence	of	
    prostate	cancer. Feel free to choose the random bins"
  })
  
  output$boxplot1 <- renderPlot({
    x    <- blood_storage2$RBC.Age.Group2
    PreopPSA <- blood_storage2$PreopPSA
    
    boxplot(PreopPSA[x==input$radio_button1], 
            col = "#75AADB",
            xlab = paste("RBC storage duration group:", input$radio_button1),
            ylab = "PSA", 
            main = "RBC storage duration group by PSA")
  })
  
  output$boxplot2 <- renderPlot({
    x    <- blood_storage2$Age_group
    PreopPSA <- blood_storage2$PreopPSA
    
    boxplot(PreopPSA[x==input$radio_button2], 
            col = "#75AADB",
            xlab = paste("Different age group:", input$radio_button2),
            ylab = "PSA", 
            main = "Different age group by PSA")
  })
  
  output$histgram <- renderPlotly({
    plot_ly(blood_storage2, x = ~TimeToRecurrence, 
            xbins = list(size = (max(blood_storage2$TimeToRecurrence) - min(blood_storage2$TimeToRecurrence))/input$numbin),
            marker = list(line = list(color = "white", width = 2))) %>%
      add_histogram(name = "plotly.js")
  })
  
})