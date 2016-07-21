#source("https://bioconductor.org/biocLite.R")
#biocLite("EBImage")
#install.packages("installr")
#source("https://bioconductor.org/biocLite.R")
#biocLite("BiocGenerics")

library(installr)
library(EBImage)
library(imager)
library(BiocGenerics)

## read info_scorings.csv, detect null in positive_tumor_cells###
mydata <- read.table("data/labels/info_scorings.csv", sep=";", header = TRUE,
                     na.strings = 'null')
levels(mydata)
# summary(mydata)
picture <- mydata[is.na(mydata$positive_tumor_cells),]$pic
length(picture)

## delete pictures with names stored in vector "picture"
setwd("data/images/resized512")

for (i in picture){
        #i
        file.remove(i)
}

setwd("../../..")

