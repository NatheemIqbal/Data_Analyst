mystring="this is a test"
print(mystring)

len(mystring)

####below will print 'h' as index stats from 0
mystring[1]

mystring[-3]

mystring[5:10]

example = mystring[5:]
example

#####Tupels############
mytuple=(11,12,13)
mytuple[1]
len(mytuple)

mytuple1=(11,78,13)
mytuple1[2]
len(mytuple1)

mytuple+= (44,)
mytuple


####For any function need to call library#####

import numpy as np
np.mean(mytuple)
np.median(mytuple)
#################

atuple=sorted(mytuple1)
atuple
newtuple = tuple('My name is khan') ##It will separate each letter##
newtuple

#####Creating own function without calling library######
def area_volume_of_cube(sidelength):
    area=2*sidelength
    volume=3*sidelength
    return area, volume

area_volume_of_cube(2)


def simple_interest(P,N,R):
    SI=P*N*R/100
    return SI

simple_interest(1000,12,10)


def compound_interest(P,n,r,t):
    CI=P*(pow((1+r/n),n*t))
    return CI

compound_interest(1000,12,10,2)