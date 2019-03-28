

surveyCompleteLocation <- "datasets/CompleteResponses.csv"
classifierName = "C5.0"
# classifierName = "rf"

####Loading data into memory####
survey <- read.csv(surveyCompleteLocation)

#Pre-processing
survey <- prepareSurveyData(survey, TRUE)

#Splitting in training and testing sets
list <- createTrainAndTestSets(survey, survey$brand, 0.75, 123)

if (classifierName == "C5.0") {
  print("Training C5.0 model...")
  
  #Training C5.0 model
  model <- trainModel(list$training, brand~ salary + age + car, "C5.0", 2)
  
  print("Training finished!")
} else if (classifierName == "rf") {
  print("Training Random Forest model...")
  
  #Training Random Forest model
  rfGrid <- expand.grid(mtry=c(1,2,3,4,5))
  model <- trainModel(list$training, brand~ salary + age + credit, "rf", tuneGrid = rfGrid)
  
  print("Training finished!")
}

#saving model to file
save(model, file = paste(classifierName, ".rda", sep = "") )
print( paste("Model saved to file '", classifierName, ".rda'", sep = ""))

predictedTest <- predict(model, list$testing)
assessModel <- postResample(predictedTest, list$testing$brand)
print("Model test metrics:")
print(assessModel)