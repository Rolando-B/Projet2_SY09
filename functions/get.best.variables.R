get.best.variables <- function(X,N=10){
  size = length(X) -1
  names = colnames(X[1:size])
  dists = matrix(0,1, size)
  colnames(dists) = names
  
  
  z = X[,length(X)]
  i = 1
  for (name in names){
    newX = cbind(scale(X[,i]),z)
    meanclass1 = mean(newX[newX[,2] == 2,][,1])
    meanclass2 = mean(newX[newX[,2] == 1,][,1])
    dists[,name] = abs(meanclass1 - meanclass2)
    i = i+1
  }
  

  
  best = apply(dists,1,sort)[(size-N):size,] 
  result = names(best)
  
  result
}