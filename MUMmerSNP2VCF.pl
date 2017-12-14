#!/usr/bin/perl -w
use strict;

die "$0 [ID] [ref.sizes] [show-snp.out]\n" unless @ARGV==3;
#Zhichao Wu
#
my $id=shift;
my $refsize=shift;
print "##fileformat=VCFv4.1\n##FORMAT=<ID=GT,Number=1,Type=String,Description=\"Genotype\">\n";
open FASIZE,"$refsize" or die $!;
while(<FASIZE>){
	my @e=split;
	next unless @e>=2;
	print "##contig=<ID=$e[0],length=$e[1]>\n";
}
close FASIZE;
print "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t$id\n";
my @t; #just for indels
my $toP; #just for indels
while(<>){
	my @e=split;
	next unless @e eq 18;
	next unless 
	my $ref=$e[11];
	my $alt=$e[12];
	if(@t){
		if($t[-1]->[0]==$e[0]-1 && $e[2] eq "." ){ #consecutive positions, deletion in alt
			push @t,[@e];
			my $refseq;
			$refseq.=$_->[1] for(@t);
			my $reflastpos=substr $ref,2,1;
			my $altlastpos=substr $alt,2,1;
			$refseq.=$reflastpos;
			my $pos=$t[0]->[0];
			$toP="$e[16]\t$pos\trs_$e[16]_$pos\t$refseq\t$altlastpos\t.\tPASS\t.\tGT\t1/1\n";
			next;
		}elsif($t[-1]->[0]==$e[0] && $e[1] eq "."){ #deletion in ref, which is insertion in alt
			push @t,[@e];
			my $altseq;
			$altseq.=$_->[2] for(@t);
			my $reflastpos=substr $ref,2,1;
			my $altlastpos=substr $alt,2,1;
			$altseq.=$altlastpos;
			my $pos=$t[0]->[0];
			$toP="$e[16]\t$pos\trs_$e[16]_$pos\t$reflastpos\t$altseq\t.\tPASS\t.\tGT\t1/1\n";
			next;
		}else{
			print $toP;
			@t=();
		}
	}

	if($e[1] eq "."){ #reference deletion, insertion
		$ref=substr $ref,1,2;
		$alt=substr $alt,1,2;
		$ref=~s/\.//g;		
		$toP="$e[16]\t$e[0]\trs_$e[16]_$e[0]\t$ref\t$alt\t.\tPASS\t.\tGT\t1/1\n";
		push @t,[@e];
	}elsif($e[2] eq "."){ #deletion
		$ref=substr($ref,1,2);
		$alt=substr($alt,1,2);
		$alt=~s/\.//g;		
		$toP="$e[16]\t$e[0]\trs_$e[16]_$e[0]\t$ref\t$alt\t.\tPASS\t.\tGT\t1/1\n";
		push @t,[@e];
	}else{
		next if $e[1]=~/[^ATCGatcg]/;
		next if $e[2]=~/[^ATCGatcg]/;
		print "$e[16]\t$e[0]\trs_$e[16]_$e[0]\t$e[1]\t$e[2]\t.\tPASS\t.\tGT\t1/1\n";
	}
}
print $toP if $toP;
