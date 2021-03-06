##' Generic function to convert input files containing observational data to 
##' a common PEcAn format. 
##' 
##' This should be the same as the read.output function:
##' This function uses MsTMIP variables except that units of (kg m-2 d-1)  
##' are converted to kg ha-1 y-1. 
##' 
##' Currently this function converts
##' 
##' Carbon fluxes: GPP, NPP, NEE, TotalResp, AutoResp, HeteroResp,
##' DOC_flux, Fire_flux, and Stem (Stem is specific to the BioCro model)
##' 
##' Water fluxes: Evaporation (Evap), Transpiration(TVeg),
##' surface runoff (Qs), subsurface runoff (Qsb), and rainfall (Rainf).
##' 
##' Future things to think about
##'   - error estimates
##'   - QAQC
##'   - STEPPS -> cov
##'   - MCMC samples
##'   - "data products" vs raw data
##'   - Is there a generic structure to ovbs?


load.data <- function(input_path, format_table, vars_names_units, start_year = NA, end_year=NA, site=NA){
    
  require(lubridate)
  
  fcn1 <- paste0("load.",format_table$name)
  fcn2 <- paste0("load.",format_table$mimetype)
  if(exists(fcn1)){
    fcn <- fcn1
  }else if(exists(fcn2)){
    fcn <- fcn2
  }else{
    logger.warn("no load data for current mimetype - converting using browndog")
    # Browndog
    # convert the observations to a mime pecan can use
    # ex: exel -> csv
  }
  
  args <- list(input_path,vars_names_units, start_year, end_year, site))
  
  results <- apply(fcn,args)

  return(result) 
}

