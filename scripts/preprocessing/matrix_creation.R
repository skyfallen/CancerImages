#START
#source("http://bioconductor.org/biocLite.R")
#biocLite("EBImage")
library(EBImage)

setwd("data/images/resized512") #directory with images
n <- 0
for (name_i in list.files(pattern = "^[0-9, _]*\\.jpg$")){
  n <- n+1
}

mat_img <- matrix(data = 0, nrow = n, ncol = (512*512+1), dimnames = NULL) #creation of the matrix 

# init dataset
dataset <- c()


dataset <- t(sapply(list.files(pattern = "^[0-9, _]*\\.jpg$"), function(file){ #just use someee regular expressions ;)
  message(file)
  x <-  readImage(file)
  x_gray <- channel(x, "gray")
  return(as.vector(t(as.array(x_gray))))
}))


dataset <- t(sapply(list.files(pattern = "^[0-9, _]*\\.jpg$"), function(file){ #just use someee regular expressions ;)
  message(file)
  x <-  readImage(file)
  x_gray <- channel(x, "gray")
  return(as.vector(t(as.array(x_gray))))
}))


setwd("../../..")



