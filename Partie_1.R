library(e1071)
library(MASS)
library(fossil)
source("functions/anadisc.R")
source("functions/mvdnorm.R")
source("functions/prob.ad.R")
source("functions/prepare.R")
source("functions/separ2.R")
source("functions/distXY.R")
source("functions/protocole.R")
source("functions/protocole2.R")
source("functions/get.best.variables.R")


#1. Cancer
cancer <- read.csv("data/breastcancer.csv", header=T)
quadraticVariablesCancer <- get.best.variables(cancer[2:32])
XappCancer <- cancer[,2:31]
zappCancer <- cancer$Z
resCancer <- protocole2(XappCancer,zappCancer, quadraticVariablesCancer)

#2. Ionosphere
iono <- read.csv("data/ionosphere.csv", header=T)
di = names(which(diag(cov(iono)) == 0)) #We remove columns with cov == 0
iono <- iono[,- which(names(iono) %in% di)]

XappIono <- iono[,3:34]
zappIono <- iono$Z
quadraticVariablesIono <- get.best.variables(cbind(XappIono,Z = zappIono),8)
resIono <- protocole2(XappIono,as.integer(zappIono), quadraticVariablesIono)


#3. Sonar
sonar <- read.csv("data/sonar.csv", header=T)
XappSonar <- sonar[,3:61]
quadraticVariablesSonar <- get.best.variables(XappSonar)
zappSonar <- sonar$Z
resSonar <- protocole2(XappSonar,zappSonar,quadraticVariablesSonar)

#4. Spam
spam <- read.csv("data/spambase.csv", header=T)
XappSpam <- spam[,3:58]
quadraticVariablesSpam <- get.best.variables(XappSpam)
zappSpam <- spam$Z
resSpam <- protocole2(XappSpam,zappSpam,quadraticVariablesSpam)

#5. Spam 2
spam2 <- read.csv("data/spambase2.csv", header=T)
XappSpam2 <- spam2[,3:58]
quadraticVariablesSpam2 <- get.best.variables(XappSpam2)
zappSpam2 <- spam2$Z
resSpam2 <- protocole2(XappSpam2,zappSpam2,quadraticVariablesSpam2)
