#' PLINK file format change from binary-ped to ped 
#'
#' Creates and addtional ped and map file using the - -recode parameter of PLINK. 
#' The name of the output file is the same as the name of the input file. 
#' @param dataIn Input data binary ped file name as required by PLINK's --bfile parameter
#' @param otherParameters Optional parameters that are necessary for a specific analysis. 
#' Default value set to " --dog --allow-no-sex --nonfounders" 
#' @keywords plink
#' @export
#' @examples
#' bped2ped("myInputFileName")

bped2ped <- function(dataIn, otherParameters = "--dog --allow-no-sex --nonfounders"){
  
  #run quality control with PLINK
  runPlink(paste(otherParameters, "--bfile",dataIn,
               "--recode --out" , dataIn, sep=" "))

}
