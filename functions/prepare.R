prepare <- function(Xapp,zapp,testRate = 0.65){
  n <- dim(Xapp)[1]
  ind <- rbinom(n,1,testRate)
  Xapp <- Xapp[which(ind==1),]
  zapp <- zapp[which(ind==1)]
  Xval <- Xapp[which(ind==0),]
  zval <- zapp[which(ind==0)]
  
  out <- NULL
  out$Xapp <- Xapp
  out$zapp <- zapp
  out$Xval <- Xval
  out$zval <- zval
  
  out
}