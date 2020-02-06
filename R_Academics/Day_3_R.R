x<-c(6,1:3,NA,12)
x
x[x<5]
subset(x,x<5)
z<-c(6,5,-3,7)
z
which(z*z>9) ###It will display position
x<-1:10
x
y<-ifelse(x%%3==0,'Y','N')
y
h=c('M','F','l')
h
ifelse(h=='M',1,ifelse(h=='F',2,3))
###Character strings
a<-'hello'
b<-'55'
a
b
as.numeric(a)### it is kind of TO_NUMBER function of oracle
b<-as.numeric(b)
d
a<-1
c<-a+d
c
sports<-c('cricket','footbal')
sports
nchar(sports)#####char length of each element inside vector
length(sports)#####length of whole vector
sum(nchar(sports))
sports<-c('cricket','ball')
psports<-c('cricket','golf','ball')
which(sports%in%psports)
which(psports%in%sports)
####Paste
###grep
X<-c('apple','banana','cat')
X
grep('at','b',X)

word<-'apples'
substr(word,start=2,stop=5)
substr(word,start=2,stop=3)<-"b"
e <-substr(word,start=2,stop=3)<-"b"
e
word<-'app|lit'
v<-strsplit(word,split='|',fixed=TRUE)
v
v<-strsplit(word,split='|',fixed=FALSE)
v
x<-c('apple','banana')
sub('a','@',x)##replace 1st occurance
gsub('a','@',x)##replace all occurence
r<-regexpr('a',X)
r
i<-2
s<-sprintf('the cube of %d is %d',i,i^3)
s
y<-matrix(c(1,2,3,4),nrow=2,ncol=2)
y
minv<-t(y)
print(minv)

x<-rbind(y,apply(y,2,mean))
x
###Vector-single dimension
##Matrix two dimensional
##Array Multi dimensional(remember cube diagram)
#Factor is categorical

a<-letters
a
b<-factor(a)
b
str(b)
