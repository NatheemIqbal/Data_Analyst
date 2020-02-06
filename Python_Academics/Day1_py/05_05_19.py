

mytuple=(11,11.8,True,"Test")
mytuple

###Dictionaries

arabic2roman = {1 : "I", 2 : "II", 3:"III",4:"IV"}
arabic2roman[1]
arabic2roman[2]
arabic2roman[3]
arabic2roman[4]

###Re-assigning and creating New Key

arabic2roman[1]='one'
arabic2roman[10]='X'


age={'Alice':12,'Bob':34}
saved=age

###DKey cannot be duplicate if given then it pick last value
age={'Alice':12,'Bob':34,'Alice':11}

##To remove specific item
a={'Alice':1,'Carol':'red'}
a.pop('Carol')

###To remove random removeness
age={'Alice':1,'Carol':'red','Nad':32}
age.popitem()

####Cloning a list nd replaccing the valie
a=[1,3,4,5]
b=a
a[0]='Changed'
b=a
####---------List and Dictionaries are mutable and not sorted, String,and tuples immutable and ordered

####Set and it takes only values not keys, removing duplictes
cset={11,12,11}
cset

####Note:  Results will vary for ( and {



##Cloning also we can do
aset ={1,2,3}
bset=aset
aset=aset|{4}

aset

bset

aset[0] ####This will return error as SET do not support Inex

####---Boolean operations on Set-------#####

aset={1,2,3,4}
bset={5,7,6,4}


##Union
aset|bset

##Intersect
aset & bset

##difference
aset-bset

##Symmetric difference
aset^bset

##############----NumPy----#################
#---Numerical Python

###Creating Ndarrays

import numpy as np
data1 =[[1,2,3,4],[5,6,7,8]]
arr1=np.array(data1)


arr1=np.array(data1)
arr1.__class__    ###Array
data1.__class__    ####List

arr1.ndim
arr1.shape
arr1.dtype

np.zeros((3,6))
np.ones((3,6))
np.random.rand(3,6)
np.arange(15).reshape(3,5)
         
np.arange(27).reshape(3,3,3) ######D array

arr = np.arange(10)
arr[4:9]   ###Slicer

arr=np.random.randn(3,5)

arr_trans=arr.T  ##Transpose converts Rows to Columns

np.sqrt(arr)
np.exp(arr)

x1=[4,2,1]
x2=[2,2,2]
np.greater_equal(x1,x2)
np.mod(x1,x2)

x1=[True,False,True,False]
x2=[True,True,False,False]
np.logical_and(x1,x2)

ar_1=np.random.rand(15)

np.mean(ar_1)
np.std(ar_1)
np.var(ar_1)
np.corrcoef(ar_1)

x=np.random.random(10)
y=np.random.random(10)
z=np.random.random(10)

a=np.array(zip(x,y,z))
b=np.array([[1,2,3],[2,3,4]])

z=np.ones((1,3))
d=np.append(b,z,axis=0)  ###------axiz 0 is row and axis 1 is column















