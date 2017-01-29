#!/usr/bin/perl
use strict;
use warnings;

# check if sequence passed in on the command line
my $sequence_passed_in = $#ARGV + 1 > 0;
my $sequence;
if ($sequence_passed_in) {
	$sequence = $ARGV[0]
} else {
	# ask user for a DNA sequence string and allow user to type in
	# terminal.
	print "Type DNA sequence string: ";
	$sequence = <STDIN>;
}

# remove trailing newline character
chomp $sequence;
# convert string to all uppercase
$sequence = uc $sequence;

# split string into array of 3 characters
my $lag = "a3" x ((length $sequence) / 3);
my @codons = unpack $lag, $sequence;
print "@codons\n";

# read each codon to see if it is a stop codon and counts the number of each
# stop codon
sub count_stop_codons {
	my ($sequence, $stop_codon) = @_;
	my $stop_codon_occurences = 0;

	for (my $i = 0; $i + 3 <= length($sequence); $i += 3) {
		my $substring = substr $sequence, $i, 3;

		if ($stop_codon eq $substring) {
			$stop_codon_occurences += 1;
		}
	}

	return $stop_codon_occurences;
}


# prints number of each stop codons
my $number_of_tag =  count_stop_codons($sequence, "TAG");
my $number_of_tga =  count_stop_codons($sequence, "TGA");
my $number_of_taa =  count_stop_codons($sequence, "TAA");
my $number_of_stopcodons = $number_of_tag + $number_of_tga + $number_of_taa;
print "Number of TAG: $number_of_tag, TGA: $number_of_tga, TAA: $number_of_taa\nTotal = $number_of_stopcodons\n";

# Convert string to array where each element is one character in length.
my @sequence = split("", $sequence);
	print "@sequence\n";
# number of characters in sequence.
my $sequence_length = @sequence;

# use array to count nucleotides
my $count_a = 0;
my $count_c = 0;
my $count_g = 0;
my $count_t = 0;
foreach my $nuc (@sequence) {
	if ($nuc eq 'A') { 
		$count_a += 1;
	}
	elsif ($nuc eq 'C') { 
		$count_c += 1;
	}
	elsif ($nuc eq 'G') { 
		$count_g += 1; 
	}
	elsif ($nuc eq 'T') {
		$count_t += 1;
	}
}

# calculate percentages of each letter in sequence
my $percent_is_a = ($count_a / $sequence_length) * 100;
my $percent_is_c = ($count_c / $sequence_length) * 100;
my $percent_is_g = ($count_g / $sequence_length) * 100;
my $percent_is_t = ($count_t / $sequence_length) * 100;

# round numbers to 2d.p.
my $round_a = sprintf("%.2f", $percent_is_a);
my $round_c = sprintf("%.2f", $percent_is_c);
my $round_g = sprintf("%.2f", $percent_is_g);
my $round_t = sprintf("%.2f", $percent_is_t);

# number of "other characters" and its percentage within the sequence
my $count_other = $sequence_length-($count_a + $count_c + $count_g + $count_t);
my $percent_is_other = ($count_other / $sequence_length) * 100;
my $round_o = sprintf("%.2f", $percent_is_other);

print "The letter A occurs $count_a out of $sequence_length times which is $round_a%\n";
print "The letter C occurs $count_c out of $sequence_length times which is $round_c%\n";
print "The letter G occurs $count_g out of $sequence_length times which is $round_g%\n";
print "The letter T occurs $count_t out of $sequence_length times which is $round_t%\n";
print "There are $count_other incorrect letters out of $sequence_length in the sequence which is $round_o%\n";

# remove any letters that aren't a, c, t or g
$sequence =~ s/[^acgt]//gi;
print "Without errors the sequence string is $sequence\n";

# Convert string without errors into array
my @new_seq = split("", $sequence);
	print "@new_seq\n";

# add 12 As to the end of sequence without errors.
my @list = qw(A A A A A A A A A A A A);
push (@new_seq, @list);
print "@new_seq\n";

# convert array back to string without errors
my $string = join("", @new_seq);
print "$string\n";
