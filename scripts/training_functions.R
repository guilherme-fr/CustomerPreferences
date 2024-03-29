library(C50)
library(caret)

createTrainAndTestSets <- function(data, labelColumn, trainPercent, seed) {
  set.seed(seed)
  
  ####Splitting the data into training and testing sets####
  indexTraining <- createDataPartition(labelColumn, p = trainPercent, list = FALSE)
  trainingSet <- data[indexTraining, ]
  testingSet <- data[-indexTraining, ]
  
  list(training = trainingSet, testing = testingSet)
}

trainModel <- function(trainingData, formula, modelName, tuneLength = NULL, tuneGrid = NULL) {
  ####Defining configuration for training####
  fitControl <- trainControl(method = "repeatedcv", number = 10, repeats = 1)
  
  #training
  modelFit <- train(formula, data = trainingData, method = modelName, trControl = fitControl, 
                           tuneLength = tuneLength, tuneGrid = tuneGrid)
  
  modelFit
}