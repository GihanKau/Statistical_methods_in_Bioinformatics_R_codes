#Lec 4 

# dimension reduction 
# dimension reduction is reduce of variables. if n<P -> high dimensions 
# dimension reduction cn be done through feature extraction and feature selection. 
# Backward, stepwise and Forward selections are the parts of feature selection.

# feature extraction -SVD (Singular value dicomposition), PCA (Principal Component analysis)
# prcomp (work also for n<p, hence work with bioinfo data)
# princomp (work only when n>p, hence not good for bioinfo)
# normally we do install.packages("package name') for package installation.
# but bioconducter does not install like this

P = matrix(c(1:6), nrow =2, ncol = 3, byrow=F)
P

Q = matrix(c(1:12),3,4)
Q
 
# transpose 
t(P)

#multiplication 
P%*%Q

# eigen values (can be asked in the exam)

A = matrix(c(11,17,22,34,20,20,20,20,20),3,3)
A

eigen(A)

# every eigen value in eigen vector has its own vector in $vectors matrix

##SVD

rnorm(10) #(random normalized 10 numbers)
rnorm(10, mean=100, sd=5)

#mvrnorm() mvrnorm = multivariate rnorm

library(MASS)
set.seed(1)
n=100

# n = sample size
# c -> mean
# matrix(c(1,0.95,0.95,1) -> standard deviation. It is a variance - covariance matrix

# y is transposed because bioinfo data has always n<d
y=t(mvrnorm(n,c(0,0), matrix(c(1,0.95,0.95,1),2,2)))
y
s = svd(y)
s
D = diag(s$d)
D
U = s$u
U
V = s$v
V

U%*%D%*%t(V) # gives the iniial dataset

s$d[1]

pc1 = s$d[1]*s$v[,1] # first diagonal element, v first column
pc1
pc2 = s$d[2]*s$v[,2]
pc2

#plot of original data
y
y[1,]
plot(y[1,],y[2,])

#PC
plot(pc1, pc2, xlim=c(-3,3), ylim=c(-3,3))

pc.res=prcomp(y, center = F, scale. = F)
pc.res
pc.res$rotation
pc.res$rotation[,1]

# How many PC's
plot(pc.res)
screeplot(pc.res, ylim=c(0,100))


################################








