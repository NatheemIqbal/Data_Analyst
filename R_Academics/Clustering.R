#######Clustering(When we have to predict with unsupervised data################

install.packages('tidyverse')
install.packages('cluster')
install.packages('factoextra')
library('tidyverse')
library('cluster')
library('factoextra')

##USArrests is a default data
df <- USArrests
str(df)
view(df)
sum(is.na(df))


boxplot(df$Murder)
boxplot(df$Assault)
boxplot(df$UrbanPop)
boxplot(df$Rape)

library('e1071')
skewness(df$Murder)

###Below code omit the missing data if  u dont want to impute
df<-na.omit(df)

###Assault variable is in numbers but rest variables in percentage hence
##We can scale it to rest of the variables by executing below code
df_scaled <-scale(df)
View(df_scaled)

str(df_scaled)

distance <- get_dist(df_scaled)
distance
###Visualising the data by calculating distance
fviz_dist(distance)

###Cluster model
##nstart and centers denote that they are applying group cluster of2 in 50 observations
k2 <- kmeans(df_scaled, centers=2,nstart=25)
view(k2)

df$clusters <- k2$cluster
view(df)

###CLuster  plot shows the grouping of cluster and we can take average of murders and rapes onn both cluster and can
###decide which is better than the other for classification
fviz_cluster(k2, data =df)

####We can increase the cluster number and can see as well
view(df_scaled)
k3 <- kmeans(df_scaled, centers=3,nstart=25)
fviz_cluster(k3, data =df)

df$clusters1 <- k3$cluster


k5 <- kmeans(df_scaled, centers=5,nstart=25)
fviz_cluster(k5, data =df)

####too many clusters can scrap the model as it overlaps which each othher
##So we can use elbow method to find within sum of square for clusters and can pick one which has less sum of square

###Elbow-Method
wss <- function(k) {
  kmeans(df,k,nstart=25)$tot.withinss
}

wss

###Clustering 1 to 15 values in elbow plot
k.values <-1:15
k.values
wss_values <- map_dbl(k.values,wss)
wss_values
###While plotting we found after K3 there is miniml difference as  we stop at K3
plot(k.values,wss_values)
###K3  gives three groups so we can assume and classify as high crime rates/Medium and Low


