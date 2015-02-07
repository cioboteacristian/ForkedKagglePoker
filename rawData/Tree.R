# setwd("~/git/GTMachineLearning_Assignment_1/rawData")
# train <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/poker/poker-hand-training-true.data",
#                         header=FALSE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
# summary(train)
# head(train)
# 
# test <- read.table("http://archive.ics.uci.edu/ml/machine-learning-databases/poker/poker-hand-testing.data",
#                     header=FALSE, sep=",", na.strings="NA", dec=".", strip.white=TRUE)
# summary(test)
# head(test)
# 
# dim(train)
# dim(test)
# 
# # add header
# names(test) <- c("C1","S1","C2","S2","C3","S3","C4","S4","C5","S5","CLASS")
# names(train) <- c("C1","S1","C2","S2","C3","S3","C4","S4","C5","S5","CLASS")
# 
# 
# 
# head(test)
# head(train)
# 
# write.csv(test, file = "test.csv")
# write.csv(train, file = "train.csv")

setwd("~/git/GTMachineLearning_Assignment_1/rawData")
train = read.csv("train.csv")
test = read.csv("test.csv")


test = test[,2:12]
train = train[,2:12]

#Separate labels from training set
trainlabels = as.factor(train$CLASS)
train = train[,1:10]
testlabels = as.factor(test$CLASS)
test = test[,1:10]

#Split training set into partial training set and validation set
part_train = train[1:18000,]
valid = train[-1:-18000,]
labels_part = trainlabels[1:18000]
valid_labels = trainlabels[-1:-18000]

# descion tree 
library(rpart)
set.seed(12)
mycontrol = rpart.control(minsplit=3, minbucket=1, cp=0.001)
tree = rpart(labels_part~.,method="class", data=part_train,control = mycontrol)

plotcp(tree) 
library(rattle)
library(rpart.plot)
library(RColorBrewer)
fancyRpartPlot(tree)


#ptree <- prune(tree,cp=tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"])
pfit<- prune(tree, cp=0.0022)
plotcp(pfit) 
fancyRpartPlot(pfit)

tree_pred = predict(pfit, newdata=valid, type="class")
confusionMatrix(tree_pred,valid_labels)

tree_pred = predict(pfit, newdata=valid, type="class")
confusionMatrix(tree_pred,valid_labels)

pred = predict(pfit, newdata=test, type="class")
confusionMatrix(pred,testlabels)







