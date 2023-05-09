# Index Number : S14210
# Name : B.M.G.G.K.Rajapaksha
# DAte : 30/06/2022

# A function to generate a random DNA sequence of size n 
# and to calculate the GC percentage.

gcContent = function(n){
  
  dnaSeq = sample(c("a","t","g","c"),n, replace =T)
  #n = length of the sequence
  
  gcCount = length(dnaSeq[dnaSeq=="g"|dnaSeq=="c"])
  gcPercent = (gcCount/n)*100
  
  cat("Random DNA sequence : ",dnaSeq,"\nTotal GC count : ", gcCount,"\nGC percentage : ",gcPercent,"%")
  
}

gcContent(10)


