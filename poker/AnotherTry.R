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
cat("\014") 
setwd("~/git/GTMachineLearning_Assignment_1/rawData")
train = read.csv("train.csv")
test = read.csv("test.csv")


test = test[,2:12]
train = train[,2:12]

head(train)
#http://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Classification/SVM
#install.packages("e1071")
library(e1071)
#svm.model <- svm(CLASS ~ ., data = train, cost = 100, gamma = 1)
svm.model2 <- svm(CLASS ~ ., train, type="C-classification", kernel="linear", cost=1)
summary(svm.model2)

head(test[,-11])

svm.pred <- predict(svm.model2, test[,-11])

summary(svm.pred )

table(pred = svm.pred, true = test[,11])



head(train[,1:10])
head(train[,11:11])

library(kernlab)
svm <- ksvm(train[,11:11] ~ ., data = train[,1:10],type = "C-svc")
print(svm)
summary(svm)

plot(svm,data=train[,1:10])
library(caret)
x <- predict(svm, test[,1:10])
table(pred = x, true = test[,1:10])



summary(x)



#head(test[,1:10])
#neaurl network 
set.seed(123)

library(nnet)
fit <- nnet(train[,11] ~ ., data=train[,1:10],size=6,decay=5e-4)
library(caret)
x <- predict(fit, test[,1:10], type="class")
summary(fit)

head(data)



#tree 
set.seed(123)
tree =  rpart(CLASS~.,method="class", data=train, control = rpart.control(cp = 0.0001))
#plotcp(tree) 
#printcp(tree)
bestcp <- tree$cptable[which.min(tree$cptable[,"xerror"]),"CP"]
tree.pruned <- prune(tree, cp = bestcp)

#printcp(tree.pruned)
#plot(tree.pruned)
#plotcp(tree.pruned)
#text(tree.pruned, cex = 0.8, use.n = TRUE, xpd = TRUE)

#test

# x.rp.prob <- predict(tree.pruned, type="prob", newdata=test[,1:10])
# x.rp.pred <- predict(tree.pruned, type="class", newdata=test[,1:10])
# 
# x.rp.prob[,2] 
# # load the ROCR package which draws the ROC curves
# require(ROCR)
# 
# # create an ROCR prediction object from rpart() probabilities
# x.rp.prob.rocr <- prediction(x.rp.prob[,2], test$CLASS)
# # prepare an ROCR performance object for ROC curve (tpr=true positive rate, fpr=false positive rate)
# x.rp.perf <- performance(x.rp.prob.rocr, "tpr","fpr")
# # plot it
# plot(x.rp.perf, col=2, main="ROC curves comparing classification performance of five machine learning models")
# 
