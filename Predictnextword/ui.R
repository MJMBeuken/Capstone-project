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



shinyUI(dashboardPage(skin="blue",
                      dashboardHeader(title=div(h3("Predict Next Word App"), style = "color:white"), titleWidth = 325),
                      dashboardSidebar(h2("Instructions:", align = "center"),
                                       br(),
                                       h5("1. Enter a word or sentence in the text box.", align="center"),
                                       h5("2. Wait a moment.", align="center"),
                                       h5("3. The predicted next word prints below in darkred.", align="center"),
                                       br(),
                                       hr(),
                                       br(),
                                       em(h5("Use button next to title to see app fullscreen.", align="center")),
                                       br(),
                                       hr(), width = 325),
                      
                      dashboardBody(
                              
                              fluidRow(
                                      box(background = "blue", solidHeader = T, textInput("user_input", h3("Write sentence or word below:"))
                                          , width = 12),
                                      
                                      box(background = "blue", solidHeader = T, h3("Predicted Next Word:", align="center"), width = 12),
                                      
                                      box(width = 12, height = 100, status = "info", h2(strong(span(textOutput("ngram_output"), style="color:darkred"))), align="center"
                                          
                                      ),
                                      box(background="blue", solidHeader=T, width = 12,
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          br(),
                                          h6("MJM Beuken - 06-20-2018"), align="center"),
                                      hr()
                              )
                      )
))