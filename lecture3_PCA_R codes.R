############################# PCA #############################

# In bioinfo datasets, rows = variables & cols = instances
# Therefore we have to transpose the datasets before using  R functions.
# Most of the time, 2 principal components are use in bioinfo, cz 
# it is easy to represent the data in 2D plot. (3 PCs also can be used if necessary)

# Example you tube channel StatQuest (https://youtu.be/FgakZw6K1QQ)

# PCA example

D = matrix(c(2.5,0.5,2.2,1.9,3.1,2.3,2.0,1.0,1.5,
             1.1,2.4,0.7,2.9,2.2,3.0,2.7,1.6,1.1,
             1.6,0.9),10,2, byrow =F)
D

#transpose the dataset
DT = t(D)
DT

plot(DT[1,],DT[2,])

mean(DT[1,])
mean(DT[2,])

DT[1,]=DT[1,]-mean(DT[1,])
DT[2,]=DT[2,]-mean(DT[2,])

plot(DT[1,],DT[2,])

# covariance

cov.matrix=var(t(DT))

# calculate the eigenvalue and eigenvectors 

# eigen value is sum of squared distance

eigen(cov.matrix)

# identify the eigenvector associated with eigenvalue 0.049083
W = eigen(cov.matrix)$vectors
WT = t(W)
WT

# PCA's
DPCA = WT%*%DT
DPCA

###################### above steps are the manual steps. but we are use packages to get PCs ###############################

# prcomp in stats package

# this package not is designed for bioinfo dtasets

?prcomp

# OR can use princopm(). # this is designed for bio info

PCA = prcomp(D, center = T)
PCA$x

plot(PCA$x[,1],PCA$x[,2])

summary(PCA)

# Example: mtcars

data(mtcars)
data
str(mtcars)
prcomp(mtcars)

summary(prcomp(mtcars))

screeplot(prcomp(mtcars))

# Do not get target variables into PCs and exclude them.
# take only the x variables.


