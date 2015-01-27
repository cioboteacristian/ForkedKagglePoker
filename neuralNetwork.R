#setwd("~/git/GTMachineLearning_Assignment_1")
setwd("~/class/GTMachineLearning_Assignment_1")

train <- read.csv("train.csv")
test <- read.csv("test.csv")
#make hour a separate variable

train$hour <- hour(train$datetime)

test$hour <- hour(test$datetime)

#make day a separate variable

train$day <- wday(train$datetime)

test$day <- wday(test$datetime)

#make year a separate variable

train$year <- year(train$datetime)

test$year <- year(test$datetime)

#write code to look for weather 4

train$weather[train$weather == 4]

test$weather[test$weather == 4]

train$weather[train$weather==4] <- 3

test$weather[test$weather==4] <- 3

train$season <- as.factor(train$season)

test$season <- as.factor(test$season)

train$workingday <- as.factor(train$workingday)

test$workingday <- as.factor(test$workingday)

train$weather <- as.factor(train$weather)

test$weather <- as.factor(test$weather)

train$year <- as.factor(train$year)

test$year <- as.factor(test$year)

train$day <- as.factor(train$day)

test$day <- as.factor(test$day)

train$hour <- as.factor(train$hour)

test$hour <- as.factor(test$hour)

trainmat <- model.matrix(count~season+workingday+weather+year+hour+day,data=train)

testmat <- model.matrix(~season+workingday+weather+year+hour+day,data=test)

trainmat <- as.data.frame(trainmat)

testmat <- as.data.frame(testmat)



count <- train$count/1000

#add count to trainmat

trainmat <- cbind(trainmat,count)

#Write formula

formula <- count ~ season2+season3+season4+workingday1+weather2+weather3+year2012+hour1+hour2+hour3+hour4+hour5+hour6+hour7+hour8+hour9+hour10+hour11+hour12+hour13+hour14+hour15+hour16+hour17+hour18+hour19+hour20+hour21+hour22+hour23+day2+day3+day4+day5+day6+day7

#train your data.  note that this is a neural network with 5 hidden layers of 7, 8, 9, 8, and 7 respectively.

fit <- neuralnet(formula,data=trainmat,hidden=c(7,8,9,8,7),threshold=.04,stepmax=1e+06,learningrate=.001,algorithm="rprop+",lifesign="full",likelihood=T)
fit


#install.packages("lubridate")
#install.packages("neuralnet")
library(lubridate)

library(neuralnet)

trainmat <- model.matrix(count~season+workingday+weather+year+hour+day,data=train)

net <- neuralnet(formula,train_factor, hidden=10, threshold=0.01)
