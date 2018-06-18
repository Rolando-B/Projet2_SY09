protocole2 = function (Xapp, zapp, quadraticVariables= NULL,N = 20){
  
  taux = matrix(0, N, 8)
  colnames(taux) = c("adq","adqVars", "adl", "adlVars", "nba","log", "logVars","tree")
  taux = data.frame(taux)
  
  for (i in c(0:N)){
    
    splitData = separ2(Xapp,zapp)
    datafApp = cbind(splitData$Xapp, Z=as.factor(splitData$zapp))
    datafAppVars = cbind(splitData$Xapp[quadraticVariables], Z=as.factor(splitData$zapp))
    datafVal = cbind(splitData$Xval, Z=as.factor(splitData$zval))
    datafValVars = cbind(splitData$Xval[quadraticVariables], Z=as.factor(splitData$zval))
    
    try({
      paramsAdq = qda(splitData$Xapp, factor(splitData$zapp))
      resAdq = predict(paramsAdq,splitData$Xval)
      taux$adq[i] = 1 - rand.index(as.integer(resAdq$class),splitData$zval)
    })
    paramsAdqVars = qda(splitData$Xapp[quadraticVariables], factor(splitData$zapp))
    paramsAdl = lda(splitData$Xapp, splitData$zapp)
    paramsAdlVars = lda(splitData$Xapp[quadraticVariables], splitData$zapp)
    paramsNba = naiveBayes(Z ~ .,data = datafApp)
    paramsLog = glm(Z ~.,family=binomial(link='logit'),data = datafApp)
    paramsLogVars = glm(Z ~.,family=binomial(link='logit'),data = datafAppVars)
    
    resTree = tree.app(splitData$Xapp,splitData$zapp,splitData$Xval)
    
    
    resAdqVars = predict(paramsAdqVars,splitData$Xval[quadraticVariables])
    resAdl = predict(paramsAdl,splitData$Xval)
    resAdlVars = predict(paramsAdlVars,splitData$Xval[quadraticVariables])
    resNba = predict(paramsNba,datafVal, type="class")
    resLog = predict(paramsLog,datafVal, type="response")
    resLogVars = predict(paramsLogVars,datafValVars, type="response")
    resLog <- ifelse(resLog > 0.5,1,2)
    resLog <- ifelse(resLogVars > 0.5,1,2)
    

    taux$adqVars[i] = 1 - rand.index(as.integer(resAdqVars$class),splitData$zval)
    taux$adl[i] = 1 - rand.index(as.integer(resAdl$class),splitData$zval)
    taux$adlVars[i] = 1 - rand.index(as.integer(resAdlVars$class),splitData$zval)
    taux$nba[i] = 1 - rand.index(as.integer(resNba),splitData$zval)
    taux$log[i] = 1 - rand.index(as.integer(resLog),splitData$zval)
    taux$logVars[i] = 1 - rand.index(as.integer(resLogVars),splitData$zval)
    taux$tree[i] = 1 - rand.index(as.integer(resTree$pred),splitData$zval)
    
  }
  
  result = NULL
  result$taux = taux
  result$mean = apply(taux, 2, mean)
  result$sd = apply(taux, 2, sd)
  return(result)
}