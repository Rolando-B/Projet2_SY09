library(e1071)
library(MASS)
library(fossil)

#Fonction d'analyse
source("functions/anadisc.R")
source("functions/mvdnorm.R")
source("functions/prob.ad.R")
source("functions/tree.rpart.R")
source("functions/prepare.R")
source("functions/separ1.R")
source("functions/distXY.R")
source("functions/logistic.R")

#Fonction principale

source("functions/protocole2.R")

#Fonctions secondaires pour éxplorer les données et selectionner les variables
source("functions/seeDensity.R")
source("functions/check.normality.R")
source("functions/check.cov.R")
source("functions/get.best.variables.R")


#1. Cancer
cancer <- read.csv("data/breastcancer.csv", header=T)

XappCancer <- cancer[,2:31]
zappCancer <- cancer$Z

quadraticVariablesCancer <- get.best.variables(cbind(XappCancer,Z = zappCancer),8)

covCancer <- cov(XappCancer)
corCancer <- cor(XappCancer)
subCovCancer <- check.cov(cancer)$same
normalityCancer <- check.normality(cancer)

resCancer <- protocole2(XappCancer,zappCancer, quadraticVariablesCancer)

resCancer$mean
resCancer$sd
plot(prcomp(XappCancer)$x[,1], prcomp(XappCancer)$x[,2], col=c("red", "blue")[zappCancer])

#2. Ionosphere
iono <- read.csv("data/ionosphere.csv", header=T)
di = names(which(diag(cov(iono)) == 0)) #On enleve la colonne dont la cov est 0
iono <- iono[,- which(names(iono) %in% di)]

XappIono <- iono[,3:34]
zappIono <- iono$Z

quadraticVariablesIono <- get.best.variables(cbind(XappIono,Z = zappIono),8)

covIonoVars<- cov(XappIono[quadraticVariablesIono])
covIono <- cov(XappIono)
subCovIono <- mean(check.cov(cbind(XappIono,Z = zappIono))$same)
corIono <- cor(XappIono)

normalityIono <- check.normality(iono[,3:35])

resIono <- protocole2(XappIono,as.integer(zappIono), quadraticVariablesIono)
resIono$mean
resIono$sd
plot(prcomp(XappIono)$x[,1], prcomp(XappIono)$x[,2], col=c("red", "blue")[zappIono])


#3. Sonar
sonar <- read.csv("data/sonar.csv", header=T)
XappSonar <- sonar[,3:61]
zappSonar <- sonar$Z

comp = princomp(XappSonar)
acpData = as.data.frame(comp$scores[,c(1:10)])

quadraticVariablesSonar <- get.best.variables(cbind(XappSonar,Z = zappSonar),10)
resSonar <- protocole2(XappSonar,zappSonar,quadraticVariablesSonar)
resSonar$mean
resSonar$sd

quadraticVariablesSonarAcp <- get.best.variables(cbind(acpData,Z = zappSonar),6)
resSonarAcp <- protocole2(acpData,zappSonar,quadraticVariablesSonarAcp)
resSonarAcp$mean
resSonarAcp$sd

covSonar <- cov(XappSonar)
subCovSonar <- mean(check.cov(cbind(XappSonar,Z = zappSonar))$same)
corSonar <- cor(XappSonar)

covSonarAcp <- cov(acpData)
subCovSonarAcp <- mean(check.cov(cbind(acpData,Z = zappSonar))$same)
corSonarAcp <- cor(acpData)

normSonar <- check.normality(sonar)


plot(prcomp(XappSonar)$x[,1], prcomp(XappSonar)$x[,2], col=c("red", "blue")[zappSonar])


#4. Spam
spam <- read.csv("data/spambase.csv", header=T)
XappSpam <- spam[,3:58]
zappSpam <- spam$Z

compSpam = princomp(XappSpam)
acpSpam = as.data.frame(compSpam$scores[,c(1:10)])

quadraticVariablesSpam <- get.best.variables(cbind(XappSpam,Z = zappSpam),8)
resSpam <- protocole2(XappSpam,zappSpam,quadraticVariablesSpam)

quadraticVariablesSpamAcp <- get.best.variables(cbind(acpSpam,Z = zappSpam),8)
resSpamAcp <- protocole2(acpSpam,zappSpam,quadraticVariablesSpamAcp)

covSpam <- cov(XappSpam)
subCovSpam <- check.cov(cbind(XappSpam,Z = zappSpam))$same
corSpam <- cor(XappSpam)

normSpam <- check.normality(spam)

plot(prcomp(XappSpam[3:54])$x[,1], prcomp(XappSpam[3:54])$x[,2], col=c("red", "blue")[zappSpam])

resSpam$mean
resSpam$sd

#5. Spam 2
spam2 <- read.csv("data/spambase2.csv", header=T)
XappSpam2 <- spam2[,3:58]
zappSpam2 <- spam2$Z

compSpam2 = princomp(XappSpam2)
acpSpam2 = as.data.frame(compSpam2$scores[,c(1:10)])

quadraticVariablesSpam2 <- get.best.variables(cbind(XappSpam2,Z = zappSpam2),8)
resSpam2 <- protocole2(XappSpam2,zappSpam2,quadraticVariablesSpam2)

quadraticVariablesSpam2Acp <- get.best.variables(cbind(acpSpam2,Z = zappSpam),8)
resSpamAcp2 <- protocole2(acpSpam2,zappSpam2,quadraticVariablesSpam2Acp)

covSpam2 <- cov(XappSpam2)
subCovSpam2 <- check.cov(cbind(XappSpam2,Z = zappSpam))$same
corSpam2 <- cor(XappSpam2)

normSpam2 <- check.normality(spam2)

plot(prcomp(XappSpam2)$x[,1], prcomp(XappSpam2)$x[,2], col=c("red", "blue")[zappSpam2])


resSpam2$mean
resSpam2$sd
