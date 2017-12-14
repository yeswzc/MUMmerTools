# MUMmerTools
Tools used to handling output from MUMmer aligner
You may want to read Wiki.

1. MUMmerSNP2VCF.pl :  recode SNPs/inDels in MUMmer output file to VCF format

MUMmerSNP2VCF.pl

Usage:
  perl MUMmerSNP2VCF.pl [queryID] [ref.sizes] [MUMmeroutput]
  queryID: ID used in the output VCF file, just used as the column name 
  ref.size: tow column deliminated file, first column denote the chromosome, second is the size of it MUMmeroutput: output from MUMmer show-snp -Clr -x1 , remmember -x1
 
