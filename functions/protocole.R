protocole = function (Xapp, zapp, N = 20){
  
  taux = matrix(0, N, 3)
  colnames(taux) = c("adq", "adl", "nba")
  taux = data.frame(taux)
  
  for (i in c(0:N)){
    
    splitData = separ2(Xapp,zapp)
    
    paramsAdq = adq.app(splitData$Xapp, splitData$zapp)
    paramsAdl = adl.app(splitData$Xapp, splitData$zapp)
    paramsNba = nba.app(splitData$Xapp, splitData$zapp)

    resAdq = ad.val(paramsAdq,splitData$Xval)
    resAdl = ad.val(paramsAdl,splitData$Xval)
    resNba = ad.val(paramsNba,splitData$Xval)

    #affichage :
    #niv = c(0.2,0.5,0.8)
    #prob.ad(paramsAdq,Xapp,zapp,niv)
    #prob.ad(paramsAdl,Xapp,zapp,niv)
    #prob.ad(paramsNba,Xapp,zapp,niv)
    
    taux$adq[i] = 1 - rand.index(resAdq$pred,splitData$zval)
    taux$adl[i] = 1 - rand.index(resAdl$pred,splitData$zval)
    taux$nba[i] = 1 - rand.index(resNba$pred,splitData$zval)
    
  }
  
  result = NULL
  result$taux = taux
  result$mean = apply(taux, 2, mean)
  result$sd = apply(taux, 2, sd)
  return(result)
}