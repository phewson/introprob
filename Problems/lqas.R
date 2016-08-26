

#### This computes the likelihood
like <- function(p,w,n,sw,z,x0){
  if (w > 0){
    kernel <- p^w * (1-p)^((n-w)*(x0+1)+ sw)
    prob <- factorial(n) * 1/((factorial(n-w) *  prod(factorial(z))) ) * kernel}else{
      prob <- (1-p)^((n-w)*(x0+1)+ sw)}
  return(prob)
}

#curve(like(x,output1$w, output1$n, output1$sw, output1$z, output1$x0), from = 0, to = 0.3)

### This crunches the numbers to get binomial results from the posterior
binpost <- function(bign, bigx, threshold){
  apost = bigx +1
  bpost <- bign - bigx + 10
  TheResults <- rep(0,5)
  ##curve(dbeta(x, apost, bpost))
  TheResults[1] <- pbeta(threshold, apost, bpost, lower.tail = FALSE)
  TheResults[2] <- qbeta(0.025, apost, bpost)
  TheResults[3] <- qbeta(0.5, apost, bpost)
  TheResults[4] <- qbeta(0.975, apost, bpost)
  TheResults[5] <- pbeta(threshold, apost, bpost, lower.tail = TRUE)
  names(TheResults) <- c("P>0.1", "2.5", "Med", "97.5", "P>1")
  return(TheResults)
}


### This crunches numbers to get the geometric posterior
geompost <- function(posterior, threshold){
  TheResults <- rep(0,5)
  TheResults[1] <- length(posterior[posterior > threshold])/length(posterior)
  TheResults[2] <- quantile(posterior, .025)
  TheResults[3] <- quantile(posterior, .5)
  TheResults[4] <- quantile(posterior, 0.975)
  TheResults[5] <- length(posterior[posterior <= threshold])/length(posterior)
  names(TheResults) <- c("P>0.1", "2.5", "Med", "97.5", "P>1")
  return(TheResults)
}

### This drives the simulation and collects the summary statistics
simit <- function(p=0.1, n=30,m=30,x0=30){
  pop <- rbinom((n*m), 1, p)
  samp30t30 <- sum(pop)
  samp33t6 <- sum(sample(pop, 198))
  samp67t3 <- sum(sample(pop, 201))
  lqas1 <- qbinom(0.1, 198, 0.1)
  lqas2 <- qbinom(0.1, 201, 0.1)
  lqas3 <- qbinom(0.1, 900, 0.1)
  #sum(dbinom(c(0:samp33t6), 198, 0.1))
  
  popm <- matrix(pop, n, m)
  popm <- cbind(popm, rep(1, m))
  
  x <- apply(popm, 1, function(x)  min(which(x ==1)))
  
  ## next, we extract the sufficient statistics
  ## Not convinced that this is right!!!!!
  w <- length(x[x <= x0])
  sw <- sum(x[x <= x0])
  tij <- factor(x)
  z <- as.vector(xtabs(~tij))#[xtabs(~tij) > 1])
  ## because I've coded 31 for truncation, I need to remove truncations
  if (length(z) > 1){z <- z[-length(z)]}else{z<-0}
  
  ## this is the mle which I ought to collect for collation
  mlecg <- w/ ( n * (x0+1) - w * x0 + sw)
  
  return(list(mlecg=mlecg, n=n, z=z, popm=popm,w=w,sw=sw, x0=x0, samp30t30=samp30t30, samp67t3=samp67t3, samp33t6=samp33t6))
}



## now a little rejection sampler
rejsamp <- function(postreps = 1000, sumstats){  
  wl <- sumstats$w
  nl <- sumstats$n
  swl <- sumstats$sw
  zl <- sumstats$z
  mlecgl <- sumstats$mlecg
  x0l <- sumstats$x0
  posterior <- rep(NA,postreps)
  for (i in 1:postreps){
    pstar <- rbeta(1, 1, 5)
    likerat <- like(pstar,wl,nl,swl,zl,x0l)/like(mlecgl,wl,nl,swl,zl,x0l)
    u <- runif(1)
    if (u < likerat) posterior[i] = pstar
  }
  
  ## this seems very naughty now calling the globa environment
  posterior <- na.omit(posterior)
  return(posterior)
}




