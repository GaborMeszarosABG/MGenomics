#' Compute and plot principal components
#'
#' Computes the principal components using the cmdscale function and plots the results 
#' using the pca_plots function of the MGenomics package 
#' @param dataIn Name of the input data file. The function is tested with PLINK's .mdist files.
#' The input should be the full filename e.g. "myResults.mdist"
#' @param useK  the maximum dimension of the space which the data are to be represented in
#' Must be in {1, 2, ., n-1}. The default value is 4
#' @param eigVecOnX The eigenvector to be plotted on X axis. Default is 1
#' @param eigVecOnY The eigenvector to be plotted on X axis. Default is 2
#' @param outname The name of the png file to be saved to the computer. Default value is "pcaPlot.png"
#' @keywords plink
#' @export
#' @examples
#' runPCA("myResults.mdist")

runPCA <- function(dataIn, useK = 4, eigVecOnX = 1, eigVecOnY = 2, outname = "pcaPlot.png"){
  
  ## Load data
  dist_populations<-read.table(dataIn,header=F)
  ### names of the populations based on the Family names in PLINK
  fam <- data.frame(famids=read.table(paste(dataIn, ".id", sep=""))[,1]) 

  ## Perform PCA using the cmdscale function
  mds_populations <- cmdscale(dist_populations, eig=T, k=useK)
  
  ## extract the eigen vectors
  eigenvec_populations <- cbind(fam,mds_populations$points)
  
  ## compute the proportion of variation captured by each eigen vector (called eigen values)
  eigen_values <- round(((mds_populations$eig)/sum(mds_populations$eig))*100,2)
  
  ## get he named object of the Eigenvectors
  namedObject <- get("eigenvec_populations")
  
  ## Plot using the pca_plots function
  pca_plots(mds = namedObject, classifier = 1, pca1=c(eigVecOnX,paste(eigen_values[eigVecOnX],"%")),
            pca2=c(eigVecOnY,paste(eigen_values[eigVecOnY],"%")), outname)
  
}