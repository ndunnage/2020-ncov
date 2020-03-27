ipak <- function(pkg){
    new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(pkg, require, character.only = TRUE)
}

# usage
packages <- c("ggplot2", "plyr", "foreach", "doMC", "lubridate", "magrittr", "coda", "tidyverse", "rootSolve", "mgcv",
 "stringr", "sparklyr", "dplyr")
ipak(packages)
