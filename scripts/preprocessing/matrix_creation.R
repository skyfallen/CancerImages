library(EBImage)
library(caret)
dataset <- c()
dataset <- t(sapply(list.files(path = "data/images/resize256", 
                               pattern = "^[0-9, _]*\\.jpg$", full.names = TRUE), function(file){ #just use someee regular expressions ;)
                                       message(file)
                                       x <-  readImage(file)
                                       x_gray <- channel(x, "gray")
                                       return(as.vector(t(as.array(x_gray))))
                               }))
rownames(dataset) = sub('.*/', '', rownames(dataset))
dataset = as.data.frame(dataset)
matching<-read.table("data/labels/info_scorings_filtered.csv", header = TRUE)
dataset$Label = matching$newLabel[which(matching$pic %in% rownames(dataset))]
nearZeroVar(dataset)
dataset <- dataset[,-nearZeroVar(dataset)]
write.table(dataset, file="data/labels/workingMatrix.csv" )
#saveRDS(object = dataset, file = 'data/labels/workingMatrix.RDS')
# The way to load RDS file
# dataset = loadRDS('data/labels/workingMatrix.RDS')