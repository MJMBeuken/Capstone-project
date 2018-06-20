suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(reshape2),
        library(ggplot2),
        library(scales),
        library(grid),
        library(dplyr),
        library(ggpubr),
        library(tidyr),
        library(splitstackshape),
        library(ngram),
        library(stringi),
        library(tidyverse),
        library(shinydashboard)))


source("./task 5 prediction.R")
uni.words <- readRDS("./uni.words2.RDS")
bi.words <- readRDS("./bi.words2.RDS")
tri.words  <- readRDS("./tri.words2.RDS")
quad.words <- readRDS("./quad.words2.RDS")

# Define server logic required to draw a histogram
shinyServer(function(input, output) { 
        
        output$ngram_output <- renderText({
                if(input$user_input == "") ""
                else{predictNextword(input$user_input)}
                
        })
        
        
})