#Name       : B.M.G.G.K. Rajapaksha
#Index No.  : S14210
#Date       : 16/08/2022
#Assignment : Quiz on PCA

##Question 1 - Carry out a principal component analysis using both princomp() and prcomp() functions.

##Using prcomp

#Categorical variables were excluded, because PCA works best with numerical data.

#Arguments for prcomp will center and autoscale the data before doing the key computation.
PCA.prco = prcomp(mtcars[,c(1:7,10,11)], center=T, scale. = T)
PCA.prco

##Using princomp

#Categorical variables were excluded, because PCA works best with numerical data.

#For princomp, the data will be centered and the correlation matrix compared and analyzed.
PCA.princo = princomp(mtcars[,c(1:7,10,11)], cor = T)
PCA.princo

##Question 2 - Giving reasons, identify the number of PCA's to go with.

##Using prcomp
summary(PCA.prco)
screeplot(PCA.prco)

##Using princomp
summary(PCA.princo)
screeplot(PCA.princo)

#Explanation - Accoding to the both functions, PC1 and PC2 explain a large portion 
#of the variance = 0.6007637+0.2409516 = 0.8417153. Subsequent principal components 
#explain much less. This would suggest that the PC1 and PC2 are enough to explain 
#the data well with the large portion of the variance. Moreover steep elbow bend
#after the PC2 in the screeplots is also confirm this conclusion.

##Question 3 - Obtain the factor loadings.

##Using prcomp
PCA.prco$rotation

##Using princomp
PCA.princo.loads = matrix(PCA.princo$loadings, ncol = 9, byrow = F)
PCA.princo.loads

##Question 4 - Write down the PCA's as a linear combination of the variables.

##Using prcomp
PCA.prco$x

##Using princomp
PCA.princo$scores




