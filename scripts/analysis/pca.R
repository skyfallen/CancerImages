library(caret)
library(ggplot2)
#dataset<-read.table("data/labels/workingMatrix.csv", header = TRUE)
dim(dataset)
dataset_pcomp <-  prcomp(dataset[,-ncol(dataset)], center = TRUE, scale. = TRUE)
summary(dataset_pcomp)
#Extract Pc matrix
pcmatrix <- data.frame(dataset_pcomp$x)[,1:100]
pcmatrix$Label <- dataset$Label
head(pcmatrix)
cbPalette <- c( "#45FF2A",
                "#E8A90C",
                "#FF0000",
                "#210CE8",
                "#0DFFAF")
ggplot(pcmatrix, aes(x = PC1, y = PC2, colour = as.factor(Label))) + 
        geom_text(aes(label = Label), size = 7, check_overlap = TRUE) +
        theme_bw(base_size = 18) + 
        labs(x = 'PC1', y = 'PC2') + 
        scale_colour_manual(values=cbPalette, name="") + 
        guides(colour = FALSE) + 
        theme(
                legend.position = c(1, 0),
                legend.direction = "vertical",
                legend.justification = c(1, 0)
        )+stat_ellipse()
# # Add labels
# pcmatrix$Severity <- metadata$Severity
# # Plotting
# ggplot(pcmatrix, aes(x = PC1, y = PC2, colour = Lables)) + 
#   geom_text(aes(label = Severity), size = 7, check_overlap = TRUE) +
#   theme_bw(base_size = 18) + 
#   labs(x = 'PC1', y = 'PC2') + 
#   scale_colour_manual(values=cbPalette, name="") + 
#   guides(colour = FALSE) + 
#   theme(
#     legend.position = c(1, 0),
#     legend.direction = "vertical",
#     legend.justification = c(1, 0)
#   )
set.seed(998)
inTraining <- createDataPartition(pcmatrix$Label, p = .7, list = FALSE)
training <- pcmatrix[inTraining,]
testing <- pcmatrix[-inTraining,]
fitControl <- trainControl(## 7-fold CV
        method = "repeatedcv",
        number = 7,
        repeats = 10,
        classProbs = TRUE,
        savePredictions = T)
#fitControl <- trainControl(## 10-fold CV
# method = "repeatedcv",
#  number = 10,
#  repeats = 15,
#  classProbs = TRUE,
#  savePredictions = T,
#  summaryFunction = twoClassSummary)
set.seed(825)
training$Label <- make.names(training$Label)
rfFit <- train(Label ~ ., data = training,
               method = "rf",
               trControl = fitControl,
               metric = "Accuracy",
               verbose = TRUE
)
CM_rf<-confusionMatrix( data = rfFit$pred[,1], reference = rfFit$pred[,2])
# Predicting testing data with our model
predictions <- predict(rfFit, newdata = testing)
# Casting predictions from character to factor for comparison
levels(predictions) <- c(0,1)
# Comparing to the ground truth
sum(predictions == testing$labels)/nrow(testing)
#Visualising trained model
trellis.par.set(caretTheme())
plot(rfFit)