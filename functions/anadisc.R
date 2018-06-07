adq.app <- function(Xapp, zapp)
{
	n <- dim(Xapp)[1]
	p <- dim(Xapp)[2]
	g <- max(unique(zapp))

	param <- NULL
	param$MCov <- array(0, c(p,p,g))
	param$mean <- array(0, c(g,p))
	param$prop <- rep(0, g)

	for (k in 1:g)
	{
		indk <- which(zapp==k)

		param$MCov[,,k] <- cov(Xapp[indk,])
		param$mean[k,] <- apply(Xapp[indk,],2,mean)
		param$prop[k] <- length(indk)/n
	}

	param
}

adl.app <- function(Xapp, zapp)
{
	n <- dim(Xapp)[1]
	p <- dim(Xapp)[2]
	g <- max(unique(zapp))

	param <- NULL
	MCov <- array(0, c(p,p))
	param$MCov <- array(0, c(p,p,g))
	param$mean <- array(0, c(g,p))
	param$prop <- rep(0, g)

	for (k in 1:g)
	{
		indk <- which(zapp==k)
		nk <- length(indk)

		MCov <- MCov + nk/n * cov(Xapp[indk,])
		param$mean[k,] <- apply(Xapp[indk,],2,mean)
		param$prop[k] <- length(indk)/n
	}

	for (k in 1:g)
	{
		param$MCov[,,k] <- MCov
	}

	param
}

nba.app <- function(Xapp, zapp)
{
	n <- dim(Xapp)[1]
	p <- dim(Xapp)[2]
	g <- max(unique(zapp))

	param <- NULL
	param$MCov <- array(0, c(p,p,g))
	param$mean <- array(0, c(g,p))
	param$prop <- rep(0, g)

	for (k in 1:g)
	{
		indk <- which(zapp==k)

		param$MCov[,,k] <- diag(diag(cov(Xapp[indk,])))
		param$mean[k,] <- apply(Xapp[indk,],2,mean)
		param$prop[k] <- length(indk)/n
	}

	param
}

ad.val <- function(param, Xtst)
{
	n <- dim(Xtst)[1]
	p <- dim(Xtst)[2]
	g <- length(param$prop)
	

	out <- NULL
  somme <- 0
	prob <- matrix(0, nrow=n, ncol=g)

	for (k in 1:g)
	{
		prob[,k] <- param$prop[k] * mvdnorm(Xtst,param$mean[k,],param$MCov[,,k])
		somme <- somme + prob[,k]
	}
	prob <- prob/somme
	pred <- max.col(prob)

	out$prob <- prob
	out$pred <- pred

	out
}
