protocole2 = function (Xapp, zapp, quadraticVariables= NULL,N = 20){
  
  taux = matrix(0, N, 7)
  colnames(taux) = c("adq","adqVars", "adl", "adlVars", "nba","log","tree")
  taux = data.frame(taux)
  
  for (i in c(1:N)){
    
    splitData = separ1(Xapp,zapp)
    
    datafApp = cbind(splitData$Xapp, Z=as.factor(splitData$zapp))
    datafAppVars = cbind(splitData$Xapp[quadraticVariables], Z=as.factor(splitData$zapp))
    datafVal = cbind(splitData$Xtst, Z=as.factor(splitData$ztst))
    datafValVars = cbind(splitData$Xtst[quadraticVariables], Z=as.factor(splitData$ztst))
    
    try({
      paramsAdq = qda(splitData$Xapp, factor(splitData$zapp))
      resAdq = predict(paramsAdq,splitData$Xtst)
      taux$adq[i] = 1 - rand.index(as.integer(resAdq$class),splitData$ztst)

    })

    paramsAdqVars = qda(splitData$Xapp[quadraticVariables], factor(splitData$zapp))
    paramsAdl = lda(splitData$Xapp, splitData$zapp)
    paramsAdlVars = lda(splitData$Xapp[quadraticVariables], splitData$zapp)
    paramsNba = naiveBayes(Z ~ .,data = datafApp)
    paramsLog = glm(Z ~.,family=binomial(link='logit'),data = datafApp)

    resTree = tree.app(splitData$Xapp,splitData$zapp,splitData$Xtst)
    
    
    resAdqVars = predict(paramsAdqVars,splitData$Xtst[quadraticVariables])
    resAdl = predict(paramsAdl,splitData$Xtst)
    resAdlVars = predict(paramsAdlVars,splitData$Xtst[quadraticVariables])
    resNba = predict(paramsNba,datafVal, type="class")
    resLog = predict(paramsLog,datafVal, type="response")
    resLog <- ifelse(resLog > 0.5,1,2)

    taux$adqVars[i] = 1 - rand.index(as.integer(resAdqVars$class),splitData$ztst)
    taux$adl[i] = 1 - rand.index(as.integer(resAdl$class),splitData$ztst)
    taux$adlVars[i] = 1 - rand.index(as.integer(resAdlVars$class),splitData$ztst)
    taux$nba[i] = 1 - rand.index(as.integer(resNba),splitData$ztst)
    taux$log[i] = 1 - rand.index(as.integer(resLog),splitData$ztst)
    taux$tree[i] = 1 - rand.index(as.integer(resTree$pred),splitData$ztst)
    
  }
  
  result = NULL
  result$taux = taux
  result$mean = round(apply(taux, 2, function(x) mean(x[x>0])),digits=2)
  result$sd = round(apply(taux, 2, function(x) sd(x[x>0])),digits=2)
  return(result)
}