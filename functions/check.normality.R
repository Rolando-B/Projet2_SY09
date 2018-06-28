check.normality <- function(dataset){
  len = dim(dataset)[2]
  res = matrix(0,2,len)
  names = colnames(dataset)
  colnames(res) = names
  
  datasetClass1 = dataset[dataset$Z == 1,]
  datasetClass2 = dataset[dataset$Z == 2,]
  
  datasetClass1$Z <- NULL
  datasetClass2$Z <- NULL
  
  resClass1 = apply(datasetClass1,2, function(x) shapiro.test(x)$p.value)
  resClass2 = apply(datasetClass2,2,function(x) shapiro.test(x)$p.value)
  
  i=1
  for (name in names){
    res[1,i] = resClass1[name]
    i = i+1
  }
  i=1
  for (name in names){
    res[2,i] = resClass2[name]
    i = i+1
  } 
  
  res
}