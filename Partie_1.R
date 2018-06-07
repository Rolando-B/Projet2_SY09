library(MASS)
library(fossil)
source("functions/anadisc.R")
source("functions/mvdnorm.R")
source("functions/prob.ad.R")
source("functions/prepare.R")
source("functions/separ2.R")
source("functions/distXY.R")
source("functions/protocole.R")


#1. Cancer
cancer <- read.csv("data/breastcancer.csv", header=T)
XappCancer <- cancer[,2:31]
zappCancer <- cancer$Z
resCancer <- protocole(XappCancer,zappCancer)

#2. Ionosphere
iono <- read.csv("data/ionosphere.csv", header=T)
XappIono <- iono[,2:35]
zappIono <- iono$Z
resIono <- protocole(XappIono,zappIono)


#3. Sonar
sonar <- read.csv("data/sonar.csv", header=T)
XappSonar <- sonar[,2:61]
zappSonar <- sonar$Z
resSonar <- protocole(XappSonar,zappSonar)

#4. Spam
spam <- read.csv("data/spambase.csv", header=T)
XappSpam <- spam[,2:58]
zappSpam <- spam$Z
resSpam <- protocole(XappSpam,zappSpam)

#5. Spam 2
spam2 <- read.csv("data/spambase2.csv", header=T)
XappSpam2 <- spam2[,2:58]
zappSpam2 <- spam2$Z
resSpam2 <- protocole(XappSpam2,zappSpam2)
