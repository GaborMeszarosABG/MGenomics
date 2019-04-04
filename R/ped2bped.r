#' PLINK file format change from ped to binary-ped 
#'
#' Creates and addtional binary ped (.bed, .bim and .fam) files using the - -make-bed parameter of PLINK. 
#' The name of the output file is the same as the name of the input file. 
#' @param dataIn Input data ped and map file name as required by PLINK's --file parameter
#' @param otherParameters Optional parameters that are necessary for a specific analysis. 
#' Default value set to " --dog --allow-no-sex --nonfounders" 
#' @keywords plink
#' @export
#' @examples
#' ped2bped("myInputFileName")

ped2bped <- function(dataIn, otherParameters = "--dog --allow-no-sex --nonfounders"){

  #run quality control with PLINK
  runPlink(paste(otherParameters, "--file",dataIn,
               "--make-bed --out" , dataIn, sep=" "))
  
}
