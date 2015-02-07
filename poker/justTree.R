#http://www.kaggle.com/c/poker-rule-induction/data
setwd("~/class/GTMachineLearning_Assignment_1/poker")
#setwd("~/git/GTMachineLearning_Assignment_1/poker")
train = read.csv("train.csv")
test = read.csv("test.csv")
sub =  read.csv("sub.csv")
#Get rid of ID column
test = test[,2:11]
dim(test)

#Separate labels from training set
labels = as.factor(train$hand)
train = train[,1:10]

#Split training set into partial training set and validation set
part_train = train[1:18000,]
valid = train[-1:-18000,]

labels_part = labels[1:18000]
valid_labels = labels[-1:-18000]

head(sub)

head(sub$hand)
test_labels = as.factor(sub$hand)
# descion tree 
library(rpart)
mycontrol = rpart.control(cp = 0.1, xval = 20)
fit = rpart(labels_part~.,method="class", data=part_train,control = mycontrol)

#fit$cptable

#printcp(fit) # display the results
#plotcp(fit) # visualize cross-validation results
#summary(fit) # detailed summary of splits

ptree <- prune(fit,cp=fit$cptable[which.min(fit$cptable[,"xerror"]),"CP"])
#plotcp(ptree) # visualize cross-validation results

library(rattle)
library(rpart.plot)
library(RColorBrewer)
#fancyRpartPlot(ptree)

prediction <- predict(ptree, valid, type = "class")
#summary(prediction)
confusionMatrix(prediction,valid_labels)
valid_labels
test_labels
tree_pred = predict(ptree, newdata=test, type="class")
confusionMatrix(tree_pred,test_labels)


summary(tree_pred)