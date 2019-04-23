#' Visualize ROH results
#'
#' Visualizes the results of a ROH analysis made with the runROH() function
#' @param dataIn The name of the R data frame created by runROH(), containing the inbreeding result for each indvidual.
#' @keywords ROH
#' @export
#' @examples
#' plotROH("afterRohAnalysis")


plotROH <- function(dataIn){
  
  #check if required packages are installed. If not, installs and loads them, 
  # if they are already installed, just loads. 
  if (!require("ggplot2")) {
    install.packages("ggplot2", dependencies = TRUE)
    library(ggplot2)
  }
  
  # Barplot for inbreeding level for each individual
  p<-ggplot(data=dataIn, aes(x=IID, y=dataIn[,3])) +
    geom_bar(stat="identity")
  p <- p + theme(axis.text.x = element_text(angle = 270, hjust = 0))
  p

  
  # Boxplot to summarize the inbreeding in the data set
  q <- ggplot(data=dataIn, aes(y=dataIn[,3])) +
    geom_boxplot()
  q

  return(list(p,q))
  
}