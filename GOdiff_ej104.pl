#!usr/bin/perl
use strict;
use warnings;

#declare hashes for both files
my %gene;
my %gene2;

#declare three files 
my $gofile = "GO0003723.genelist.tsv";
my $difffile = "diffexp.tsv";
my $godifffile = "GOdiff.tsv";

#open read only file, error message if failed
open (GOFILE, "<$gofile") or die "error opening $gofile";

#while loop - chomps any trailing string, splits each column by tabs line by line and pairs gene names with p-values
while (<GOFILE>) {
	chomp;
	my @col = split("\t", $_);
	$gene{$col[3]} = $col[4];
}
#closes file
close GOFILE;
#while loop - chomps any trailing string, splits each column by tabs line by line and pairs gene names with descriptions
open (DIFFFILE, "<$difffile") or die "error opening $difffile";
while (<DIFFFILE>) {
	chomp;
	my @col = split("\t", $_);
	$gene2{$col[0]} = $col[4];
} 
#close file
close DIFFFILE;

#extract key from hash into array
my @k = keys %gene;

#create file to print combined data
open (GODIFFFILE, ">$godifffile") or die "error creating $godifffile"

#looking through the key for matching genes in second file, then prints those genes with p-values and descriptions, separated by tabs
foreach (@k) {
	if (exists $gene2{$_}) {
		print GODIFFFILE "$_\t$gene{$_}\t$gene2{$_}\n";
	}
}

