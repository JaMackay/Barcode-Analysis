library(sangerseqR)

ITS<-read.abif("./Data/DNA_Barcoding/1Ipos_F_P1815443_064.ab1") # Read

ITSseq <- sangerseq(ITS) # Extract

SeqX<-makeBaseCalls(ITSseq) # Call 