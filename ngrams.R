library(quanteda)
library(data.table)
library(readr)
library(dtplyr)
library(stringr)
library(stringi)

rm(list=ls())

load('toks.rds')


bigram<-tokens_ngrams(toks,n=2,concatenator = ' ')
bitokdf<-data.table(token=unname(unlist(bigram)),freq=1)
bidf<-bitokdf[,.(freq=sum(freq)),keyby=token]
rm(bitokdf)
bitokens<-strsplit(bidf$token,' ')
bidf
#############try replacing by sapply
bidf$base<-str_trim(sapply(bitokens,function(x){x[1]}))
bidf$prediction<-str_trim(sapply(bitokens,function(x){x[2]}))
setorder(bidf,base,-freq)
#load("bidf.rds")
bidf<-subset(bidf,select=-token)
#take only grams with 50% coverage
bidf<-mutate(bidf,prop=freq/sum(freq))%>%arrange(desc(prop))%>%mutate(coverage=cumsum(prop))%>%filter(coverage<=0.5)
bidf<-bidf[,c('base','prediction')]
saveRDS(bidf,file="bidf.rds")
rm(bidf)

trigram<-tokens_ngrams(toks,n=3,concatenator = ' ')
tritokdf<-data.table(token=unname(unlist(trigram)),freq=1)
rm(trigram)
tridf<-tritokdf[,.(freq=sum(freq)),keyby=token]
rm(tritokdf)
tritokens<-strsplit(tridf$token,' ')
tridf$base<-str_trim(sapply(tritokens,function(x){paste(x[1],x[2])}))
tridf$prediction<-str_trim(sapply(tritokens,function(x){x[3]}))
#load("tridf.rds")
setorder(tridf,base,-freq)
tridf<-subset(tridf,select=-token)
tridf<-mutate(tridf,prop=freq/sum(freq))%>%arrange(desc(prop))%>%mutate(coverage=cumsum(prop))%>%filter(coverage<=0.5)
tridf<-tridf[,c('base','prediction')]
saveRDS(tridf,file="tridf.rds")
rm(tridf)

tetragram<-tokens_ngrams(toks,n=4,concatenator = ' ')
tetratokdf<-data.table(token=unname(unlist(tetragram)),freq=1)
rm(tetragram)
tetradf<-tetratokdf[,.(freq=sum(freq)),keyby=token]
rm(tetratokdf)
tetratokens<-strsplit(tetradf$token,' ')
tetradf$base<-str_trim(sapply(tetratokens,function(x){paste(x[1],x[2],x[3])}))
tetradf$prediction<-str_trim(sapply(tetratokens,function(x){x[4]}))
load("tetradf.rds")
tetradf<-subset(tetradf,select=-token)
setorder(tetradf,base,-freq)
tetradf<-mutate(tetradf,prop=freq/sum(freq))%>%arrange(desc(prop))%>%mutate(coverage=cumsum(prop))%>%filter(coverage<=0.5)
tetradf<-tetradf[,c('base','prediction')]
saveRDS(tetradf,file="tetradf.rds")
rm(tetradf)


pentagram<-tokens_ngrams(toks,n=5,concatenator = ' ')
pentatokdf<-data.table(token=unname(unlist(pentagram)),freq=1)
rm(pentagram)
rm(toks)
pentadf<-pentatokdf[,.(freq=sum(freq)),keyby=token]
rm(pentatokdf)
pentatokens<-strsplit(pentadf$token,' ')
pentadf$base<-str_trim(sapply(pentatokens,function(x){paste(x[1],x[2],x[3],x[4])}))
pentadf$prediction<-str_trim(sapply(pentatokens,function(x){x[5]}))
rm(pentatokens)
#load("pentadf.rds")
pentadf=subset(pentadf,select=-token)
setorder(pentadf,base,-freq)
pentadf<-mutate(pentadf,prop=freq/sum(freq))%>%arrange(desc(prop))%>%mutate(coverage=cumsum(prop))%>%filter(coverage<=0.5)
pentadf<-pentadf[,c('base','prediction')]
saveRDS(pentadf,file="pentadf.rds")
rm(pentadf)

