import numpy as np
import pandas as pd
import os
#Set the working directory
os.chdir('F:\\Data Anaytics\\Arul_Python\\12_05_19_files')
train=pd.read_csv('train.csv')
test=pd.read_csv('test.csv')

###Check for missing values
train_missing=train.isnull().sum()
test_missing=test.isnull().sum()
####---Data is huge hence we splitting 80:20 ratio data with in train data
Y=train['label']
X=train.iloc[:,1:]

from sklearn.model_selection import train_test_split

X_train,X_test,Y_train,Y_test=train_test_split(X,Y,test_size=0.2,random_state=42)
#####---random will constantly pick same records similar to seeds in R programming

#####---Let run neural network model------
#####---This is Classfication as label field gives value from 1 to 10
#######----Multi layer perceptron classfier

from sklearn.neural_network import MLPClassifier

MLP= MLPClassifier(hidden_layer_sizes=(5,5,5),solver='adam',verbose=True)
######------adam is like jumping to the global point by skipping interim steps, we can use diff types of solver
#####---verbose =True is default 200 iteration and we can adjust iteration

MLP.fit(X_train,Y_train)

Y_preds_Train_MLP = MLP.predict(X_train)
Y_preds_Test_MLP = MLP.predict(X_test)

from sklearn.metrics import confusion_matrix
cm_train_mlp=confusion_matrix(Y_train,Y_preds_Train_MLP)
####You can calculate efficiency by exploring cm_train_mlp file
cm_test_mlp=confusion_matrix(Y_test,Y_preds_Test_MLP)

######Similarly, we can increase hidden_layer_size and iteration level to increase the efficiency
######---Please note when iteration runs loss can be calculated but certain point it will reach saturation point
######Remember 0 is the perfect loss value

#####let us apply on test data
test_data=test.iloc[:,0:]
test_data_output= MLP.predict(test_data)
#####Submitted o kaggle got 85% efficiency


########---We can apply scalar method also for good result, let us apply on st part of train data set

from sklearn.preprocessing import StandardScaler
scaler=StandardScaler()
scaler.fit(X_train)
X_train=scaler.transform(X_train)
X_test=scaler.transform(X_test)

from sklearn.neural_network import MLPClassifier

MLP= MLPClassifier(hidden_layer_sizes=(50,50,50),solver='adam',verbose=True)
MLP.fit(X_train,Y_train)

Y_preds_Train_MLP = MLP.predict(X_train)
Y_preds_Test_MLP = MLP.predict(X_test)

from sklearn.metrics import confusion_matrix
cm_train_mlp=confusion_matrix(Y_train,Y_preds_Train_MLP)
####You can calculate efficiency by exploring cm_train_mlp file
cm_test_mlp=confusion_matrix(Y_test,Y_preds_Test_MLP)
#######Apply on Test data set also directly
test_scale=scaler.transform(test)
preds_test=MLP.predict(test_scale)
preds_test=pd.DataFrame(preds_test)
preds_test.to_csv('output.csv')
