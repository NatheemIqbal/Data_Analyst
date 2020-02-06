import numpy as np
import pandas as pd
import os
#Set the working directory
os.chdir('F:\\Data Anaytics\\Arul_Python\\11_05_19_files')
train=pd.read_csv('Train_loan.csv')
test=pd.read_csv('Test_loan.csv')

###Check for missing values
train_missing=train.isnull().sum()
test_missing=test.isnull().sum()

##Impute missing value in train
train['Gender'].value_counts()### to find the values count
new_gender=np.where(train['Gender'].isnull(),'Male',train['Gender'])
train['Gender']=new_gender
train['Gender'].isnull().sum()####Now no missing values
##Impute missing values for Married
train['Married'].value_counts()### to find the values count
train['Married']=np.where(train['Married'].isnull(),'Yes',train['Married'])
train['Married'].isnull().sum()####Now no missing values

####Replace and Impute missing values
train['Dependents'].value_counts()### to find the values count
train['Dependents']=train['Dependents'].replace('3+',3)
train['Dependents']=train['Dependents'].replace('0',0)
train['Dependents']=np.where(train['Dependents'].isnull(),0,train['Dependents'])
train['Dependents']=pd.to_numeric(train['Dependents'])
train['Dependents'].dtypes
train['Dependents'].isnull().sum()####Now no missing values
##Impute missing values Self_Employed
train['Self_Employed'].value_counts()
train['Self_Employed']=np.where(train['Self_Employed'].isnull(),'No',train['Self_Employed'])
train['Dependents'].isnull().sum()####Now no missing values

###Impute for loan amount
train['LoanAmount']=np.where(train['LoanAmount'].isnull(),np.nanmedian(train['LoanAmount']),train['LoanAmount'])
###nanmedian will omit null values while calculating median
train['LoanAmount'].isnull().sum()####Now no missing values

###Impute for loan amount
train['Loan_Amount_Term'].value_counts()
train['Loan_Amount_Term'].dtypes
train['Loan_Amount_Term']=np.where(train['Loan_Amount_Term'].isnull(),360,train['Loan_Amount_Term'])
train['Loan_Amount_Term'].isnull().sum()####Now no missing values
#####################
###Impute for Credit_History
train['Credit_History'].value_counts()
train['Credit_History'].dtypes
train['Credit_History']=np.where(train['Credit_History'].isnull(),1,train['Credit_History'])
train['Credit_History'].isnull().sum()

############################
train_missing=train.isnull().sum()  #####Now no missing value in entire variables


####Label encoder to convert classfied char to numeric
from sklearn.preprocessing import LabelEncoder
LE = LabelEncoder()
train['Gender']=LE.fit_transform(train['Gender'])
train['Gender'].value_counts()

train['Married']=LE.fit_transform(train['Married'])
train['Married'].value_counts()

train['Education']=LE.fit_transform(train['Education'])
train['Education'].value_counts()

train['Self_Employed']=LE.fit_transform(train['Self_Employed'])
train['Self_Employed'].value_counts()

train['Property_Area']=LE.fit_transform(train['Property_Area'])
train['Property_Area'].value_counts()

train['Loan_Status']=LE.fit_transform(train['Loan_Status'])
train['Loan_Status'].value_counts()

#####Model Processing
#####Logistic
Y=train['Loan_Status']
X=train.iloc[:,1:11]

from sklearn.linear_model import LogisticRegression
Log_Reg=LogisticRegression()
Log_Reg.fit(X,Y)

Preds_Log_Reg =Log_Reg.predict(X)
from sklearn.metrics import confusion_matrix

cm_log_reg = confusion_matrix(Y,Preds_Log_Reg)
print(cm_log_reg)

##---84+414=498
##---84+414+8+108=614
##----498/614=0.811 (i.e.81% is the accuracy)

#########################--Rand FOrest
from sklearn.ensemble import RandomForestClassifier
RF =  RandomForestClassifier(n_estimators=500)
RF.fit(X,Y)
Preds_RF = RF.predict(X)
from sklearn.metrics import confusion_matrix

RF_log_reg = confusion_matrix(Y,Preds_RF)
print(RF_log_reg)

##192+422=614
##614/614=1 (i.e 100% efficiency)
#######################-----Naive Bayes
from sklearn.naive_bayes import GaussianNB
NB=GaussianNB()
NB.fit(X,Y)
preds_NB=NB.predict(X)
cm_NB=confusion_matrix(Y,preds_NB)
print(cm_NB)
####89+402+20+103
###491/614===>79% efficiency
###########################----Apply on Test Data------####
##Impute missing value in train
test['Gender'].value_counts()### to find the values count
new_gender=np.where(test['Gender'].isnull(),'Male',test['Gender'])
test['Gender']=new_gender
test['Gender'].isnull().sum()####Now no missing values

####Replace and Impute missing values
test['Dependents'].value_counts()### to find the values count
test['Dependents']=test['Dependents'].replace('3+',3)
test['Dependents']=test['Dependents'].replace('0',0)
test['Dependents']=np.where(test['Dependents'].isnull(),0,test['Dependents'])
test['Dependents']=pd.to_numeric(test['Dependents'])
test['Dependents'].dtypes
test['Dependents'].isnull().sum()####Now no missing values
##Impute missing values Self_Employed
test['Self_Employed'].value_counts()
test['Self_Employed']=np.where(test['Self_Employed'].isnull(),'No',test['Self_Employed'])
test['Self_Employed'].isnull().sum()####Now no missing values

###Impute for loan amount
test['LoanAmount']=np.where(test['LoanAmount'].isnull(),np.nanmedian(test['LoanAmount']),test['LoanAmount'])
###nanmedian will omit null values while calculating median
test['LoanAmount'].isnull().sum()####Now no missing values

###Impute for loan amount
test['Loan_Amount_Term'].value_counts()
test['Loan_Amount_Term'].dtypes
test['Loan_Amount_Term']=np.where(test['Loan_Amount_Term'].isnull(),360,test['Loan_Amount_Term'])
test['Loan_Amount_Term'].isnull().sum()####Now no missing values
#####################
###Impute for Credit_History
test['Credit_History'].value_counts()
test['Credit_History'].dtypes
test['Credit_History']=np.where(test['Credit_History'].isnull(),1,test['Credit_History'])
test['Credit_History'].isnull().sum()

############################
test_missing=train.isnull().sum()  #####Now no missing value in entire variables


####Label encoder to convert classfied char to numeric
from sklearn.preprocessing import LabelEncoder
LE = LabelEncoder()
test['Gender']=LE.fit_transform(test['Gender'])
test['Gender'].value_counts()

test['Married']=LE.fit_transform(test['Married'])
test['Married'].value_counts()

test['Education']=LE.fit_transform(test['Education'])
test['Education'].value_counts()

test['Self_Employed']=LE.fit_transform(test['Self_Employed'])
test['Self_Employed'].value_counts()

test['Property_Area']=LE.fit_transform(test['Property_Area'])
test['Property_Area'].value_counts()

test['Loan_Status']=LE.fit_transform(test['Loan_Status'])
test['Loan_Status'].value_counts()
#####-----Try to do test it is a HW#######


