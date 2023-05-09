DNA1 = c("ATCGGGGCTAACTGG")
DNA1

DNA2 = sample(c("A","T","G","C"),10, replace=T, prob=c(0.1,0.4,0.4,0.1))
DNA2


#Count GC percentage

sum(DNA2=='G')+sum(DNA2=='C') #or
sum(DNA2=='G' | DNA2=='C')/length(DNA2)*100


## Count GC content b using an inbuilt function 

install.packages("seqinr")
library(seqinr)

?seqinr

GC(DNA2) #GC inbuilt function in seqinr

## Conversion of a string into a vector of chars

#convert a single string such as "BigBang" into a vector of chars such as c("B", "i", "g", "B", "a", "n", "g")

s2c(c("BigBang"))
?s2c

#opposite side of the s2c
c2s(DNA2)

#without using seqinr pkg, to collapse 

paste(DNA2, collapse ="")




################################################# Statistical analysis #########################################################
## Change directory 

getwd()
setwd("D:/Degree notes/Fourth year/First sem/BT 4019  - Statistical Methods in Bioinformatics")
getwd()
dir()

## red csv data

dietData=read.csv("femaleMiceWeights.csv")
dietData

#compute the avg body weight in each group

mean(dietData$Bodyweight[dietData$Diet=="chow"])
median(dietData$Bodyweight[dietData$Diet=="chow"])

mean(dietData$Bodyweight[dietData$Diet=="hf"])
median(dietData$Bodyweight[dietData$Diet=="hf"])

mean(dietData)

#separate groups

control = dietData[dietData$Diet=="chow",]
control
treatment = dietData[dietData$Diet=="hf",]
treatment

# Difference of the means bw two groups

mean(control$Bodyweight) - mean(treatment$Bodyweight) #-3.020833

## is there a significant difference bw means (t-test)

# Graphical representation of variables

hist(dietData$Bodyweight)
boxplot(dietData$Bodyweight~dietData$Diet)

# if data points are similarly distributed around the middle line, it is said to be
# normalized
qqnorm(treatment$Bodyweight)
qqline(treatment$Bodyweight, col="blue", lwd=2)

## test statistics

# t - test

t.test(control$Bodyweight, treatment$Bodyweight) 
# if p - value is > 0.05, alternative hypo is rejected (alternative hypo = true difference in means is not equal to 0)
# that means if p>0.05, the mean difference is not statistically significant at 5%

## normalizing data

control.StdBodyweight = scale(control$Bodyweight)
control.StdBodyweight

# sd mean of control bodyweight = 23.81333
# sd variance of control bodyweight = 3.022541

treatment.StdBodyweight = scale(treatment$Bodyweight)
treatment.StdBodyweight

# sd mean of treatment bodyweight = 26.83417
# sd variance of treatment bodyweight =4.097606

## if the t-testassumptions are violated use non parametric t-test

# non parametric t-test = Wilcoxn test

wilcox.test(control$Bodyweight, treatment$Bodyweight)


