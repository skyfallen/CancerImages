##function for classifying labels
classifying <- function(x){
  if (x=="0%" | x==">0% and <1%") return(1)
  if (x==">0% and <5%" | x=="1-9%") return(1)
  if (x=="5-15%" | x=="10-39%" | x=="16-30%") return(2)
  if (x==">30%" | x=="40-69%") return(3)
  if (x=="70-100%") return(4)
}

mydata<-read.table("data/labels/info_scorings.csv", sep=";", header = TRUE,
                            na.strings = 'null')

new<- mydata[!is.na(mydata$positive_tumor_cells),c("positive_tumor_cells","pic")]

##apply clasifying to our "positive_tumor_cells" labels
a<- c()
for(i in 1:length(new$positive_tumor_cells)){
  value <- classifying(new$positive_tumor_cells[i])
  a <- c(a,value)
}
##add column for new labels
new$newLabel <- a
##write new table with 3 columns: "positive_tumor_cells", "pic", "newLabel" 
write.table(new, file="data/labels/info_scorings_filtered.csv" )


