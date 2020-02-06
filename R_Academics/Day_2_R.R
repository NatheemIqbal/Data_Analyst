#Import the data,c("")--> this is used to replace blank to NA 
train <- read.csv('C:\\Users\\Muhammad Luqman\\Desktop\\Data Anaytics\\Train_UWu5bXk.csv',
                  header=TRUE,sep=',',na.strings=c(""))


#Import the data
test <- read.csv('C:\\Users\\Muhammad Luqman\\Desktop\\Data Anaytics\\Test_u94Q5KV.csv',
                  header=TRUE,sep=',',na.strings=c(""))


#Import the data
train1 <- read.csv('C:\\Users\\Muhammad Luqman\\Desktop\\Data Anaytics\\SampleSubmission_TmnO39y.csv',
                   header=TRUE,sep=',',na.strings=c(""))

#Audit the data
str(train)
#Check for missing values
sum(is.na(train))
##Individual field missing value
sum(is.na(train$Item_Weight))
sum(is.na(train$Item_Visibility))
##HMISC library to audit the data
install.packages('Hmisc')
library(Hmisc)
describe(train)
##.05 .10 in the result is percentile
##Skewness is there in the data(refer lowest and highes value in result)
install.packages('e1071')
library('e1071')
skewness(train$Item_Weight)###It will not skew because missing value NA is present
##Impute(replcae missing value with median value)
summary(train)
train$Item_Weight<-ifelse(is.na(train$Item_Weight),median(train$Item_Weight,na.rm=TRUE),train$Item_Weight)
##Please note for categorical value we can impute missing value with MOD
##Mising value for Outlet_Size
table(train$Outlet_Size)
##Outlet_Size is a Factorial hence convert to character before computing
sum(is.na(train$Outlet_Size))
train$Outlet_Size <- as.character(train$Outlet_Size)
train$Outlet_Size<-ifelse(is.na(train$Outlet_Size),'Medium',train$Outlet_Size)
###Handle inconsistency in Item_Fat_Content
table(train$Item_Fat_Content)
train$Item_Fat_Content<-as.character(train$Item_Fat_Content)
train$Item_Fat_Content<-ifelse(train$Item_Fat_Content=='LF','Low Fat',train$Item_Fat_Content)
train$Item_Fat_Content<-ifelse(train$Item_Fat_Content=='low fat','Low Fat',train$Item_Fat_Content)
train$Item_Fat_Content<-ifelse(train$Item_Fat_Content=='reg','Regular',train$Item_Fat_Content)
sum(is.na(train))
###Creation of new variable
train$YOB <- 2018-train$Outlet_Establishment_Year
##Visualize
boxplot(train$Item_Weight)#####Skew is 0.12 it has to be 0 for no skwe data but it is ok
boxplot(train$Item_Visibility)
skewness(train$Item_Visibility)
#####Bivariate Analysis
cor(train$Item_Weight,train$Item_MRP)
cor(train$Item_Weight,train$Item_Visibility)
cor(train$Item_Weight,train$Item_Outlet_Sales)
cor(train$Item_MRP,train$Item_Outlet_Sales)
###Multi variate Analys
names(train)
model<-lm(Item_Outlet_Sales~Item_Weight+Item_Fat_Content+Item_Visibility+Item_MRP+Outlet_Size+Outlet_Location_Type
          +Outlet_Type+YOB,data=train)
model
summary(model)
boxplot(model$residuals)
model$fitted.values
train$pred<-predict(model,train)
train$resid<-train$Item_Outlet_Sales-train$pred
train$sqresid<-train$resid*train$resid
mean_squared_error <- mean(train$sqresid)
root_mean_squared_error <-sqrt(mean_squared_error)
