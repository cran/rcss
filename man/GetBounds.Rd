\name{GetBounds}
\alias{GetBounds}
\title{Confidence Bounds}
\description{Confidence bounds for the value.}
\usage{
GetBounds(duality, alpha, position)
}
\arguments{
  \item{duality}{Object returned by the Duality function.}
  \item{alpha}{Specifies the (1-alpha) confidence bounds.}
  \item{position}{Natural number indicating the starting position.}
}
\value{
  Array representing the (1-alpha) confidence bounds for the value
  of the specified position.
}
\examples{
## Bermuda put option
grid <- as.matrix(cbind(rep(1, 81), c(seq(20, 60, length = 81))))
disturb <- array(0, dim = c(2, 2, 100))
disturb[1, 1,] <- 1
quantile <- qnorm(seq(0, 1, length = (100 + 2))[c(-1, -(100 + 2))])
disturb[2, 2,] <- exp((0.06 - 0.5 * 0.2^2) * 0.02 + 0.2 * sqrt(0.02) * quantile)
weight <- rep(1 / 100, 100)
control <- matrix(c(c(1, 2),c(1, 1)), nrow = 2)
reward <- array(data = 0, dim = c(81, 2, 2, 2, 50))
in_money <- grid[, 2] <= 40
reward[in_money, 1, 2, 2,] <- 40
reward[in_money, 2, 2, 2,] <- -1
for (tt in 1:50){
  reward[,,2,2,tt] <- exp(-0.06 * 0.02 * (tt - 1)) * reward[,,2,2,tt] 
}
scrap <- array(data = 0, dim = c(81, 2, 2))
scrap[in_money, 1, 2] <- 40
scrap[in_money, 2, 2] <- -1
scrap[,,2] <- exp(-0.06 * 0.02 * 50) * scrap[,,2]
r_index <- matrix(c(2, 2), ncol = 2)
bellman <- FastBellman(grid, reward, scrap, control, disturb, weight, r_index)
suppressWarnings(RNGversion("3.5.0"))
set.seed(12345)
start <- c(1, 36) ## starting state
path_disturb <- array(0, dim = c(2, 2, 100, 50))
path_disturb[1, 1,,] <- 1
rand1 <- sample(quantile, 100 * 50 / 2, TRUE)
rand1 <- as.vector(rbind(rand1, -rand1))  ## anti-thetic disturbances
path_disturb[2, 2,,] <- exp((0.06 - 0.5 * 0.2^2) * 0.02 + 0.2 * sqrt(0.02) * rand1)
path <- PathDisturb(start, path_disturb)
## Reward function
RewardFunc <- function(state, time) {
    output <- array(data = 0, dim = c(nrow(state), 2, 2))
    output[,2, 2] <- exp(-0.06 * 0.02 * (time - 1)) * pmax(40 - state[,2], 0)
    return(output)
}
policy <- FastPathPolicy(path, grid, control, RewardFunc, bellman$expected)
## Scrap function
ScrapFunc <- function(state) {
    output <- array(data = 0, dim = c(nrow(state), 2))
    output[,2] <- exp(-0.06 * 0.02 * 50) * pmax(40 - state[,2], 0)
    return(output)
}
## Additive duals
mart <- FiniteAddDual(path, path_disturb, grid, bellman$value, bellman$expected, "fast")
bounds <- AddDualBounds(path, control, RewardFunc, ScrapFunc, mart, policy)
}
\author{Jeremy Yee}

