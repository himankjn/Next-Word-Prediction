

library(shiny)



shinyUI(fluidPage(

    theme='boot.css',
    span(titlePanel("Word Prediction by Katz's Back Off Model"),style="color:purple"),
    mainPanel(
        h4("This is a Prototype text processing Application that is used to predict next word in a sentence using Katz's back off model."),
        h4("It's part of the John Hopkins University Data Science capstone project from Coursera."),
        h4("Follow links below for Further information!"),
        h5(a("JHU Data Science Coursera",href="https://www.coursera.org/specializations/jhu-data-science",style='color:purple')),
        h5(a("Documentation for the Application",href="http://rpubs.com/himank369123/JHUCAPSTONE",style='color:purple')),
        h5(a("Source Code and other Resources",href="https://github.com/himankjn/JHU-NLP-Capstone",style='color:purple')),
        HTML("The <b> Word Prediction </b> tab can be used to test the App."),br(),
        HTML("The <b> BiGram, TriGram,TetraGram,PentaGram </b> tabs explore commonly occuring bigrams,trigrams,tetragrams and pentagrams."),br(),br(),
       

 
            tabsetPanel(
                type="tabs",
            tabPanel("Word Prediction",
                     br(),
                     h1("Word Predicion using Ngrams"),
                     sidebarLayout(
                         sidebarPanel(
                             span(h2("Instructions to use the App:"),style="color:purple"),
                             
                             tags$div(tags$ul(
                                 tags$li(tags$span("Type any sentence in the textbox"),style="color:black"),
                                 tags$li(tags$span("The next word predicted is show below in purple color"),style="color:black"),
                                 tags$li(tags$span("A question mark indicates inability to predict next word")),style="color:black")),
                             span(HTML("<b>Note:</b> Due to limitation of resources and to reduce the computation time, some accuracy has been compromised"),style="color:red")
                     
        ),
        mainPanel(
            textInput("box1",h3("Type a sentence below: ")),
            span(h6("Note: Wait initially till screen displays \"Type Something....\""),style="color:red"),
            h3("THE PREDICTION IS:"),
            span(h1(textOutput("prediction"),style="color:purple"))
        )
            )
        ),
        tabPanel("BiGram",
        br(),
        h1("Most Frequently Occuring Bigrams."),
  
            mainPanel(
                img(src='2.png'),
            )

        
        ),
        tabPanel("TriGram",
                 br(),
                 h1("Most Frequently Occuring Trigrams."),
                 
                     mainPanel(
                         img(src='3.png'),  
                         
                 )
                 
        ),
        tabPanel("TetraGram",
                 br(),
                 h1("Most Frequently Occuring Tetragrams."),
                
                     mainPanel(
                         
                         img(src='4.png'),
                     )
                 
                 
        )  
    )
    )
    )
)

