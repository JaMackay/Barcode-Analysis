library(sangerseqR)
setwd("C:/Users/Adell/Documents/Barcode_Analysis")

ITS<-read.abif("./Data/1Ipos_F_P1815443_064.ab1") # Read

ITSseq <- sangerseq(ITS) # Extract sequence 

SeqX<-makeBaseCalls(ITSseq) # Call sequence

##isolate primary sequence for first file and make into FASTA format

PseqX <- SeqX@primarySeq

PseqX2 <- gsub('^', '>1Ipos_F_P1815443_064.ab1\n', PseqX)


##cycle through multiple .ab1 files in DATA folder

#create a list of files as directory locations
seqFiles <- list.files('./Data/', full.names = T)

#load quality check file and subset to files NOT passing quality check
qCheck <- read.csv('./Data/BarcodePlateStats.csv')
removeSeq <- subset(qCheck, Ok == 'FALSE')

# cycle through files, construct FASTA file and insert into vector
Fseqs <- character(length(1:33))
myPos <- 1

for (i in seqFiles){
  myHeader <- gsub('.*Data/', '', i)
  if (myHeader %in% removeSeq$Chromatogram){
    next
  }
  rSeq <- read.abif(i)
  seqITS <- sangerseq(rSeq)
  BCseq <- makeBaseCalls(seqITS)
  Pseq <- BCseq@primarySeq
  
  Pseq2 <- gsub('^', '\n', Pseq)
  Pseq2_2 <- gsub('$', '\n', Pseq2)
  Pseq3 <- gsub('^', myHeader, Pseq2_2)
  Pseq4 <- gsub('^', '>', Pseq3)
  Fseqs[myPos] <- Pseq4
  myPos = myPos + 1
}

cat(Fseqs)
