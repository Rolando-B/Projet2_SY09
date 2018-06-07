kppv.val <- function(Xapp, zapp, K, Xtst)
{
	Xapp <- as.matrix(Xapp)
	zapp <- as.numeric(zapp)
	Xtst <- as.matrix(Xtst)

	napp <- dim(Xapp)[1]
	ntst <- dim(Xtst)[1]
	p <- dim(Xapp)[2]
	g <- max(zapp)

	# calcul des distances 
	d2 <- distXY(Xtst, Xapp)
	d2sor <- t(apply(d2, 1, sort))

	# distance seuil (distance au Kieme plus proche voisin) 
	seuil <- d2sor[,K]

	# plus proches voisins 
	is.ppv <- (d2<=matrix(rep(seuil,napp),nrow=ntst,byrow=F))
    # classes des K plus proches voisins
	cl.ppv <- matrix(rep(zapp,ntst),nrow=ntst,byrow=T)*is.ppv

	scores <- matrix(0,nrow=ntst,ncol=g)
	for (k in 1:g)
	{
		scores[,k] <- apply(cl.ppv==k,1,sum)
	}

	# classement en fonction du centre le plus proche 
	zpred <- apply(scores, 1, which.max)
}
