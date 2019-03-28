

surveyCompleteLocation <- "datasets/CompleteResponses.csv"

####Loading data into memory####
survey <- read.csv(surveyCompleteLocation)

####Pre-processing####
survey <- prepareSurveyData(survey, TRUE)

#sampling to the train process runs faster
featureSelset <- createTrainAndTestSets(survey, survey$brand, 0.5, 123)
#Creating the train and test set from the sample
featureSelset <- createTrainAndTestSets(featureSelset$training, featureSelset$training$brand, 0.75, 123)

rfGrid <- expand.grid(mtry=c(1,2,3,4,5))

# featureSelModel <- trainModel(featureSelset$training, brand~ salary + age + credit, "rf", tuneGrid = rfGrid)
featureSelModel <- trainModel(featureSelset$training, brand~ salary + age + car, "C5.0", tuneLength = 2)

predictedTest <- predict(featureSelModel, featureSelset$testing)
assessModel <- postResample(predictedTest, featureSelset$testing$brand)
print(assessModel)
