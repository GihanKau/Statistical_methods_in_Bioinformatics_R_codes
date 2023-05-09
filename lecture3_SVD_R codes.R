#from lecture 2
#######################################singular value decomposition############################################

library(MASS)

#n = sample size
#c(0,0) = sample mean vector
#matrix(c(1,0.95,0.95,1),2,2) = sample co variance vector
#t = transpose of vector

n=100
y = t(mvrnorm(n,c(0,0), matrix(c(1,0.95,0.95,1),2,2)))
y

svd(y)
c(0,0)

# Lecture 3 started from here

A=matrix(c(4,-5,-1,
           7,-2,3,
           -1,4,-3,
           8,2,6),4,3,byrow=TRUE) # 4x3 matrix
A

## Single value decomposition - to dimension reduction

# A can be represent as; A= u*d*v(transpose)
# d is a diagonal matrix. u and v are orthogonal matrixes which mmeans perpendicular to
# each other. u,d,v matixes can be found using svd(A)

z=svd(A)

u=matrix(c(-0.2816569,0.7303849,-0.424123264,
           -0.5912537,0.1463017,-0.18371213,
           0.2247823,-0.4040717,-0.88586638,
           -0.7214994,-0.5309048,0.04012567),4,3,byrow=TRUE)
u

d=matrix(c(13.161210,0,0,
           0,6.999892,0,
           0,0,3.432793),3,3,byrow=TRUE)

d

v=matrix(c(-0.8557101,0.01464091,-0.5172483,
           0.1555269,-0.94610374,-0.2840759,
           -0.4935297,-0.32353262 ,0.8073135),3,3,byrow=TRUE)
v

t=t(v)


round(u%*%d%*%t)  # * is used to element wise multiplication and %*% is used to
                  # matrix multiplication

# This one can also be taken as

z$u%*%diag(z$d)%*%t(z$v) # same answer

# how to extract columns which provide more variation

z$d**2 #this gives the sqroot of the d matrix

#prop.table() function gives the proportion of the given value to the sum of the values 
#in a given matrix)

prop.table(z$d)
prop.table(z$d**2) # 0.74024550 0.20939524 0.05035926


###############################SVD examples###############################

#Reference link = https://www.displayr.com/singular-value-decomposition-in-r/

#---------------------Row data table--------------------------------------

education.by.readership = matrix(c(5, 18, 19, 
                                   12, 3, 7, 
                                   46, 29, 40, 
                                   7, 2, 20, 
                                   39, 49, 16), 
                                 nrow = 5,
                                 dimnames = list(
                                   "Level of education" = c("Some primary", "Primary completed", "Some secondary", "Secondary completed", "Some tertiary"),
                                   "Category of readership" = c("Glance", "Fairly thorough", "Very thorough"))) 
education.by.readership

#---------------------Standardizing the row data--------------------------

sum(education.by.readership)


O = education.by.readership / sum(education.by.readership)
O

rowSums(O)
colSums(O)

E = rowSums(O) %o% colSums(O)
E


sqrt(E)

Z = (O - E) / sqrt(E)
Z


#---------------------- Compute SVD---------------------------------------

# SVD, contains one vector, d, and two matrices, u and v. 
# Vector, d, contains the singular values (eigen values) and D is a diagonal matrix 
# u contains the left singular vectors, represent the rows of the input table
# v contains the right singular vectors. represent their columns.

# hence a matrix can be represened as M = uDV(transpose)


SVD = svd(Z)
SVD


#--------------------- Uses of SVD----------------------------------------

####### 1. Recovering data 

# to get the value of -0.064751 in the 5th row, 2nd column
SVD$u[5, ]
SVD$v[2, ]
sum(SVD$d * SVD$u[5, ] * SVD$v[2, ])

# to get the whole table again 
SVD$u %*% diag(SVD$d) %*% t(SVD$v)

####### 2. Reducing the data

# this is related to the d
# the values in d are sorted in descending order (ties are possible).
# Why is this important? The last value in d is 2.71825390754254E-17. In reality, this is 0
# When recovering the data, we can ignore the last value of d
# And also the last column of each of u and v.
# Their values are multiplied by 0 and thus are irrelevant.

# initially we have 15 data points. after SVD we have 27 data point in u,v and d.
# if we ignore the last value of d, and last column of each u and v, then we have only 18
# values to be consider.



variance.explained = prop.table(svd(Z)$d**2)
variance.explained

# here, assume that there are 3 points in d matrix. If we select first 2 values in d matrix 
# out of the three values, we only consider the first 2 columns of each U and V matixes.

SVD$u[,1:2] %*% diag(SVD$d[1:2]) %*% t(SVD$v[,1:2])
SVD$u[,1:2] %*% (diag(SVD$d))[1:2,1:2] %*% t(SVD$v[,1:2])



#sum(variance.explained) = 1

# in here we can see (84.51%, 15.48%) of variances are explained.
# if we want only 84.51%, we can only take the first columns of the all u,v and d.
# hence we have to consider only 9 data points instead of 15 in the row data points.


# Bike example- https://rpubs.com/Tanmay007/svd

