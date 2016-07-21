#START
#source("http://bioconductor.org/biocLite.R")
#biocLite("EBImage")
library(EBImage)

setwd("data/images/resize256") #directory with images

dataset <- c()

dataset <- t(sapply(list.files(pattern = "^[0-9, _]*\\.jpg$"), function(file){ #just use someee regular expressions ;)
  message(file)
  x <-  readImage(file)
  x_gray <- channel(x, "gray")
  return(as.vector(t(as.array(x_gray))))
}))

setwd("../../..")



