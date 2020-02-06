setwd('H:\\WorkingFolder\\')
train <- read.csv('train.csv', na.strings = c(""))
test <- read.csv('test.csv', na.strings = c(""))

summary(train)
str(train)

boxplot(train$Age)
library(Hmisc)
library(e1071)
skewness(train$Age)
boxplot(train$Fare)
skewness(train$Fare)
describe(train)

#Convert to factor
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)
str(train)

#Missing Value Imputation
train$Age <- ifelse(is.na(train$Age),
                    median(train$Age,na.rm = TRUE),
                    train$Age)
sum(is.na(train$Age))
#Missing Value Imputation - Embarked
sum(is.na(train$Embarked))
table(train$Embarked)

train$Embarked <- as.character(train$Embarked)

train$Embarked <- ifelse(is.na(train$Embarked),
                         'S',train$Embarked)

train$Embarked <- as.factor(train$Embarked)
skewness(train$Age)

cor(train$Age,train$Fare)
cor(train$SibSp,train$Parch)
names(train)

model <- glm(Survived~Pclass+Sex+Age+SibSp+Parch+
               Fare+Embarked, family = 'binomial', 
             data = train)
summary(model)

train$preds <- predict(model, train,
                       type = 'response')
train$outcome <- ifelse(train$preds>=0.5,1,0)


table(train$Survived,train$outcome)
#-----------##########-----------#############-------------
train$ln_fare <- log(train$Fare)
train$ln_fare <- ifelse(train$ln_fare==-Inf,0,train$ln_fare)
model2 <- glm(Survived~Pclass+Sex+Age+SibSp+Parch+
                ln_fare+Embarked, family = 'binomial',
              data = train)
train$preds_model2 <- predict(model2, train, type = 'response')
train$outcome_model2 <- ifelse(train$preds_model2>=0.5,1,0)
table(train$Survived,train$outcome_model2)
######-----------------###############-------###############
str(test)
test$Pclass <- as.factor(test$Pclass)
sum(is.na(test$Age))
sum(is.na(test$Embarked))
sum(is.na(test$Fare))
test$Age <- ifelse(is.na(test$Age),
                   median(test$Age,na.rm = TRUE),test$Age)
test$Fare <- ifelse(is.na(test$Fare),
                          median(test$Fare,na.rm = TRUE),
                                 test$Fare)

test$preds <- predict(model, test, type = 'response')
test$outcome <- ifelse(test$preds>=0.5,1,0)