###### Now I am running a simulation
n <- x0 <- 30 ## number of individuals in sample
m <- 30 ## number of samples
ureps <- 200 ## number of levels
rreps <- 100 ## replicates within a level
threshold <- 0.1 ## this is the intervention level
postreps <- 10000 ## number of reps needed for the posterior
posterior <- rep(NA, postreps)



###### This seems to work functionally.
###### Alternative censoring strategy not hardwired.

output1 <- simit(p=0.1)
posterior <- rejsamp(1000, output1)
hist(posterior)
round(binpost(bigx = output1$samp30t30, bign=900, threshold = 0.1),3)
round(binpost(bigx = output1$samp67t3, bign=201, threshold = 0.1),3)
round(binpost(bigx = output1$samp33t6, bign=198, threshold = 0.1),3)
geompost(posterior, threshold = 0.1)


### Now I'm trying to extract information from the various posterior distributions.
## collate some crude and some rejection sampler based stats
## These must be binomial posteriors??????

## Need apost and bpost for the other designs!!!!!!!





x.g <- matrix("numeric", (ureps*rreps), 6)
x.b30 <- matrix("numeric", (ureps*rreps), 6)
x.b67 <- matrix("numeric", (ureps*rreps), 6)
x.b33 <- matrix("numeric", (ureps*rreps), 6)




pee <- rep(seq(from = 0.01, to = 0.3, length = ureps),rreps)

for (i in 1:(ureps*rreps)){
  
  #i <- 3
  
  output1 <- simit(pee[i])
  posterior <- rejsamp(1000, output1)
  x.b30[i,c(1:5)] <- (binpost(bigx = output1$samp30t30, bign=900, threshold = 0.1))
  x.b67[i,c(1:5)] <- (binpost(bigx = output1$samp67t3, bign=201, threshold = 0.1))
  x.b33[i,c(1:5)] <- (binpost(bigx = output1$samp33t6, bign=198, threshold = 0.1))
  x.g[i,c(1:5)] <- geompost(posterior, threshold = 0.1)
  x.b30[i,6] <- ifelse(output1$samp30t30>=78,1,0)
  x.b67[i,6] <- ifelse(output1$samp67t3>14,1,0)
  x.b33[i,6] <- ifelse(output1$samp33t6>13,1,0)
  cat(i)
  cat("\t")
}


par(mfrow = c(2,2))
plot(pee[1:200], x.g[1:200,3], pch = 16, ylim = c(0,0.4), bty="n", xlab = "Simulated proportion", ylab = "Estimated proportion", main = "Geometric scheme")
arrows(x0=pee[1:200], y0=as.numeric(x.g[1:200,3]), y1= as.numeric(x.g[1:200,4]), length = 0.001)
arrows(x0=pee[1:200], y0=as.numeric(x.g[1:200,3]), y1= as.numeric(x.g[1:200,2]), length = 0.001)

plot(pee[1:200], x.b30[1:200,3], pch = 16, ylim = c(0,0.4), bty="n", xlab = "Simulated proportion", ylab = "Estimated proportion", main = "30 by 30 scheme")
arrows(x0=pee[1:200], y0=as.numeric(x.b30[1:200,3]), y1= as.numeric(x.b30[1:200,4]), length = 0.001)
arrows(x0=pee[1:200], y0=as.numeric(x.b30[1:200,3]), y1= as.numeric(x.b30[1:200,2]), length = 0.001)

plot(pee[1:200], x.b67[1:200,3], pch = 16, ylim = c(0,0.4), bty="n", xlab = "Simulated proportion", ylab = "Estimated proportion", main = "67 by 3 scheme")
arrows(x0=pee[1:200], y0=as.numeric(x.b67[1:200,3]), y1= as.numeric(x.b67[1:200,4]), length = 0.001)
arrows(x0=pee[1:200], y0=as.numeric(x.b67[1:200,3]), y1= as.numeric(x.b67[1:200,2]), length = 0.001)

plot(pee[1:200], x.b33[1:200,3], pch = 16, ylim = c(0,0.4), bty="n", xlab = "Simulated proportion", ylab = "Estimated proportion", main = "33 by 6 scheme")
arrows(x0=pee[1:200], y0=as.numeric(x.b33[1:200,3]), y1= as.numeric(x.b33[1:200,4]), length = 0.001)
arrows(x0=pee[1:200], y0=as.numeric(x.b33[1:200,3]), y1= as.numeric(x.b33[1:200,2]), length = 0.001)


