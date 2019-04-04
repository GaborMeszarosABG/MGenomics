#' Plot PCA results 
#'
#' Saves a picture of a PCA plot to the HDD with various formatting adjustments.
#' The original script supplied by Solomon A. Boison 
#' @param mds Named object of the eigenvectors produced by the get() function
#' @param classifier Use uncertain, default value = 1
#' @param pca1 The eigenvector and its explained variance plotted on the X axis
#' @param pca2 The eigenvector and its explained variance plotted on the Y axis
#' @param outname The name of the png file to be saved to the computer. Default value is "pcaPlot.png"
#' @keywords PCA
#' @export
#' @examples
#' pca_plots(eigen_vec="eigenvec_populations",pca1=c(1,paste(eigen_values[1],"%")),
#' pca2=c(2,paste(eigen_values[2],"%")))


pca_plots <- function(mds, classifier = 1, pca1, pca2, outname = "pcaPlot.png"){

  brds <- unique(mds[,classifier])
  xlim_ <- c(min(mds[,as.numeric(pca1[1])+1]),max(mds[,as.numeric(pca1[1])+1]))
  ylim_ <- c(min(mds[,as.numeric(pca2[1])+1]),max(mds[,as.numeric(pca2[1])+1]))
  #xlim_=c(-0.15,0.15)
  #ylim_=c(-0.15,0.15)
  dpi=300;width.cm<-15;height.cm<-13;width.in<-width.cm/2.45;height.in<-height.cm/2.45
  png(file=outname,width=width.in*dpi,height=height.in*dpi,pointsize=8,units="px",res=dpi)
  plot(x="",y="",xlim=xlim_,ylim=ylim_,
       xlab=paste('Eigenvector 1 ( ',pca1[2],' )',sep=''),
       ylab=paste('Eigenvector 2 ( ',pca2[2],' )',sep=""))
  for(i in 1:length(brds)){
    mds_br <- mds[which(mds[,classifier]==brds[i]),]
    points(x=mds_br[,as.numeric(pca1[1])+1],y=mds_br[,as.numeric(pca2[1])+1],col=i,pch=1+i)
  }
  abline(h=0,lwd=1,lty=3)
  abline(v=0,lwd=1,lty=3)
  legend(x='topleft',legend=brds,col=1:length(brds),pch=2:(2+length(brds)))
  dev.off()
}



