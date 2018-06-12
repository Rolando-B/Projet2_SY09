get.best.variables <- function(X,N=10){
  corrs = cor(X)
  num = round((N/2)+1)
  sortedCors = sort.int(corrs[,ncol(X)])
  colsTail = tail(sortedCors,num)[-num]
  colsHead = head(sortedCors,num)
  allRowNames = c(rownames(as.data.frame(colsTail)),rownames(as.data.frame(colsHead)))
  allRowNames
}