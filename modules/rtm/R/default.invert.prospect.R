#' @name default.invert.prospect
#' @title Default settings for PROSPECT inversion
#' @description Bayesian inversion of PROSPECT with default priors and 
#' parameter constraints and random initial conditions.
#' @param observed Vector of observed reflectance.
#' @param sensor Sensor name (string)
#' @param ngibbs Number of MCMC iterations (integer)
#' @param version PROSPECT version (4, 5 [default], or 5B
#' @param do.mle Whether or not to perform LM optimization of initial 
#' conditions before starting Metropolis-Hastings sampling (default = TRUE)
#' @param quiet If TRUE, don't print status updates or LM fit results (default 
#' = TRUE)
default.invert.prospect <- function(observed, sensor, ngibbs, version=5,
                                    do.mle=TRUE, quiet=TRUE){
    model <- function(params, constants=NULL) spectral.response(prospect(params, 5)[,1], sensor)
    testspec <- model(c(1.4, 40, 8, 0.01, 0.01))
    stopifnot(all(dim(testspec) == dim(observed)))
    prior.params <- prior.defaultvals.prospect(sd.inflate = 3)
    inits <- with(prior.params, rlnorm(5, mu, sigma))
    inits[1] <- inits[1] + 1
    names(inits) <- params.prospect5
    prior <- with(prior.defaultvals.prospect(sd.inflate = 3), 
                  priorfunc.prospect(mu, sigma))
    pm <- c(1, 0, 0, 0, 0)
    samples <- invert.slow(observed = observed,
                           inits = inits,
                           constants = NULL,
                           ngibbs = ngibbs,
                           prior = prior,
                           pm = pm,
                           model = model,
                           do.mle = do.mle,
                           quiet = quiet)
    return(samples)
}
