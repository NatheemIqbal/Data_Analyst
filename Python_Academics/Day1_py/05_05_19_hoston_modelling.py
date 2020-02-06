import numpy as np
import pandas as pd
import os
#Set the working directory
os.chdir('F:\\Data Anaytics\\Arul_Python\\05_05_19_files')
train=pd.read_csv('HouseTrain.csv')

train['ID'].isna().value_counts()  
train['ID'].isna().sum()###Checking missing values in ID column

train.isna().sum()  ###Missing values of all the columns

###Summary of data
train.describe()

summary=train.describe()  ####We are assignng to summary file to view it clearly


train.head(20)
train.tail(20)

train['nox'].mean()
train['nox'].median()
train['nox'].sum()

tra_arr=np.array(train)  

###Skewness

train.skew()

np.mean(train['tax'])    ###using numpy
train['tax'].mean()  ###Using Pandas


train['chas'].value_counts()  ###To check frequency
##pd.crosstab(train['chas'],np.mean)
train['log_crim']=np.log(train['crim'])   ####to reduce skewness on crim field we are creating new variable with log

train['scale_crim']=((train['crim']-np.mean(train['crim'])/np.std(train['crim'])))
###Above   is equal to x-M/o formula for z-code tansformation

def standard_scaler(var):
    mean =np.mean(var)
    std=np.std(var)
    scale_var=(var-mean)/std
    return scale_var

train_scale=standard_scaler(train)
####Withoud creating new variable we can do z-code transformation on all variables

correlation_matrix=np.corrcoef(train['crim'],train['tax'])

cor_matrix_pandas=train.corr()

#####11-05-19
#####-----Modelling process
Y=train['medv']

X=train.iloc[:,1:14]

###Linear search in google as linear regression sklearn
from sklearn.linear_model import LinearRegression

LR=LinearRegression()

LR.fit(X,Y)

LR.coef_

LR.intercept_

Preds_LR=LR.predict(X)

from sklearn.metrics import mean_squared_error

mse_lr=mean_squared_error(Y,Preds_LR)

rmse_lr=np.sqrt(mse_lr)
print(rmse_lr) ###4000 can be higher or lower predicted for house price
print(mse_lr)
######################################################
####----Rndom Forest
from sklearn.ensemble import RandomForestRegressor
RF =  RandomForestRegressor(n_estimators=500)
RF.fit(X,Y)
Preds_RF = RF.predict(X)
rmse_rf=np.sqrt(mean_squared_error(Y,Preds_RF))
print(rmse_rf)####1.19 i.e 1000 is higher or lower predicted for housing which is better than linear model

###########################################
#######----SVM

from sklearn.svm import SVR
SVM = SVR(kernel ='poly')
SVM.fit(X,Y)
preds_SVM = RF.predict(X)###doubt check properly has to come SVM not RF
rmse_svm = np.sqrt(mean_squared_error(Y,preds_SVM))
print(rmse_svm)

########Let us predict Test dataset#######################3s
Test=pd.read_csv('Housetest.csv')

##Remove ID
test_data =Test.iloc[:,1:14]
###Predict Y for test data
test_data['predict_medv'] = RF.predict(test_data)
###Write the output to csv 
test_data.to_csv('output.csv')






















