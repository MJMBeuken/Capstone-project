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
        library(tidyverse)))


uni.words <- readRDS("./uni.words2.RDS")
bi.words <- readRDS("./bi.words2.RDS")
tri.words  <- readRDS("./tri.words2.RDS")
quad.words <- readRDS("./quad.words2.RDS")



unigram <- function(text){
        sample(head(uni.words$word_1, 10), 1) -> out
        return(sapply(out, function(x) paste(strsplit(as.matrix(x), "")[[1]], collapse="")))
}




#Create Ngram Matching Functions
bigram <- function(text){
        
        text <- word(text,-1)
        filter(bi.words, 
               word_1 == text) %>% 
                filter(row_number() == 1L) %>%
                select(num_range("word_", 2)) -> out
       
        if(dim(out)[1] == 0){
               unigram(text)
        }else{
                return(sapply(out, function(x) paste(strsplit(as.matrix(x), "")[[1]], collapse="")))
        }
        
}

trigram <- function(text){
        
        text <- word(text,-2 , -1)
        word <- word(text, 1)
        word2 <- word(text, 2)
        filter(tri.words, 
               word_1==word, 
               word_2==word2)  %>% 
                filter(row_number() == 1L) %>%
                select(num_range("word_", 3)) -> out
        if(dim(out)[1] == 0){
                bigram(text)
        }else{
                return(sapply(out, function(x) paste(strsplit(as.matrix(x), "")[[1]], collapse="")))
        }
        
}

quadgram <- function(text){
        word <- word(text, 1)
        word2 <- word(text, 2)
        word3 <- word(text, 3)
        filter(quad.words, 
               word_1 == word, 
               word_2 == word2, 
               word_3 == word3)  %>% 
               filter(row_number() == 1L) %>%
                select(num_range("word_", 4)) -> out
        
        if(dim(out)[1] == 0){
                trigram(text)
        }else{
                return(sapply(out, function(x) paste(strsplit(as.matrix(x), "")[[1]], collapse="")))
              
        }
        
}

#' Create User Input and Data Cleaning Function; Calls the matching functions
predictNextword <- function(input){
        # Create a dataframe
        input <- data_frame(text = input)
        # Clean the Inpput
        replace_reg <- "[^[:alpha:][:space:]]*"
        input <- input %>%
                mutate(text = str_replace_all(text, replace_reg, ""))
        # Find word count, separate words, lower case
        input_count <- str_count(input, boundary("word"))
        input_words <- tolower(input)
        input_words <- ifelse(input_count == 1, input_words, 
                              ifelse(input_count == 2, input_words, word(input_words,-3 , -1)))
        # Call the matching functions
        out <- ifelse(input_count == 1, bigram(input_words), 
                      ifelse (input_count == 2, trigram(input_words), quadgram(input_words)))
      
        # Output
        return(out)
}
