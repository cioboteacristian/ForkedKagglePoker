setwd("~/git/GTMachineLearning_Assignment_1/poker")
#setwd("~/class/GTMachineLearning_Assignment_1/poker")
train <- read.csv("train.csv")

head(train)
#labels = as.factor(train$hand)
#train = train[,1:10]
#head(train)
library(rpart)
CART.fit <- rpart(hand ~., data=train,
                  control=rpart.control(minsplit=2, minbucket=1, cp=0.001))

summary(CART.fit)
#plot(CART.fit)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
#fancyRpartPlot(CART.fit)
#plotcp(CART.fit)

ptree <- prune(CART.fit,cp=CART.fit$cptable[which.min(CART.fit$cptable[,"xerror"]),"CP"])
#plotcp(ptree)
#fancyRpartPlot(ptree)

test <- read.csv("test.csv")
head(test)
#Get rid of ID column
test = test[,2:11]
head(test)

prediction <- predict(ptree, newdata=test)
summary(prediction)
head(prediction)
#pre <- formatC(prediction, format="f", digits=0)

#sss <- factor(pre)
head(sss)
head(pre)
library(caret)
sub <- read.csv("sampleSubmission.csv")
sub = sub[,2:2]
head(sub)
#aaa <- factor(sub)




summary(sss)

confusionMatrix(sss,aaa)
table(prediction)
