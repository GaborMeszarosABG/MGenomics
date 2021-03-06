% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plinkQC.r
\name{plinkQC}
\alias{plinkQC}
\title{Quality control with PLINK}
\usage{
plinkQC(dataIn, missPerSample = 0.1, missPerSNP = 0.1, maf = 0.01,
  hwe = 1e-07, includeMaf = TRUE,
  otherParameters = "--dog --allow-no-sex --nonfounders --autosome")
}
\arguments{
\item{dataIn}{Input data file name as required by PLINK's --file parameter}

\item{missPerSample}{Specifies the limit for missingness per sample 
as required by PLINK's --mind parameter. The default value is set to 0.10}

\item{missPerSNP}{Specifies the limit for missingness per marker 
as required by PLINK's --geno parameter. The default value is set to 0.10}

\item{maf}{Specifies the limit for the minimum alowed minor allele frequency
as required by PLINK's --maf parameter. The default value is set to 0.01}

\item{hwe}{Specifies the significance threshold Fisher's exact test p-value for Hardy-Weinberg equilibrium
as required by PLINK's --hwe parameter. The default value is set to 0.0000001 (1E-7)}

\item{includeMaf}{If set to FALSE, the minor allele frequency is not considered in the QC. 
Useful e.g. in ROH analyses. The default value is TRUE.}

\item{otherParameters}{Optional parameters that are necessary for a specific analysis. 
Default value set to " --dog --allow-no-sex --nonfounders --autosome"}
}
\description{
This function is to do a quality control based on user specified paramters.
A version of plink.exe compiled for Windows is already supplied with the R package.
WARNING: ped and map files expected as input.
}
\examples{
plinkQC("myInputFileName")
}
\keyword{plink}
