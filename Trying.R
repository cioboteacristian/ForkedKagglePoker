setwd("~/git/GTMachineLearning_Assignment_1/poker")
train <- read.csv("train.csv")
head(train)
#labels = as.factor(train$hand)
#train = train[,1:10]
#head(train)
library(rpart)
CART.fit <- rpart(hand ~., data=train, 
                  control=rpart.control(minsplit=2, minbucket=1, cp=0.001))

summary(CART.fit)
plot(CART.fit)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(CART.fit)
plotcp(CART.fit)

ptree <- prune(CART.fit,cp=CART.fit$cptable[which.min(CART.fit$cptable[,"xerror"]),"CP"])
plotcp(ptree)
fancyRpartPlot(ptree)

#install.packages("tree")
library(tree)
library(ISLR)
trees <- tree(hand ~., train)
plot(trees)