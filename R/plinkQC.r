#' Quality control with PLINK 
#'
#' This function is to do a quality control based on user specified paramters.
#' A version of plink.exe compiled for Windows is already supplied with the R package.
#' WARNING: ped and map files expected as input.
#' @param dataIn Input data file name as required by PLINK's --file parameter
#' @param missPerSample Specifies the limit for missingness per sample 
#' as required by PLINK's --mind parameter. The default value is set to 0.10
#' @param missPerSNP Specifies the limit for missingness per marker 
#' as required by PLINK's --geno parameter. The default value is set to 0.10
#' @param maf Specifies the limit for the minimum alowed minor allele frequency
#' as required by PLINK's --maf parameter. The default value is set to 0.01
#' @param hwe Specifies the significance threshold Fisher's exact test p-value for Hardy-Weinberg equilibrium
#' as required by PLINK's --hwe parameter. The default value is set to 0.0000001 (1E-7)
#' @param otherParameters Optional parameters that are necessary for a specific analysis. 
#' Default value set to " --dog --allow-no-sex --nonfounders --autosome" 
#' @keywords plink
#' @export
#' @examples
#' plinkQC("myInputFileName")

plinkQC <- function(dataIn, missPerSample = 0.10, missPerSNP = 0.10, 
                    maf = 0.01, hwe = 0.0000001, 
                    otherParameters = "--dog --allow-no-sex --nonfounders --autosome"){

  #run quality control with PLINK
  runPlink(paste(otherParameters, "--file",dataIn,"--mind", missPerSample,
               "--maf", maf, "--geno", missPerSNP, "--hwe", hwe,
               "--make-bed --out afterQC", sep=" "))

}
