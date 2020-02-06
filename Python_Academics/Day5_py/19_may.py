############--Time Series--------#############
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
#Set the working directory
os.chdir('F:\\Data Anaytics\\Arul_Python\\18_05_19_files\\Time_series')
dateparse = lambda dates: pd.datetime.strptime(dates,'%Y-%m')
###----Above is the function which convert to certain date formats
data=pd.read_csv('AirPassengers.csv',parse_dates=['Month'],index_col='Month',date_parser=dateparse)


data.head()

data.index

plt.plot(data)


from statsmodels.tsa.stattools  import adfuller

moving_avg=data.rolling(3).mean()

plt.plot(data)
plt.plot(moving_avg,color='red')


adfuller(data['#Passengers'],autolag='AIC')

              
from statsmodels.tsa.seasonal import seasonal_decompose

decomposition=seasonal_decompose(data['#Passengers'])
                                      
 trend=decomposition.trend
 
 seasonal=decomposition.seasonal
 
 residual=decomposition.resid
 
 plt.plot(trend,label='Trend') ##### example :Diwali trand is now a days low in buying crackers
 plt.plot(seasonal,label='Seasonality') #### Static Diwali season
 plt.plot(residual,label='Residuals')####Un explained errors or events
 
 ######Set 2
 from statsmodels.tsa.arima_model import ARIMA
 
 model=ARIMA(data['#Passengers'],order=(2,1,2))
 results_AR =model.fit()
 
 predictions=pd.Series(results_AR.fittedvalues,copy=True)
 
 plt.plot(data['#Passengers'])
 plt.plot(results_AR.fittedvalues,color='red')
 ################################################
 #################----Clustering-----############
 import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
#Set the working directory
os.chdir('F:\\Data Anaytics\\Arul_Python\\19_05_19_files')
data1=pd.read_csv('Iris.csv')

summary=data1.describe()
plt.boxplot(data1['SepalLengthCm'])

plt.scatter(data1['SepalLengthCm'],data1['SepalWidthCm'])
####Scatter will  plot the data

variables=data1.iloc[:,0:4]
 
from sklearn.cluster import KMeans

kmeans = KMeans(n_clusters=3)

kmeans.fit(variables)

data1['clusters']=kmeans.predict(variables)
#####New variable cluster is created and we can compare the output with actual Species

wcss_1=kmeans.inertia_