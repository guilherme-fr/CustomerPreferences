

prepareSurveyData <- function(survey, forTraining) {
  ####Converting numeric to factors####
  survey$elevel <- factor(survey$elevel, 
                          levels = unique(sort(survey$elevel)), 
                          labels = c("Less than High School", "High School", "Some College", "College Degree", 
                                     "Masters Phd"))
  
  survey$car <- factor(survey$car, 
                       levels = unique(sort(survey$car)), 
                       labels = c("BMW", "Buick", "Cadillac", "Chevrolet", "Chrysler", "Dodge", "Ford", "Honda", 
                                  "Hyundai", "Jeep", "Kia", "Lincoln", "Mazda", "Mercedes Benz", "Mitsubishi", 
                                  "Nissan", "Ram", "Subary", "Toyota", "None"))
  
  survey$zipcode <- factor(survey$zipcode, 
                           levels = unique(sort(survey$zipcode)), 
                           labels = c("New England", "Mid-Atlantic", "East North Central", "West North Central", 
                                      "South Atlantic", "East South Central", "West South Central", "Mountain", 
                                      "Pacific"))
  if (forTraining) {
    survey$brand <- factor(survey$brand, 
                           levels = unique(sort(survey$brand)), 
                           labels = c("Acer", "Sony"))
  }
  survey
}

