### Import data ###
##########################Random Forest################
#Import the data
train <- read.csv('F:\\Data Anaytics\\R_Part2\\07-04-19\\train_LZdllcl.csv',na.strings=c(""))

install.packages("Hmisc")
library(Hmisc)
describe(train)
sum(is.na(train$education))

str(train)
table(train$previous_year_rating)
## change the variable type##
train$KPIs_met..80.<-as.factor(train$KPIs_met..80.)
train$is_promoted<-as.factor(train$is_promoted)
train$awards_won.<-as.factor(train$awards_won.)
train$previous_year_rating<-as.factor(train$previous_year_rating)


### treating the missing value ##
sum(is.na(train))
sum(is.na(train$previous_year_rating))
train$previous_year_rating<-ifelse(is.na(train$previous_year_rating),'3',train$previous_year_rating)
table(train$previous_year_rating)
str(train)

sum(is.na(train$education))
train$education<-as.character(train$education)
table(train$education)

train$education<-ifelse(is.na(train$education),"Bachelor's",train$education)
View(train)

#### Exploratory Data analysis ###
table(train$department)
table(train$region)

#Average age of people across department ###
names(train$department)
mean(train$age[train$department=='HR'])
mean(train$age[train$department=='Analytics'])
mean(train$age[train$department=='Finance'])

##Most frequency Region
summary(train$region)
summary(train$department)
##Frequency of department
library(plyr)
count('train','train$department')

##Department with highest award
table(train$awards_won.,train$department)

X <- c("education","gender","recruitment_channel","no_of_trainings","age","previous_year_rating","length_of_service","KPIs_met..80.","awards_won.","avg_training_score")
##X <- c("education","+","gender","+","recruitment_channel","+","no_of_trainings","+","age","+","previous_year_rating","+","length_of_service","+","KPIs_met..80.","+","awards_won.","+","avg_training_score")
Y <-c("is_promoted")
X

### GLM model----->the below model with X and Y needs to be verified ###
names(train)
model_glm1<-glm(Y~X,family='binomial',data=train)

### Decision treee ### in decision tree Char variable not supported

library('party')
str(train)
train$previous_year_rating<-as.factor(train$previous_year_rating)
train$education<-as.factor(train$education)
model_tree<-ctree(is_promoted~education+gender+recruitment_channel+no_of_trainings+age+previous_year_rating+length_of_service+KPIs_met..80.+awards_won.+avg_training_score,data=train)
model_tree
train$pred_tree<-predict(model_tree,train)
table(train$is_promoted,train$pred_tree)
(49870+872)/(49870+270+3796+872)

#####SVM
#to drop variable please use below code
train<-subset(train,select=-c(employee_id,department))
###############
#####################caret model###############################
install.packages('caret')
library(caret)
X <- c("education","gender","recruitment_channel","no_of_trainings","age","previous_year_rating","length_of_service","KPIs_met..80.","awards_won.","avg_training_score")
##X <- c("education","+","gender","+","recruitment_channel","+","no_of_trainings","+","age","+","previous_year_rating","+","length_of_service","+","KPIs_met..80.","+","awards_won.","+","avg_training_score")
Y <-c("is_promoted")
X
Y
model_rf <- train(train[,X],train[,Y],method='rf')
model_rf
###caret is not working for now so let us jump to test data for now using other models
#Import the data
test <- read.csv('F:\\Data Anaytics\\R_Part2\\07-04-19\\test_2umaH9m.csv',na.strings=c(""))
summary(test)
library('Hmisc')
describe(test)
sum(is.na(test))
sum(is.na(test$previous_year_rating))
sum(is.na(test$department))
sum(is.na(test$education))
table(test$previous_year_rating)
test$previous_year_rating<-ifelse(is.na(test$previous_year_rating),'3',test$previous_year_rating)
test$education<-as.character(test$education)
test$education<-ifelse(is.na(test$education),"Bachelor's",test$education)
test$education<-as.factor(test$education)
str(test)
test$previous_year_rating<-as.factor(test$previous_year_rating)
test$pred_tree<-predict(model_tree,test)
View(test)
write.csv(test,'finals.csv')

#####################naiveBayes model#########################
#this model is used most for classification and it is a conditional probability
#example: if need to find the probability occurs of tsunami it again has to check for 
#probability of earth quke occurence
library('e1071')
names(train)

nb_model<-naiveBayes(is_promoted~education+gender+recruitment_channel+no_of_trainings+age+previous_year_rating+length_of_service+KPIs_met..80.+awards_won.+avg_training_score,data=train)
train$preds <- predict(nb_model,train)
table(train$is_promoted,train$preds)
(49176+718)/(49176+718+3950+964)
nb_model

###########Tip's######################
###We can take all the predictive values of all models of classificaion
###i.e. Random Forest, Logistic regression, Svm and then predict based on the maximum vote

View(train)

svm_model<-svm(is_promoted~education+gender+recruitment_channel+no_of_trainings+age+previous_year_rating+length_of_service+KPIs_met..80.+awards_won.+avg_training_score,cost=10,data=train)
train$preds_svm <- predict(nb_model,train)
table(train$is_promoted,train$preds)
