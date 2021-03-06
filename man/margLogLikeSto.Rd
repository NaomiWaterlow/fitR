% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logLikelihood.r
\name{margLogLikeSto}
\alias{margLogLikeSto}
\title{Marginal log-likelihood for a stochastic model}
\usage{
margLogLikeSto(fitmodel, theta, init.state, data, n.particles,
  n.cores = 1)
}
\arguments{
\item{fitmodel}{a \code{\link{fitmodel}} object}

\item{theta}{named numeric vector. Values of the parameters. Names should match \code{fitmodel$theta.names}.}

\item{init.state}{named numeric vector. Initial values of the state variables. Names should match \code{fitmodel$state.names}.}

\item{data}{data frame. Observation times and observed data. The time column must be named \code{"time"} and the observation column must be named \code{"obs"}.}

\item{n.particles}{number of particles}

\item{n.cores}{number of cores on which propogation of the particles is parallelised. By default no parallelisation (\code{n.cores=1}). If \code{NULL}, set to the value returned by \code{\link[parallel]{detectCores}}.}
}
\value{
Monte-Carlo estimate of the marginal log-likelihood of \code{theta}
}
\description{
Compute a Monte-Carlo estimate of the log-likelihood of \code{theta} for a stochastic model defined in a \code{\link{fitmodel}} object, using \code{\link{particleFilter}}
}
\seealso{
particleFilter
}
