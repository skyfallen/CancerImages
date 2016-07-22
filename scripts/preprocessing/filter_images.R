source("https://bioconductor.org/biocLite.R")
biocLite("EBImage")
install.packages("installr")
source("https://bioconductor.org/biocLite.R")
biocLite("BiocGenerics")

#library(installr)
library(EBImage)
#library(imager)
library(BiocGenerics)

## read info_scorings.csv, detect null in positive_tumor_cells###
mydata <- read.table("data/labels/info_scorings.csv", sep=";", header = TRUE,
                     na.strings = 'null')
levels(mydata)

# summary(mydata)
picture <- mydata[is.na(mydata$positive_tumor_cells),]$pic
length(picture)
good_pics<-mydata[!mydata$pic%in%picture,]
## delete pictures with names stored in vector "picture"
setwd("data/images/resize256")
all_files <- list.files(path = "data/images/resize256", 
           pattern = "^[0-9, _]*\\.jpg$")

mydata_files<-mydata$pic

selected_files<- all_files[!all_files%in%mydata_files]
setwd("data/images/resize256")

# This code removes files for which no doctor analysis is presented
for (i in picture){
        #i
        file.remove(i)
}

# This code removes all files that are odd - no info about them in the data at all
for (i in 1:length(selected_files)){
        #i
        f<-selected_files[i]
        file.remove(f)
        print(f)
}

setwd("../../..")

