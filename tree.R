setwd("~/git/GTMachineLearning_Assignment_1")
#https://www.kaggle.com/c/bike-sharing-demand/data?test.csv
#http://brandonharris.io/kaggle-bike-sharing/
#read in train/test
train <- read.csv("train.csv")
test <- read.csv("test.csv")

str(train)

#factorize training set
train_factor <- train
train_factor$weather <- factor(train$weather)
train_factor$holiday <- factor(train$holiday)
train_factor$workingday <- factor(train$workingday)
train_factor$season <- factor(train$season)

#factorize test set
test_factor <- test
test_factor$weather <- factor(test$weather)
test_factor$holiday <- factor(test$holiday)
test_factor$workingday <- factor(test$workingday)
test_factor$season <- factor(test$season)

#create time column by stripping out timestamp
train_factor$time <- substring(train$datetime,12,20)
test_factor$time <- substring(test$datetime,12,20)

#factorize new timestamp column
train_factor$time <- factor(train_factor$time)
test_factor$time <- factor(test_factor$time)


#create day of week column
train_factor$day <- weekdays(as.Date(train_factor$datetime))
train_factor$day <- as.factor(train_factor$day)
test_factor$day <- weekdays(as.Date(test_factor$datetime))
test_factor$day <- as.factor(test_factor$day)

aggregate(train_factor[,"count"],list(train_factor$day),mean)


#create Sunday variable
train_factor$sunday[train_factor$day == "Sunday"] <- "1"
train_factor$sunday[train_factor$day != "1"] <- "0"

test_factor$sunday[test_factor$day == "Sunday"] <- "1"
test_factor$sunday[test_factor$day != "1"] <- "0"

#convert to factor
train_factor$sunday <- as.factor(train_factor$sunday)
test_factor$sunday <- as.factor(test_factor$sunday)


#convert time and create $hour as integer to evaluate for daypart
train_factor$hour<- as.numeric(substr(train_factor$time,1,2))
test_factor$hour<- as.numeric(substr(test_factor$time,1,2))

#create daypart column, default to 4 to make things easier for ourselves
train_factor$daypart <- "4"
test_factor$daypart <- "4"


#4AM - 10AM = 1
train_factor$daypart[(train_factor$hour < 10) & (train_factor$hour > 3)] <- 1
test_factor$daypart[(test_factor$hour < 10) & (test_factor$hour > 3)] <- 1


#11AM - 3PM = 2
train_factor$daypart[(train_factor$hour < 16) & (train_factor$hour > 9)] <- 2
test_factor$daypart[(test_factor$hour < 16) & (test_factor$hour > 9)] <- 2


#4PM - 9PM = 3
train_factor$daypart[(train_factor$hour < 22) & (train_factor$hour > 15)] <- 3
test_factor$daypart[(test_factor$hour < 22) & (test_factor$hour > 15)] <- 3

#convert daypart to factor
train_factor$daypart <- as.factor(train_factor$daypart)
test_factor$daypart <- as.factor(test_factor$daypart)

#convert hour back to factor
train_factor$hour <- as.factor(train_factor$hour)
test_factor$hour <- as.factor(test_factor$hour)


#install.packages('party')
library('party')

formula <- count ~ season + holiday + workingday + weather + temp + atemp + humidity + hour + daypart + sunday

#fit.ctree <- ctree(formula, data=train_factor)
#fit.ctree
#plot(fit.ctree)

library(rpart)
fit = rpart(formula,method="anova", data=train_factor)

printcp(fit) # display the results
plotcp(fit) # visualize cross-validation results
summary(fit) # detailed summary of splits
importance(fit)
#install.packages('rattle')
#install.packages('rpart.plot')
#install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(fit)
rsq.rpart(fit)
# prune the tree 
pfit<- prune(fit, cp=   fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
pred <- predict(fit, test_factor)
table(pred)
library(caret)  
# confusionMatrix(pred, test_factor.count)
