library(dplyr)
library(stringr)
library(tm)
#prediction
bidf<-readRDS("bidf.rds")
tridf<-readRDS("tridf.rds")
tetradf<-readRDS("tetradf.rds")
#pentadf<-readRDS("pentadf.rds")





removelastword<-function(sent){
  return(paste(unlist(str_split(sent," "))[-1],collapse=' '))
}


bigram <- function(words){

  out<-as.character(filter(bidf,base==words)$prediction[1])
  ifelse(is.na(out), "?", return(out))
  
}




trigram <- function(words){
  
  
  out<-as.character(filter(tridf,base==words)$prediction[1])
  
  ifelse(is.na(out), bigram(removelastword(words)), return(out))
  
}



tetragram <- function(words){
  words<-paste(tail(unlist(str_split(words," ")),3),collapse=" ")
  out<-as.character(filter(tetradf,base==words)$prediction[1])
  
  ifelse(is.na(out), trigram(removelastword(words)), return(out))
  
}

# pentagram<-function(words){
#   words<-paste(tail(unlist(str_split(words," ")),4),collapse=" ")
# 
#   out<-as.character(filter(pentadf,base==words)$prediction[1])
# 
#   ifelse(is.na(out),tetragram(removelastword(words)), return(out))
# }



ngrams <- function(input){
  #remove url
  removeURL<-function(x) gsub("https?.*.com ",'',x)
  #remove anything other than alphabets and spaces:
  removenonalpha<-function(x) gsub("[^[:alpha:][:space:]]",'',x)
  
  
  input<-removenonalpha(input)
  input<-removeURL(input)
  input<-stripWhitespace(input)
  input<-trimws(input,which="both")
  count<-str_count(input,boundary("word"))
  words <- tolower(input)
  
  
  out <- ifelse(count==0,"Type Something .....",
                ifelse(count == 1, bigram(words), 
                ifelse (count == 2, trigram(words), 
                         tetragram(words))))
                        
  
  
  return(out)
  
}

