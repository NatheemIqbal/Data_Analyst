import numpy as np
import pandas as pd
import os
#Set the working directory
os.chdir('F:\\Data Anaytics\\Arul_Python\\18_05_19_files')
train=pd.read_csv('HR_train.csv')
#test=pd.read_csv('test.csv')

###Check for missing values
train_missing=train.isnull().sum()
train['education'].value_counts()
train['education']=np.where(train['education'].isnull(),"Bachelor's",train['education'])

train['previous_year_rating'].value_counts()
train['previous_year_rating']=np.where(train['previous_year_rating'].isnull(),np.nanmedian(train['previous_year_rating']),train['previous_year_rating'])
#test_missing=test.isnull().sum()
####---Data is huge hence we splitting 80:20 ratio data with in train data

from sklearn.preprocessing import LabelEncoder
LE = LabelEncoder()
train['department']=LE.fit_transform(train['department'])
train['department'].value_counts()

train['region']=LE.fit_transform(train['region'])
train['region'].value_counts()

train['education']=LE.fit_transform(train['education'])
train['education'].value_counts()

train['gender']=LE.fit_transform(train['gender'])
train['gender'].value_counts()

train['recruitment_channel']=LE.fit_transform(train['recruitment_channel'])
train['recruitment_channel'].value_counts()

Y=train['is_promoted']
X=train.iloc[:,1:13]

from sklearn.model_selection import train_test_split

X_train,X_test,Y_train,Y_test=train_test_split(X,Y,test_size=0.20,random_state=123)
#####---random will constantly pick same records similar to seeds in R programming

#####---Let run neural network model------
#####---This is Classfication as label field gives value from 1 to 10
#######----Multi layer perceptron classfier

from sklearn.neural_network import MLPClassifier

MLP= MLPClassifier(hidden_layer_sizes=(50,50,50),solver='adam',verbose=True)
######------adam is like jumping to the global point by skipping interim steps, we can use diff types of solver
#####---verbose =True is default 200 iteration and we can adjust iteration

MLP.fit(X_train,Y_train) ####For test not required because test is the one we need to predict

Y_preds_Train_MLP = MLP.predict(X_train)
Y_preds_Test_MLP = MLP.predict(X_test)

from sklearn.metrics import confusion_matrix
cm_train_mlp=confusion_matrix(Y_train,Y_preds_Train_MLP)
####You can calculate efficiency by exploring cm_train_mlp file
cm_test_mlp=confusion_matrix(Y_test,Y_preds_Test_MLP)
10036+29+628+269 ########94% efficiency

######Similarly, we can increase hidden_layer_size and iteration level to increase the efficiency
######---Please note when iteration runs loss can be calculated but certain point it will reach saturation point
######Remember 0 is the perfect loss value

#####let us apply on test data


#######-------XGBOOST model--------###################

###Need to install below library in Anaconda prompt
####conda install py-xgboost


from xgboost import XGBClassifier
XGB=XGBClassifier()
XGB.fit(X_train,Y_train)

preds_XGB=XGB.predict(X_train)
cm_xgb=confusion_matrix(Y_train,preds_XGB)
##### Now calculate efficiency
####93% is the efficiency in train data, do it in test data and submit the result in Analytics Vidya
#################################################################
#################################################################
#####################-----------------TIme Series--------------------###############

