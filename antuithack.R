# Reading the training data into R

mff_train <- read.csv("/home/Desktop/train.csv",header = T, stringsAsFactors = F)

# Creating a month variable by extracting month from date

library(lubridate)
mff_train$Month <- month(dmy(mff_train$Date))

# Creating a variable called "Popularity" which is a ratio of "Traffic" & "CompetitionDistance"

mff_train$Popularity <- ifelse(mff_train$CompetitionDistance == 0, 0, (mff_train$Traffic/mff_train$CompetitionDistance))
mff_train$Popularity <- as.numeric(as.character(mff_train$Popularity))

# Converting some of the integer variables to categorical/factor

mff_train$DayOfWeek <- as.factor(mff_train$DayOfWeek)
mff_train$Month <- as.factor(mff_train$Month)
mff_train[,5:9] <- as.data.frame(apply(mff_train[5:9], 2, as.factor))

# Creating the final dataset to be used for modeling

drop <- c("Restaurant", "Date")
mff_train_final <- mff_train[,!names(mff_train) %in% drop]

# Splitting the final dataset into training and evaluation sets

set.seed(123)
library(caret)
inTrain <- createDataPartition(y= mff_train_final$Sales, p= 0.7, list=F)
training <- mff_train_final[inTrain,]
testing <- mff_train_final[-inTrain,]

# Fitting a generalized linear model (Taking into account the interaction effects)

library(boot)
set.seed(123)
mff.glm <- glm(Sales~.-Popularity+Traffic:CompetitionDistance+Open_Close_ID:StateHoliday, training, family = gaussian)

# Evaluating the results of glm model

glm.predict <- predict(mff.glm, newdata = testing[,-11])
error.glm <-sqrt((sum((testing$Sales-glm.predict)^2))/(nrow(testing)-1))
                 
# Fitting a random forest model
                 
library(randomForest)
set.seed(123)
mff.rf <- randomForest(Sales~.-Popularity, data=training, ntree=500)
                 
# Evaluating the results of random forest model
                 
rf.predict <- predict(mff.rf, newdata = testing[,-11])
error.rf <- sqrt((sum((testing$Sales-rf.predict)^2))/(nrow(testing)-1))
                                  
# Fitting a support vector machine (svm) model
                                  
library(e1071)
set.seed(123)
mff.svm <- svm(Sales~.-Popularity, data=training)
                                  
# Evaluating the results of svm model
                                  
svm.predict <- predict(mff.svm, newdata=testing[,-11])
error.svm <- sqrt((sum((testing$Sales-svm.predict)^2))/(nrow(testing)-1))
                                                    
# Creating an ensemble model of random forest and svm and evaluating the model
                                                    
final.predict <- (svm.predict*2 + rf.predict)/3
error.final <- sqrt((sum((testing$Sales-final.predict)^2))/(nrow(testing)-1))
                                                                        
# Reading the test data into R

mff_test <- read.csv("/home/Desktop/test.csv",header = T, stringsAsFactors = F)

# Performing data transformations on mff_test to arrive at the final test dataset

mff_test$Month <- month(dmy(mff_test$Date))
mff_test$DayOfWeek <- as.factor(mff_test$DayOfWeek)
mff_test$Month <- as.factor(mff_test$Month)
mff_test[,5:9] <- as.data.frame(apply(mff_test[5:9], 2, as.factor))
mff_test_final <- mff_test[,!names(mff_test) %in% drop]

# Predicting on test data

predict_test_rf <- predict(mff.rf, newdata = mff_test_final)
predict_test_svm <- predict(mff.svm, newdata = mff_test_final)
predict_final <- (predict_test_svm*2 + predict_test_rf)/3

# Final data for submission

mff_test <- cbind(mff_test, predict_final)
final_submission <- mff_test[,c(1,12)]                                                                     
                                                                        