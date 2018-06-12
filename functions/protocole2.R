protocole2 = function (Xapp, zapp, quadraticVariables= NULL,N = 20){
  
  taux = matrix(0, N, 3)
  colnames(taux) = c("adq", "adl", "nba")
  taux = data.frame(taux)
  
  for (i in c(0:N)){
    
    splitData = separ2(Xapp,zapp)
    datafApp = cbind(splitData$Xapp, Z=as.factor(splitData$zapp))
    datafVal = cbind(splitData$Xval, Z=as.factor(splitData$zval))
    if (is.null(quadraticVariables)){
      paramsAdq = qda(splitData$Xapp, factor(splitData$zapp))
      resAdq = predict(paramsAdq,splitData$Xval)
    }
    else{
      paramsAdq = qda(splitData$Xapp[quadraticVariables], factor(splitData$zapp))
      resAdq = predict(paramsAdq,splitData$Xval[quadraticVariables])
    }
    paramsAdl = lda(splitData$Xapp, splitData$zapp)
    paramsNba = naiveBayes(Z ~ .,data = datafApp)
    
    resAdl = predict(paramsAdl,splitData$Xval)
    resNba = predict(paramsNba,datafVal, type="class")
    
    taux$adq[i] = 1 - rand.index(as.integer(resAdq$class),splitData$zval)
    taux$adl[i] = 1 - rand.index(as.integer(resAdl$class),splitData$zval)
    taux$nba[i] = 1 - rand.index(as.integer(resNba),splitData$zval)
    
  }
  
  result = NULL
  result$taux = taux
  result$mean = apply(taux, 2, mean)
  result$sd = apply(taux, 2, sd)
  return(result)
}