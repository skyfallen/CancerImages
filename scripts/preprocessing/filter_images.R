#source("https://bioconductor.org/biocLite.R")
#biocLite("EBImage")
#install.packages("installr")
#source("https://bioconductor.org/biocLite.R")
#biocLite("BiocGenerics")
library(installr)
library(EBImage)
library(imager)
library(BiocGenerics)


f<- ("C:/Users/Solomiia/OneDrive/Documents/Project_Bioinformatics/
     exampledata/im_017.png")
img<-readImage(f)
EBImage::display(img, method= "raster")
imageData(img)

## read info_scorings.csv, detect null in positive_tumor_cells###
mydata <- read.table("info_scorings.csv", sep=";", header = TRUE,
                     na.strings = 'null')
summary(mydata)
picture<-mydata[is.na(mydata$positive_tumor_cells),]$pic
length(picture)
## delete pictures with names stored in vector "picture"
setwd(dir = "data/resize256/")
for (i in picture){
  i
  file.remove(i)
}
## which pictures are labeled as ">30%" ## 
morethen30<-which(mydata$positive_tumor_cells==">30%")

mydata30 <- mydata[morethen30,]$pic

for (i in mydata30[1:length(mydata30)]){  
  # EBImage::display( readImage(i), method= "raster")
  write(readImage(i), file="more30")
}

# Let's delete lines that have NAs in the column positive_tumor_cells
mydata <- mydata[!is.na(mydata$positive_tumor_cells),]
head(mydata)

# Let's take the column "positive_tumor_cells"
levels(mydata$positive_tumor_cells)
table(mydata$positive_tumor_cells)

setwd("C:/Users/Solomiia/Desktop/Project_Bioinformatics")

#mydata <- mydata[-toBeRemoved,]


# Detecting the size. It should be not less than ~15 Kb
files <- list.files("data/resize256", include.dirs=TRUE, full.names = TRUE)

files
summary(files)


new_vec<-c()
for (i in (1:length(files))){
  print(files[i])
  file.size(files[i])
  if (file.size(files[i]) < 15000) {
    print(file.size(files[i]))
    new_vec <- c(new_vec,files[i])
    file.size(files[i])
  }
}
length(new_vec)
new_vec

for (i in (1:length(new_vec))){
  file.remove(new_vec[i])
}


