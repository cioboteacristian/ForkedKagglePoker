#http://www.kaggle.com/c/poker-rule-induction/data

setwd("~/git/GTMachineLearning_Assignment_1/poker")
train = read.csv("train.csv")
test = read.csv("test.csv")
#Get rid of ID column
test = test[,2:11]

#Separate labels from training set
labels = as.factor(train$hand)
train = train[,1:10]

#Split training set into partial training set and validation set
part_train = train[1:18000,]
valid = train[-1:-18000,]

labels_part = labels[1:18000]
valid_labels = labels[-1:-18000]


library(caret)
library(randomForest)
library(gbm)
options( java.parameters = "-Xmx3g" )
library(extraTrees)

set.seed(12)
tree = randomForest(labels_part~., data=part_train, nodesize=1, ntree=500, mtry=4)

tree_pred = predict(tree, newdata=valid, type="class")

confusionMatrix(tree_pred,valid_labels)

library(rpart)
fit = rpart(labels_part~.,method="class", data=part_train)

printcp(fit) # display the results
plotcp(fit) # visualize cross-validation results
summary(fit) # detailed summary of splits

library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(tree_pred)
