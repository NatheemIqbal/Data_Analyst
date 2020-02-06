####Decision Trees#######

setwd('F:\\Data Anaytics\\R_Part2\\')
train <- read.csv('train.csv', na.strings = c(""))
install.packages('party')
library('party')
png(file = 'decision_tree.png')
names(train)
model_tree <- ctree(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked, data = train)
##Plot tree
plot(model_tree)
###to get image in our directory write below code
dev.off()

summary(model_tree)
getwd()

####COnfusion matrix
train$preds_modeltree <- predict(model_tree, train)
table(train$Survived, train$preds_modeltree)
###efficiency came as 83% so going for random tree

#######Random forest#################
install.packages('randomForest')
library('randomForest')
model_rf <- randomForest(Survived~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked,  ntree=1000, data=train)


#####Random Forest on Loan predictions#####
setwd('F:\\Data Anaytics\\R_Part2\\Loan_prediction_Analytics_vidya')
train_loan <- read.csv('TRAIN_LOAN.csv', na.strings = c(""))


str(train_loan)
###COnvert to char from factor to impute computation
train_loan$Gender <- as.character(train_loan$Gender)
sum(is.na(train_loan$Gender)) ##13 missing values
train_loan$Gender <- ifelse(is.na(train_loan$Gender),'Male',train_loan$Gender)
sum(is.na(train_loan$Gender)) ##Now it is 0
###COnvert back  to factor 
train_loan$Gender <- as.factor(train_loan$Gender)


train_loan$Married <- as.character(train_loan$Married)
sum(is.na(train_loan$Married))
train_loan$Married <- ifelse(is.na(train_loan$Married),'Yes',train_loan$Married)
train_loan$Married <- as.factor(train_loan$Married)
library(e1071)
 
 str(train_loan)
 
 ###Please convert from factor to character and then do missin computation
 train_loan$Dependents <- ifelse(is.na(train_loan$Dependents),'0',train_loan$Dependents)
 sum(is.na(train_loan$Dependents))
 
 
 train_loan$Self_Employed <- as.character(train_loan$Self_Employed)
 train_loan$Self_Employed <- ifelse(is.na(train_loan$Self_Employed),'No',train_loan$Self_Employed)
 sum(is.na(train_loan$Self_Employed))
 train_loan$Self_Employed <- as.factor(train_loan$Self_Employed)

 
 train_loan$LoanAmount <- ifelse(is.na(train_loan$LoanAmount),median(train_loan$LoanAmount,na.rm = TRUE),train_loan$LoanAmount) 
 train_loan$Loan_Amount_Term <- ifelse(is.na(train_loan$Loan_Amount_Term),median(train_loan$Loan_Amount_Term,na.rm = TRUE),train_loan$Loan_Amount_Term) 
 train_loan$Credit_History <- ifelse(is.na(train_loan$Credit_History),median(train_loan$Credit_History,na.rm = TRUE),train_loan$Credit_History) 
 
 
 model_rf1 <- randomForest(Loan_Status~Gender+Married+Dependents+Education+Self_Employed+ApplicantIncome+CoapplicantIncome+LoanAmount+Loan_Amount_Term+Credit_History+Property_Area,ntree=500, data=train_loan)
 model_rf1 ###20.68 % error is coming so it means 795 efficient solet us normalise the skewness variable
 
 skewness(train_loan$ApplicantIncome)
 mean(train_loan$ApplicantIncome)
 var(train_loan$ApplicantIncome)
 
 #####Added new variable by calculating using x-mean/SD
 train_loan$New_applicant_income <- (train_loan$ApplicantIncome - mean(train_loan$ApplicantIncome))/sd(train_loan$ApplicantIncome)
 boxplot(train_loan$ApplicantIncome)
 
 ####Applied new variable in model but still 80% is the efficiency
 model_rf1 <- randomForest(Loan_Status~Gender+Married+Dependents+Education+Self_Employed+New_applicant_income+CoapplicantIncome+LoanAmount+Loan_Amount_Term+Credit_History+Property_Area,ntree=500, data=train_loan)
 model_rf1 
 
 ###efficiency still not improved hence apply log
 train_loan$second_new_applicant_income <-log(train_loan$New_applicant_income)
 model_rf1 <- randomForest(Loan_Status~Gender+Married+Dependents+Education+Self_Employed+second_new_applicant_income+CoapplicantIncome+LoanAmount+Loan_Amount_Term+Credit_History+Property_Area,ntree=500, data=train_loan)
 model_rf1
 
 ####We can keep on normalise skew variable and try  to build model###
 
 ###We can run below code to get predicted value and we can write it to our csv file

 train_loan$pred_random_model <- predict(model_rf1, train_loan, type = 'response')
 ######################################################################
 
 ##Missing value imputation can be done in advanced way by using Amelia***
   
install.packages('Amelia')   
 library('Amelia')
newimpute <- amelia(train_loan, m=5,
                    idvars =c("Loan_ID","Education","ApplicantIncome","CoapplicantIncome","Property_Area","Loan_Status"),
                    noms=c("Gender","Married","Self_Employed","Credit_History"),
                    ords = c("Dependents"))
####It will generate 5 diff files where we can apply different models
write.amelia(newimpute, file.stem = "imputed_data_set")
                              
 
 