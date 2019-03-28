
modelFile = "rf.rda"
# modelFile = "C5.0.rda"
incompleteSurveyFile = "datasets/SurveyIncomplete.csv"
predictedSurveyFile = "datasets/SurveyPredicted.csv"
surveyCompleteFile <- "datasets/CompleteResponses.csv"

evaluateModel = TRUE

if (file.exists(modelFile)) {
  load(modelFile)
  print(paste("Model '", modelFile,"' loaded", sep = ""))
  
  if (evaluateModel) {
    #Code for just evaluate the model saved
    
    survey <- read.csv(surveyCompleteFile)
    #Pre-processing
    survey <- prepareSurveyData(survey, TRUE)
    
    #Splitting in training and testing sets
    list <- createTrainAndTestSets(survey, survey$brand, 0.75, 123)
    
    predictedTest <- predict(model, list$testing)
    assessModel <- postResample(predictedTest, list$testing$brand)
    print("Model test metrics:")
    print(assessModel)
  } else {
    #Code to make the predictiions on the incomplete survey
    
    incompSurvey <- read.csv(incompleteSurveyFile)
    incompSurvey <- prepareSurveyData(incompSurvey, FALSE)
    predictedValues <- predict(model, incompSurvey)
    print("Prediction finished")
    
    surveyPredicted <- incompSurvey
    surveyPredicted$brand <- predictedValues
    write.csv(surveyPredicted, predictedSurveyFile)
    print( paste("Prediction saved to file '", predictedSurveyFile, "'", sep = "") )
  }
  
} else {
  print( paste("ERROR: It's not possible to load model. The file '", modelFile, "' does not exist", sep = "") )
}
