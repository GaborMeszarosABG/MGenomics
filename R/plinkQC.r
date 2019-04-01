#' Quality control with PLINK 
#'
#' This function is to do a quality control based on user specified paramters.
#' A version of plink.exe compiled for Windows is already supplied with the R package.
#' Creates both ped and binary ped outputs of the Quality controlled data. 
#' WARNING: In development: allows to specify the data name only, binary ped files expected
#' @param dataIn Input data file name as required by PLINK's --file parameter
#' @keywords plink
#' @export
#' @examples
#' plinkQC("myInputFileName")

plinkQC <- function(dataIn){

  MIND=0.12          #Missingness per sample
  GENO=0.1           #Missingness per marker
  MAF=0.01           #Minor allele frequency
  HWE=0.0000001      #Fisher's exact test p-value for Hardy-Weinberg Equilibrium
  
  #Specification of the location of the plink.exe provided in the R package
  PLINK = system.file(package="MGenomics", "programs", "plink.exe")
  
  #run quality control with PLINK
  system(paste(PLINK," --dog --allow-no-sex --nonfounders --autosome --file ",dataIn," --mind ",
               MIND," --maf ",MAF," --geno ",GENO," --hwe ",HWE," --make-bed --out afterQC",sep=""))
  system(paste(PLINK," --dog --allow-no-sex --nonfounders --autosome --bfile afterQC --recode --out afterQC",sep=""))
  
}



