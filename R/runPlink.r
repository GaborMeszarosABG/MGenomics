#' Run PLINK 
#'
#' Executes the PLINK program supplied with the package 
#' @param plinkParameters Parameters specified according to the PLINK manual
#' @keywords plink
#' @export
#' @examples
#' runPlink("--bfile inData --recode --out outData")

runPlink <- function(plinkParameters){
  
  #Specification of the location of the plink.exe provided in the R package
  PLINK = system.file(package="MGenomics", "programs", "plink.exe")
  
  #run PLINK
  system(paste(PLINK, plinkParameters, sep=" "))
  
}
