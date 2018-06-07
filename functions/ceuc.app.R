ceuc.app <- function(Xapp, zapp)
{
	Xapp <- as.matrix(Xapp)
	zapp <- as.numeric(zapp)

	p <- dim(Xapp)[2]
	g <- max(zapp)

	mu <- matrix(0, nrow=g, ncol=p)

	for (k in 1:g)
	{
    ind <- zapp == k
    kvals = Xapp[as.matrix(ind),]
    grav = apply(kvals, 2, mean)
    for (i in 1:p){
      mu[k,i] = grav[i]
    }
	}
	
	mu
}
