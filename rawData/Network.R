setwd("~/class/GTMachineLearning_Assignment_1/rawData")
train = read.csv("train.csv")
test = read.csv("test.csv")


test = test[,2:12]
train = train[,2:12]


train$col1 <- rep(NA, nrow(train))
head(train)

train[train$C1 == 1, ][, "col1"] <- '1000'
train[train$C1 == 2, ][, "col1"] <- ''
train[train$C1 == 3, ][, "col1"] <- c(0,0,1,0)
train[train$C1 == 4, ][, "col1"] <- c(0,0,0,1)

train$C1

d <- lapply(x, mean)

values <- c(c(1, 0 ,0 ,0), c(0, 1, 0, 0), c(0, 0, 1, 0),c(0, 0, 0, 1))
values

train$C1<- values[train$C1]

head(train)

#Hearts suit will be equal to 1 0 0 0 set, 
#Spades will be equal to 0 1 0 0 set , 
#Diamonds and Spades will be equal to 0 0 1 0 
#and 0 0 0 1 sets respectively.
# There are 13 different cards in every suit and they will get their own binary sets with 13 values to describe them:
#   
# Ace  1 0 0 0 0 0 0 0 0 0 0 0 0
# 2	0 1 0 0 0 0 0 0 0 0 0 0 0
# 3	0 0 1 0 0 0 0 0 0 0 0 0 0
# 4	0 0 0 1 0 0 0 0 0 0 0 0 0
# 5	0 0 0 0 1 0 0 0 0 0 0 0 0
# 6	0 0 0 0 0 1 0 0 0 0 0 0 0
# 7	0 0 0 0 0 0 1 0 0 0 0 0 0
# 8	0 0 0 0 0 0 0 1 0 0 0 0 0
# 9	0 0 0 0 0 0 0 0 1 0 0 0 0
# 10	0 0 0 0 0 0 0 0 0 1 0 0 0
# Jack	0 0 0 0 0 0 0 0 0 0 1 0 0
# Queen	0 0 0 0 0 0 0 0 0 0 0 1 0
# King	0 0 0 0 0 0 0 0 0 0 0 0 1
# There are 10 possible poker hands depending which 5 cards we have so we need to give matching binary set for every poker hand :
#   
#   Nothing in hand  0 0 0 0 0 0 0 0 0
# One pair	1 0 0 0 0 0 0 0 0
# Two pairs	0 1 0 0 0 0 0 0 0
# Three of a kind	0 0 1 0 0 0 0 0 0
# Straight	0 0 0 1 0 0 0 0 0
# Flush	0 0 0 0 1 0 0 0 0
# Full house	0 0 0 0 0 1 0 0 0
# Four of a kind	0 0 0 0 0 0 1 0 0
# Straight flush	0 0 0 0 0 0 0 1 0
# Royal flush	0 0 0 0 0 0 0 0 1


