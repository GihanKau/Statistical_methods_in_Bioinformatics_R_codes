## Distance

install.packages("devtools")
install.packages("usethis")

library(devtools)

install_github("genomicsclass/tissuesGeneExpression")

library(tissuesGeneExpression)
data(tissuesGeneExpression)
head(e)
head(tissue)

dim(e) #e contains the expression data

table(tissue) # tissue [i] tells us what tissue is represented by
# e[,i]

# to compute distances 

# 1,2 = kidney, 87 = colon

x=e[,1]
y=e[,2]
z=e[,87]

# distances
sqrt(sum((x-y)^2)) #85.8546
sqrt(sum((x-z)^2)) #122.8919

# as expeced, kidneys are closer to each other


# Distance exercies

library(tissuesGeneExpression)
data(tissuesGeneExpression)
head(e)
head(tissue)

#1. How many biological replicates for hippocampus?

table(tissue) # tissue [i] tells us what tissue is represented by e[,i]
table(tissue)['hippocampus'] # answer = 31

#2. What is the distance between sample 3 and 45?

# method one

x = e[,3]
y = e[,45]
sqrt(crossprod(x-y)) # answer = 152.5662

# method two

d = dist(t(e))
as.matrix(d)[3,45] # answer = 152.5662

#3. What is the distance between gene 210486_at and 200805_at

x = e[which(rownames(e)=='210486_at'),]
y = e[which(rownames(e)=='200805_at'),]
sqrt(crossprod(x-y)) # answer = 41.01153

#4. If you run thecommand d=as.matrix(distance(dist(e))) how many cells (rowxcol)
#will this matrix have?

#answer = 22215 X 22215. dist computes distance bw each row

#5. compute the distance bw all pair of samples
d = dist(t(e)) 
length(d) # answer = 17766



## Dimention reduction

# example - consider an example with twin height. here we simulate
# 100 2D points that represent the number of standard deviations
# each individual is from the mean height. each point is a pair of twins.

library(MASS)
set.seed(1)
n=100
y=t(mvrnorm(n,c(0,0), matrix(c(1,0.95,0.95,1),2,2)))
y
plot(y[1,],y[2,])

# without cosidering 2 height variables, we can use average height to reduce dimentions

## singular value dicomposition

library(MASS)
install.packages('rafalib')
library(rafalib)
set.seed(1)
n=100
y=t(mvrnorm(n,c(0,0), matrix(c(1,0.95,0.95,1),2,2)))
y
s = svd(y)
s

round(sqrt(2)*s$u,3) # here 3 is the decimal points of the answer

PC1 = s$d[1]*s$v[,1]
PC1
PC2 = s$d[2]*s$v[,2]
PC2

plot(PC1,PC2,xlim=c(-3,3),ylim=c(-3,3))
