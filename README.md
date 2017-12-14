# MUMmerTools
Tools used to handling output from MUMmer aligner

1. MUMmerSNP2VCF.pl :  recode SNPs/inDels in MUMmer output file to VCF format

MUMmerSNP2VCF.pl

Usage:
  perl MUMmerSNP2VCF.pl [queryID] [ref.sizes] [MUMmeroutput]
  queryID: ID used in the output VCF file, just used as the column name ref.size: tow column deliminated file, first column denote the chromosome, second is the size of it MUMmeroutput: output from MUMmer show-snp -Clr -x1 , remmember -x1
  
Example: 
1-1:
14784 C T 134 | 46 134 | 44361539 29191 | GCG GTG | 1 1 Chr1 scaffold2966
will return:
Chr1 14784 rs_Chr1_14784 C T . PASS . GT 1/1

1-2:
16740 G . 2748 | 1 2748 | 44361539 28804 | AGG A.G | 1 1 Chr1 scaffold3527 
16741 G . 2748 | 1 2748 | 44361539 28804 | GGC A.G | 1 1 Chr1 scaffold3527 
16742 C . 2748 | 1 2748 | 44361539 28804 | GCA A.G | 1 1 Chr1 scaffold3527 
16743 A . 2748 | 1 2748 | 44361539 28804 | CAG A.G | 1 1 Chr1 scaffold3527
will return: 
Chr1 16740 rs_Chr1_16740 GGCAG G . PASS . GT 1/1 1-3:

1-3:
44554 . A 20860 | 0 7945 | 44361539 28804 | C.A CAT | 1 1 Chr1 scaffold3527 
44554 . T 20861 | 0 7944 | 44361539 28804 | C.A ATA | 1 1 Chr1 scaffold3527
will return: 
Chr1 44554 rs_Chr1_44554 A ATA . PASS . GT 1/1

Note: The reverse complementary or not is ignored. Because I donot care.
############################
