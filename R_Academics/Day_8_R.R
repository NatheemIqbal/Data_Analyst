
library('datasets')
data("iris")
View(iris)
iris_df <- data.frame(iris)

str(iris_df)

iris.X <- iris[c(1,2,3,4)]
iris.X
iris.class <- iris[,"Species"]

library(e1071)

skewness(iris.X$Sepal.Length)
skewness(iris.X$Sepal.Width)
skewness(iris.X$Petal.Length)
skewness(iris.X$Petal.Length)

boxplot(iris.X$Sepal.Length)
boxplot(iris.X$Sepal.Width)
boxplot(iris.X$Petal.Length)
boxplot(iris.X$Petal.Length)

library('Hmisc')
describe(iris.X)

cor(iris.X)

cor(as.matrix(iris.X)) ## above code also giving same result

###Scale th variable
iris.X <- scale(iris.X)
library(cluster)

result <- kmeans(iris.X,3)
result$cluster 
### The above two code seems to be a key code in classfying the predicted result

iris$cluster <- result$cluster
iris$cluster
View(iris)
####Just check if our cluster result is equal to already having result
##Using below confusion matrix
table(iris$Species,iris$cluster)

###The classification is overlapping thus Kmean clustering is not perfect to give 100% result

#######------KNN--------##############
library(datasets)
data("iris")
iris_df <- as.data.frame(iris)


iris.new <- iris[,c(1,2,3,4)]
iris.class <- iris[,("Species")]

iris.new <- scale(iris.new)

####Breaking records in train in to two in order to prepare good model intead of toggling between train and test data
###Below four quadrant is of same data set splitting 130 records as train and rest of the records as test with in train data
####value 5 below is 5th column
iris.X_train <- iris.new[1:130,]
iris.Y_train <- iris[1:130,5]

iris.Y_train


iris.X_test <- iris.new[131:150,]
iris.Y_test <- iris[131:150,5]

library("class")
model1 <-knn(train=iris.X_train,test=iris.X_train,cl=iris.Y_train)

table(iris.Y_train,model1)

####model1
##iris.Y_train setosa versicolor virginica
###setosa         50          0         0
##versicolor      0         50         0
###virginica       0          0        30


#####Let us apply the above model in remaining data within train data to predict the efficiency
####---KNN is  supervised tecchnique for classification
library("class")
model1 <- knn(train=iris.X_test,test=iris.X_test,cl=iris.Y_test)

table(iris.Y_test,model1)


########-------PCA-----------------######
##Principal Component Analysis (PCA) is used to explain the variance-covariance structure of a set of variables through linear combinations. It is often used as a dimensionality-reduction technique.

#we can't just drop some test scores randomly. That's where dimensionality reduction plays a role to reduce the number of variables without losing too much information
iris_df <- data.frame(iris)


iris.X <- iris[,c(1,2,3,4)]
iris.Y <- iris[,"Species"]
iris.X
iris.Y

PCA_MODEL <- prcomp(iris.X,scale. =T)
summary(PCA_MODEL)
PCA_MODEL$x


iris_dataset <- as.data.frame(PCA_MODEL$x)
iris_dataset$Class <- iris.Y

install.packages("randomForest")
library("randomForest")

model_1 <- randomForest(Class~., data = iris_dataset)

iris_dataset$preds <- predict(model_1,iris_dataset)
table(iris_dataset$Class, iris_dataset$preds)

#-----The PCA technique gave 100% prdiction
#Refer for more info https://towardsdatascience.com/principal-component-analysis-ceb42ed04d77
####----PCA works only for continuous data not for categorical

##setosa versicolor virginica
##setosa         50          0         0
###versicolor      0         50         0
##virginica       0          0        50
