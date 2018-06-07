ceuc.val <- function(mu, Xtst)
{
	Xtst <- as.matrix(Xtst)
	dist <- distXY(Xtst,as.matrix(mu))
	apply(dist,1,which.min)
}
