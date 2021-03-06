% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bped2ped.r
\name{bped2ped}
\alias{bped2ped}
\title{PLINK file format change from binary-ped to ped}
\usage{
bped2ped(dataIn, otherParameters = "--dog --allow-no-sex --nonfounders")
}
\arguments{
\item{dataIn}{Input data binary ped file name as required by PLINK's --bfile parameter}

\item{otherParameters}{Optional parameters that are necessary for a specific analysis. 
Default value set to " --dog --allow-no-sex --nonfounders"}
}
\description{
Creates and addtional ped and map file using the - -recode parameter of PLINK. 
The name of the output file is the same as the name of the input file.
}
\examples{
bped2ped("myInputFileName")
}
\keyword{plink}