par(mfrow = c(2,2))
plot(pee, x.g[,1], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p>0.1", main = "Geometric scheme")
abline(v=0.1)
plot(pee, x.b30[,1], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p>0.1", main = "30 by 30 scheme")
abline(v=0.1)
plot(pee, x.b67[,1], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p>0.1", main = "67 by 3 scheme")
abline(v=0.1)
plot(pee, x.b33[,1], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p>0.1", main = "33 by 6 scheme")
abline(v=0.1)


par(mfrow = c(2,2))
plot(pee, x.g[,5], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p<0.1", main = "Geometric scheme")
abline(v=0.1)
plot(pee, x.b30[,5], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p<0.1", main = "30 by 30 scheme")
abline(v=0.1)
plot(pee, x.b67[,5], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p<0.1", main = "67 by 3 scheme")
abline(v=0.1)
plot(pee, x.b33[,5], pch = ".", xlab = "Simulated proportion", ylab = "Posterior Prob p<0.1", main = "33 by 6 scheme")
abline(v=0.1)

b30lqas <- aggregate(x= as.numeric(x.b30[,6]), by = list(pee=pee), FUN=function(x)sum(x)/100)
b33lqas <- aggregate(x= as.numeric(x.b33[,6]), by = list(pee=pee), FUN=function(x)sum(x)/100)
b67lqas <- aggregate(x= as.numeric(x.b67[,6]), by = list(pee=pee), FUN=function(x)sum(x)/100)

par(mfrow = c(1,1))
grule <- aggregate(x= as.numeric(x.g[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.05]) )
b30rule <- aggregate(x= as.numeric(x.b30[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.05]) )
b67rule <- aggregate(x= as.numeric(x.b67[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.05]) )
b33rule <- aggregate(x= as.numeric(x.b33[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.05]) )


b30lqas <- aggregate(x= as.numeric(x.b30[,6]), by = list(pee=pee), FUN=function(x)sum(x)/100)




plot(grule[,1], grule[,2], cex=0.4, xlab="Simulated prevalence", ylab = "Percentage of alerts", pch = 16)
points(b30lqas[,1],b30lqas[,2]*100, pch= 8, col = "red", cex = 0.4)
points(b33lqas[,1],b33lqas[,2]*100, pch= 8, col = "blue")
points(b67lqas[,1],b67lqas[,2]*100, pch= 8, col = "green")
lines(lowess(grule[,1], grule[,2], f = 0.1), lwd = 2, lty = 2)
points(b30rule[,1], b30rule[,2], pch = 16, cex = 0.4, col = "red")
lines(lowess(b30rule[,1], b30rule[,2], f = 0.1), lwd = 2, col = "red")
points(b67rule[,1], b67rule[,2], pch = 2, cex = 0.4, col="blue")
lines(lowess(b67rule[,1], b67rule[,2], f = 0.1), lwd = 2, lty  = 3, col = "blue")
points(b33rule[,1], b33rule[,2], pch = 3, cex = 0.4, col = "green")
lines(lowess(b33rule[,1], b33rule[,2], f = 0.1), lwd = 2, lty = 4, col = "green")

abline(h=90)

par(mfrow = c(1,1))
grule <- aggregate(x= as.numeric(x.g[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.4]) )/100
b30rule <- aggregate(x= as.numeric(x.b30[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.4]) )/100
b67rule <- aggregate(x= as.numeric(x.b67[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.4]) )/100
b33rule <- aggregate(x= as.numeric(x.b33[,1]),by = list(pee=pee),FUN=function(x)length(x[x>0.4]) )/100



plot(grule[,1], 100*grule[,2], cex=0.4, xlab="Simulated prevalence", ylab = "Percentage of alerts")
lines(lowess(grule[,1], 100*grule[,2], f = 0.1), lwd = 2, lty = 2)
points(b30rule[,1], 100*b30rule[,2], pch = 16, cex = 0.4, col = "red")
lines(lowess(b30rule[,1], 100*b30rule[,2], f = 0.1), lwd = 2, col = "red")
points(b67rule[,1], 100*b67rule[,2], pch = 2, cex = 0.4, col="blue")
lines(lowess(b67rule[,1], 100*b67rule[,2], f = 0.191), lwd = 2, lty  = 3, col = "blue")
points(b33rule[,1], 100*b33rule[,2], pch = 3, cex = 0.4, col = "green")
lines(lowess(b303ule[,1], 100*b33rule[,2], f = 0.5), lwd = 2, lty = 4)






