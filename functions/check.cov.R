check.cov <- function(dataset){
  names = colnames(dataset)
  datasetClass1 = dataset[dataset$Z == 1,]
  datasetClass2 = dataset[dataset$Z == 2,]
  
  covClass1 = cov(datasetClass1)
  covClass2 = cov(datasetClass2)
  
  res <- NULL
  res$same = covClass1 - covClass2
  res$class1 = covClass1
  res$class2 = covClass2
  
  res
}