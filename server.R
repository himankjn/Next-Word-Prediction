
library(shiny)
source("prediction.R")

shinyServer(function(input, output) {
    

    output$prediction<-renderText({
        ngrams(input$box1)
    })
    
    
})
