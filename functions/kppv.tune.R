kppv.tune <- function(Xapp, zapp, Xval, zval, nppv)
{
	taux <- rep(0,length(nppv))

	ind <- 0
	for (k in nppv)
	{
		ind <- ind+1
    kppv = kppv.val(Xapp,zapp,k,Xval)
    taux[ind] = adjustedRandIndex(kppv,zval)
	}
  
	nppv[which.max(taux)]
}
