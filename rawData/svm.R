cat("\014") 
#setwd("~/git/GTMachineLearning_Assignment_1/rawData")
setwd("~/class/GTMachineLearning_Assignment_1/rawData")
train = read.csv("train.csv")
test = read.csv("test.csv")


test = test[,2:12]
train = train[,2:12]


trainC1 = as.factor(train$C1)
trainS1 = as.factor(train$S1)
trainC1S1 = interaction(trainC1,  trainS1)

trainC2 = as.factor(train$C2)
trainS2 = as.factor(train$S2)
trainC2S2 = interaction(trainC2,  trainS2)

trainC3 = as.factor(train$C3)
trainS3 = as.factor(train$S3)
trainC3S3 = interaction(trainC3,  trainS3)


trainC4 = as.factor(train$C4)
trainS4 = as.factor(train$S4)
trainC4S4 = interaction(trainC4,  trainS4)


trainC5 = as.factor(train$C5)
trainS5 = as.factor(train$S5)
trainC5S5 = interaction(trainC5,  trainS5)

trainCLASS = as.factor(train$CLASS)
#http://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Classification/SVM#Case_Study
#svm.model2 <- svm(trainCLASS ~ trainC1S1,trainC2S2,trainC3S3,trainC4S4,trainC5S5,  data =train, type="C-classification", kernel="linear", cost=1)
#svm.pred <- predict(svm.model2, test[,-11])
#install.packages('e1071',dependencies=TRUE)
library(e1071)
#tuned <- tune.svm(trainCLASS ~., data = train, gamma = 10^(-6:-1), cost = 10^(-1:1))

# Parameter tuning of ‘svm’:
#   
#   - sampling method: 10-fold cross validation 
# 
# - best parameters:
#   gamma cost
# 0.1    1
# 
# - best performance: 0.5968057 

model  <- svm(trainCLASS~., data = train, kernel="radial", gamma=0.1, cost=1)
# 
# Call:
#   svm(formula = CLASS ~ ., data = train, kernel = "radial", gamma = 0.1, cost = 1)
# 
# 
# Parameters:
#   SVM-Type:  eps-regression 
# SVM-Kernel:  radial 
# cost:  1 
# gamma:  0.1 
# epsilon:  0.1 
# 
# 
# Number of Support Vectors:  22682
#head(test[,-11])

prediction <- predict(model, test[,-11])

tab <- table(pred = prediction, true = test$CLASS)

tab

