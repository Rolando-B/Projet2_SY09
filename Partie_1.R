library(e1071)
library(MASS)
source("functions/anadisc.R")
source("functions/mvdnorm.R")
source("functions/prob.ad.R")
source("functions/tree.rpart.R")
source("functions/prepare.R")
source("functions/separ2.R")
source("functions/distXY.R")
source("functions/protocole.R")
source("functions/protocole2.R")
source("functions/logistic.R")
source("functions/get.best.variables.R")


#1. Cancer
cancer <- read.csv("data/breastcancer.csv", header=T)
quadraticVariablesCancer <- get.best.variables(cancer[2:32])
XappCancer <- cancer[,2:31]
zappCancer <- cancer$Z
resCancer <- protocole2(XappCancer,zappCancer, quadraticVariablesCancer)

resCancer$mean
resCancer$sd
plot(prcomp(XappCancer)$x[,1], prcomp(XappCancer)$x[,2], col=c("red", "blue")[zappCancer])

#2. Ionosphere
iono <- read.csv("data/ionosphere.csv", header=T)
di = names(which(diag(cov(iono)) == 0)) #We remove columns with cov == 0
iono <- iono[,- which(names(iono) %in% di)]

XappIono <- iono[,3:34]
zappIono <- iono$Z
quadraticVariablesIono <- get.best.variables(cbind(XappIono,Z = zappIono),8)
resIono <- protocole2(XappIono,as.integer(zappIono), quadraticVariablesIono)
resIono$mean
resIono$sd
plot(prcomp(XappIono)$x[,1], prcomp(XappIono)$x[,2], col=c("red", "blue")[zappIono])


#3. Sonar
sonar <- read.csv("data/sonar.csv", header=T)
XappSonar <- sonar[,3:61]
zappSonar <- sonar$Z
quadraticVariablesSonar <- get.best.variables(cbind(XappSonar,Z = zappSonar),10)
resSonar <- protocole2(XappSonar,zappSonar,quadraticVariablesSonar)
resSonar$mean
resSonar$sd
plot(prcomp(XappSonar)$x[,1], prcomp(XappSonar)$x[,2], col=c("red", "blue")[zappSonar])


#4. Spam
spam <- read.csv("data/spambase.csv", header=T)
XappSpam <- spam[,3:58]
zappSpam <- spam$Z
quadraticVariablesSpam <- get.best.variables(cbind(XappSpam,Z = zappSpam),8)
resSpam <- protocole2(XappSpam,zappSpam,quadraticVariablesSpam)

plot(prcomp(XappSpam[3:54])$x[,1], prcomp(XappSpam[3:54])$x[,2], col=c("red", "blue")[zappSpam])

resSpam$mean
resSpam$sd

#5. Spam 2
spam2 <- read.csv("data/spambase2.csv", header=T)
XappSpam2 <- spam2[,3:58]
zappSpam2 <- spam2$Z
quadraticVariablesSpam2 <- get.best.variables(cbind(XappSpam2,Z = zappSpam2),8)
resSpam2 <- protocole2(XappSpam2,zappSpam2,quadraticVariablesSpam2)

plot(prcomp(XappSpam2)$x[,1], prcomp(XappSpam2)$x[,2], col=c("red", "blue")[zappSpam])


resSpam2$mean
resSpam2$sd
