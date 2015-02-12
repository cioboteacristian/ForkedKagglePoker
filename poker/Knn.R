cat("\014") 
setwd("~/git/GTMachineLearning_Assignment_1/rawData")
#setwd("~/class/GTMachineLearning_Assignment_1/rawData")
train = read.csv("train.csv")
test = read.csv("test.csv")


test = test[,2:12]
train = train[,2:12]




trainCLASS = as.factor(train$CLASS)


library(class)

knn_predict <-knn(train, test, trainCLASS, k = 10, l = 0, prob = FALSE, use.all = TRUE)
table(knn_predict, test$CLASS)

confusionMatrix(knn_predict,test$CLASS)