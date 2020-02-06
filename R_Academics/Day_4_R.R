#Import the data,c("")--> this is used to replace blank to NA 
train <- read.csv('C:\\Users\\Muhammad Luqman\\Desktop\\Data Anaytics\\R_Part2\\train.csv',
                  header=TRUE,sep=',',na.strings=c(""))


#Import the data
test <- read.csv('C:\\Users\\Muhammad Luqman\\Desktop\\Data Anaytics\\R_Part2\\test.csv',
                  header=TRUE,sep=',',na.strings=c(""))

summary(train)
str(train)

boxplot(train$Age)

install.packages("Hmisc")
library(Hmisc)
library(e1071)
skewness(train$Age)
###Ideal skew value is 0
skewness(train$Fare)
####describe function to work we need Hmisc pkg
describe(train)

###Converrt to factor as survived variable is categorical
train$Survived <- as.factor(train$Survived)
train$Pclass <- as.factor(train$Pclass)

#Missing value imputation
train$Age <- ifelse(is.na(train$Age),median(train$Age,na.rm = TRUE),train$Age)

sum(is.na(train$Age))

sum(is.na(train$Embarked))

train$Embarked <- as.character(train$Embarked)

train$Embarked <- ifelse(is.na(train$Embarked),'S',train$Embarked)
train$Embarked <- as.factor(train$Embarked)
table(train$Embarked)

str(train)

cor(train$Age,train$Fare)
cor(train$SibSp,train$Parch)

names(train)

#Generalised Linear model or Logistic regression
#Maximum Likelyhood philosophy for Logistic regression
model <- glm(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked,family = 'binomial', data = train)

summary(model)

##Creating new column preds and comparing it with survived variable to check if model is good.
## Predict is the function name
train$preds <- predict(model,train,type ='response')
##If the result is more than 0.5 then we can classify as 1 otherwise 0)
train$outcome <- ifelse (train$preds>= 0.5 ,1,0)

###Confusion matrix which compres the one to one result
table(train$Survived,train$outcome)

(477+240)/(477+72+102+240)

##Result came as 0.804 that  means 80% the model is correct that said how many died and how many survived

###Let us try with model to to get more accurcy by applying log as this normlise the skewness
train$ln_fare <- log(train$Fare)

###ln_fare coming in infinity hence we are going to convert in to value
train$ln_fare <- ifelse(train$ln_fare==-Inf,0,train$ln_fare)

model2 <- glm(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked+ln_fare,family = 'binomial', data = train)

train$preds_model2 <- predict(model2, train, type = 'response')
train$outcome_model2 <- ifelse (train$preds_model2>= 0.5 ,1,0)
table(train$Survived,train$outcome_model2)

(466+243)/(466+83+99+243)

#####Again we are getting close to 80% accuracy so we may have to think of another model
####Below code will write the data in desired location
write.csv(train,'C:\\Users\\Muhammad Luqman\\Desktop\\Data Anaytics\\R_Part2\\nadeem_predict.csv')

#####Please try with test data refer share drive for code
