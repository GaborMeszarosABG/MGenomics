#' ROH analysis
#'
#' Executes a ROH analysis using the cgaTOH program 
#' @param dataIn Input data ped and map file name fro ROH analyses
#' @param outName Base name for output files.
#' @param lParameter ROH length according to the cgaTOH manual.
#' @param minRohLength Minimum length of ROH segment in base pairs
#' @param maxGap Maximum physcal gap alloved between adjascent SNPs in ROH in base pairs
#' @param maxMissing Maximum number of missing SNPs allowed in a ROH run 
#' @param maxHetero Maximum number of heterozygous SNPs allowed in a ROH run
#' @param genomeLength The length of the genome covered by SNPs in base pairs 
#' that should be considered for calcualtion of the genomic inbreeding. 
#' The default value is the autosomal length of the dog autosome, 2201660000 base pairs.    
#' @keywords ROH
#' @export
#' @examples
#' runROH("afterQC",outName = "test", minRohLength = 1000000, lParameter = 15, maxGap = 10000, maxMissing = 0, maxHetero = 0)


runROH <- function(dataIn, outName, lParameter , minRohLength, 
                   maxGap, maxMissing, maxHetero, genomeLength = 2201660000){
  
  #Specification of the location of the cgaTOH provided in the R package
  # The cgaTOH was compiled 32-bit version using Visual Studio 2010 running on Windows 7
  TOH = system.file(package="MGenomics", "programs", "TOH_ClusteringSuite_v1_0.exe")
  
  # create a new directory where the output data is stored, not to flood the main working directory
  suppressWarnings(dir.create("inbreeding"))
  
  #run ROH analysis
  system(paste(TOH, " -map " ,dataIn, " -p " ,dataIn, " -o inbreeding/", outName," -l ", lParameter, " -min_length ", minRohLength,
               " -max_gap ", maxGap, " -max_missing ", maxMissing, " -max_hetero ", maxHetero, " -skip_clustering -force_proceed", sep=""))
  
  ### compute genomic inbreeding coefficient
  ###Summary of ROH results computed with cgaTOH
  #initialization
  tmp=read.csv(paste("inbreeding/", outName,".homozygousruns", sep=""))
  nrIndividuals=length(unique(tmp$Label))
  tohResults=data.frame(nr=1:nrIndividuals,IID=unique(tmp$Label))
  
  #read in each result, summarize and compute inbreeding coefficient
  tohRuns=read.csv(paste("inbreeding/", outName,".homozygousruns",sep = ""))
  tohSum=aggregate(tohRuns$PositionLength ~ tohRuns$Label, tohRuns, sum)
  # computation of the genomic inbreeding based on 'genomeLength' parameter 
  tohSum$inbreedingLevel=round(tohSum[,2]/genomeLength,digits=4)
  colnames(tohSum)=c("IID",paste("tohTotal_", outName,sep = ""),paste("inbreedingLevel_", outName,sep = ""))
  tohResults=merge(tohResults,tohSum,by="IID",sort=F,all.x=T)

  #reorder results to be the same format as the beginning, and drop the counting column
  tohResults=tohResults[order(tohResults$nr),]
  tohResults= subset(tohResults,select = -nr)
  
  
  # write out the results to HDD for immediate check
  write.table(tohResults,paste("genomicInbreeding_", outName, ".txt", sep=""),quote = F,row.names = F,col.names = T)
  
  # returns the data frame with an inbreeding coefficient for each iundividual
  # useful e.g. for plotting purposes
  return(tohResults)
  
}
