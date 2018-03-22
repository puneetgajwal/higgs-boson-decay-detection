#import training data
train <- read.csv(file.choose(), header = T)

#Sampling
ind <- sample(2, nrow(train), replace = T, prob = c(0.80, 0.2))
train_sample <- train[ind==1,-c(1,32)]
test_sample <- train[ind==2,-c(1,32)]

#Packages
install.packages("naivebayes")
library(naivebayes)
install.packages("dplyr")
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
install.packages("psych")
library(psych)

#naive Bayes: based on bayes theorum
model_naive <- naive_bayes(dtrain$Label~., data = dtrain)
model_naive

library(caret)
library(RCurl)
lab <- 'Label'
predictors <- names(dtrain)[names(dtrain) != lab]
dtrain$Label <- as.factor(dtrain$Label)
myControl <- trainControl(method='cv', number=3, returnResamp='none')
model_gbm <- train(dtrain[,predictors], dtrain[,lab],
                    method='gbm', trControl=myControl)
