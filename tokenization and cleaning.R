library(readr)
library(dtplyr)
library(stringr)
library(stringi)
library(quanteda)
library(tm)

news<-read_lines("en_US.news.txt")
blogs<-readLines("en_US.blogs.txt")
twit<-readLines("en_US.twitter.txt")

news<-sample(news,0.2*length(news))
blogs<-sample(blogs,0.2*length(blogs))
twit<-sample(twit,0.2*length(twit))


#remove url:
removeURL<-function(x) gsub("https?.*.com ",'',x)
#remove anything other than alphabets and spaces:
removenonalpha<-function(x) gsub("[^[:alpha:][:space:]]",'',x)


profanity<-readLines('badwords.txt')

news<-removeURL(news)
blogs<-removeURL(blogs)
twit<-removeURL(twit)

news<-removenonalpha(news)
blogs<-removenonalpha(blogs)
twit<-removenonalpha(twit)

news<-tolower(news)
blogs<-tolower(blogs)
twit<-tolower(twit)

news<-removeWords(news,profanity)
blogs<-removeWords(blogs,profanity)
twit<-removeWords(twit,profanity)

fewnews<-stripWhitespace(news)
fewblogs<-stripWhitespace(blogs)
fewtwit<-stripWhitespace(twit)

fewtext<-c(news,blogs,twit)
rm(fewnews,news,fewtwit,twit,fewblogs,blogs)

mycorpus<-corpus(fewtext)
rm(fewtext)

toks=tokens(mycorpus,concatenator=' ')

print(paste("corpus size:",object.size(mycorpus)/1024^2,'and token size:',object.size(toks)/1024^2))
rm(mycorpus)

save(toks,file='toks.rds')
