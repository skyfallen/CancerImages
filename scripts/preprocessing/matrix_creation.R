#START
source("http://bioconductor.org/biocLite.R")
biocLite("EBImage")
library(EBImage)

setwd("data/images/resized512") #directory with images
n <- 694 #number of images

mat_img <- matrix(data = 0, nrow = n, ncol = (512*512+1), dimnames = NULL) #creation of the matrix 

inc <- 1                                                                            #Creation! Fuck yeah, WE R GODs!
for (name_i in list.files(pattern = "^[0-9, _]*\\.jpg$")){ #just use someee regular expressions ;)
  x <-  readImage(name_i)
  x_gray <- channel(x, "gray")
  for(j in 1:(512*512)){
    mat_img[inc, j] <- x[j]
  }
  inc <- inc+1
}

#now weve got a matrix of images mat_img


