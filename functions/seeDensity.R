seeDensity <- function(dataset){
  names = colnames(dataset)
  datasetClass1 = dataset[dataset$Z == 1,]
  datasetClass2 = dataset[dataset$Z == 2,]
  
  datasetClass1$Z <- NULL
  datasetClass2$Z <- NULL
  
  for (name in names){
    class1 = unlist(datasetClass1[name])
    class2 = unlist(datasetClass2[name])
    plot(density(class1),col="red")
    lines(density(class2),col="blue")
    invisible(readline(prompt="Press [enter] to continue"))
  }
}