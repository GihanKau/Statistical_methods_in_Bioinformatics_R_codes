#creation of a data set

myDataSet = data.frame(Name=c("Gihan","Roshain","Thenula","Thiyarna"),Age=c(25,24,2,0))
myDataSet

#to check some value
myDataSet$Name=="Gihan"

#to print a column
myDataSet$Name

#to print a row
#[row,column]
myDataSet[1,1]
myDataSet[1,]
myDataSet[,1]

#to find the mean
mean(myDataSet$Age)

#to find a specific value (similar to where clause)
myDataSet$Name[myDataSet$Age>0]
subset(myDataSet, Age>0)

#-------------------------------------sequences---------------------------------

#to generate a number sequence

1:10

seq(2,10, by=2) # or
seq(2,10,2)

#repeating sequences 
rep(c(1,1,1,2,2,2,3,3,3), times = 2)

rep(c(1,1,1,2,2,2,3,3,3), times = 2, each=2)

rep(c(1,2,3),length.out=5)

#-----------------------------------sampling------------------------------------

sample(c("a","t","g","c"),10, replace=T)
sample(c("H","T"),10, replace = T, prob = c(0.8,0.2))

BT = c("Ama","Dhanuka","Gihan","Roshain","Sammani")
sample(BT,2)

set.seed(10)
sample(BT,2)

#-----------------------------------functions-----------------------------------

# Ex: write a function to convert Fahrenheits to Celsius

F2C = function(f){
  return(((f-32)*5)/9)
}

F2C(212)

#-----------------------------------statements---------------------------------

#if condition 

n=10
if(n>0){
  print("*")
}

# if else

n = -10
if(n>0){
  print("Positive")
}else{
  print("Negative")
}

n=5
ifelse(n>0,"Postive","Negative")


# nested if

n = 0
if(n>0){
  print("Positive")
}else if(n<0){
  print("Negative")
}else{
  print("Zero")
}

# next statement

for(i in 1:10){
  if(i==5)
    next  
  print(i)
}

# break statement

for(i in 1:10){
  if(i==5)
    break  
  print(i)
}


# for loop

for(i in 1:10){
  print(i)
}

w = c(15,12,20,35)
for(y in w){
  print(y)
}

#while loop

k = 0
while(k<5){
  print(k)
  k = k+1
}

