#' Create heatmap from PLINK output 
#'
#' Visualizes numerical matrices of n*n as heatmaps on the yellow to red scale.
#' Primarily intended to show IBD, IBS and distance matrices created by PLINK.
#' Also installs and loads the 'gplots' and 'RcolorBrewer' packages. 
#' @param relMatName Base name of the relationship matrix 
#' @param graphTitle Title of the figure created as the output. 
#' @param fileExtension the extension of the file created by PLINK. Should be set to "mdist" when using '--distance-matrix' and
#' "mibs" when using '--distance square ibs', or "genome" when using '--genome'
#' @keywords visualization
#' @export
#' @examples
#' makeHeatmap(outputName,graphTitle="Distance matrix",fileExtension="mdist")


# Heatmap for visualization - as function to avoid repetition
makeHeatmap=function(relMatName,graphTitle="",fileExtension){ 
  
  #check if required packages are installed. If not, installs and loads them, 
  # if they are already installed, just loads. 
  if (!require("gplots")) {
    install.packages("gplots", dependencies = TRUE)
    library(gplots)
  }
  if (!require("RColorBrewer")) {
    install.packages("RColorBrewer", dependencies = TRUE)
    library(RColorBrewer)
  }
  
  # different data preparation of output PLINK files depending on the type of the matrix

  if (fileExtension == "mdist" | fileExtension == "mibs") {
    #######
  # distance matrices and IBS matrices
  #######
  # Prepare matrices for heatmaps
  popSize=nrow(read.table(paste(relMatName,fileExtension,"id",sep=".")))
  relMat=matrix(scan(paste(relMatName,fileExtension,sep=".")),nrow=popSize,ncol=popSize)
  rownames(relMat)=read.table(paste(relMatName,fileExtension,"id",sep="."))[,2]
  colnames(relMat)=read.table(paste(relMatName,fileExtension,"id",sep="."))[,2]
  
  } else if (fileExtension == "genome") {
    
    # data prep . genome
    #######
    # IBD matrices
    #######
    # number of individuals in the relationship matrix
    nInd=nrow(read.table(paste(relMatName,".fam",sep="")))
    
    # change plink output to n*n matrix form
    genome=read.table(paste(relMatName,".genome",sep=""),header = T)
    relMat  <- matrix(0, nInd, nInd)
    relMat[lower.tri(relMat)]=genome$PI_HAT
    #not correct relMat[upper.tri(relMat)]=genome$PI_HAT
    # assign column and row labels
    rowColNames=c(as.character(read.table(paste(relMatName,".genome", sep=""),header=T)[1,2]),
                  as.character(read.table(paste(relMatName,".genome", sep=""),header=T)[1:nInd-1,4]))
    rownames(relMat)=rowColNames
    colnames(relMat)=rowColNames
    
  } else {
    
    #print error message and stop
    stop("The fileExtension functino argument must be 'mdist', 'mibs' or 'genome'!")
  }
  
  # Disable diagonal elements so they do not skew the graph
  diag(relMat)=NA
  
  # Define color gradient for the heatmap
  heatmapColors <- colorRampPalette(c("lightyellow","yellow","red"))(n = 299)     ### colorblind mode?!
  
  # Set options and create heatmap
  heatmap.2(relMat,
            cellnote = relMat,     # un-comment line to have relationship values in the graph for each cell
            notecex=0.6,           # font size for the numbers in the cells
            main = graphTitle, 
            notecol="black",      
            density.info="density",  # turns on density plot inside color legend
            trace="none",            # turns off trace lines inside the heat map
            col=heatmapColors,       # use on color palette defined earlier 
            #dendrogram="both",       # only draw a row dendrogram
            margins=c(8,8),          # widens margins around plot so longer IDs are still visible
            Rowv=TRUE,               # reorders rows, so the more related animals are closer to each other
            Colv=TRUE)               # reorders columns, so the more related animals are closer to each other
}
