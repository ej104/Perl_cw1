#!/usr/bin/perl
use strict;
use warnings;

# ask user for a DNA sequence string and allow user to type in terminal.
print "Type DNA sequence string\n";
my $sequence = <STDIN>;

# removes unwanted empty set from end of array
chomp $sequence;

# split string into array of 3 characters
my $lag = "a3" x ((length $sequence)/3);
my @codons = unpack $lag, $sequence;
print "@codons\n";

# read each codon to see if it is a stop codon and counts the number of each stop codon
sub count_stop_codons {
        my ($sequence, $stop_codon) = @_;
        my $stop_codon_occurences = 0;

        for (my $i = 0; $i + 3 <= length($sequence); $i += 3) {
                my $substring = substr $sequence, $i, 3;

                if ($stop_codon eq $substring) {
                        $stop_codon_occurences++;
                }
        }

        return $stop_codon_occurences;
}


# prints number of each stop codons
my $number_of_tag =  count_stop_codons($sequence, "TAG");
my $number_of_tga =  count_stop_codons($sequence, "TGA");
my $number_of_taa =  count_stop_codons($sequence, "TAA");
my $sc_total = $number_of_tag + $number_of_tga + $number_of_taa;
print "Number of TAG: $number_of_tag, TGA: $number_of_tga, TAA: $number_of_taa\nTotal = $sc_total\n";

# Convert string to array where each element is one character in length.
my @sequence = split("", $sequence);
        print "@sequence\n";
# number of characters in sequence.
my $lngth = @sequence;

# use array to count nucliotides
my $countA;
my $countC;
my $countG;
my $countT;
foreach my $nuc (@sequence) {
        if ($nuc eq 'A') { 
                $countA += 1; 
        }
        elsif ($nuc eq 'C') { 
                $countC += 1; 
        }
        elsif ($nuc eq 'G') { 
                $countG += 1; 
        }
        elsif ($nuc eq 'T') { 
                $countT += 1; 
        }
}

# calculate percentages of each letter in sequence
my $apercent = ($countA/$lngth)*100;
my $cpercent = ($countC/$lngth)*100;
my $gpercent = ($countG/$lngth)*100;
my $tpercent = ($countT/$lngth)*100;

# round numbers to 2d.p.
my $round_a = sprintf("%.2f", $apercent);
my $round_c = sprintf("%.2f", $cpercent);
my $round_g = sprintf("%.2f", $gpercent);
my $round_t = sprintf("%.2f", $tpercent);

# number of "other characters" and its percentage within the sequence
my $other = $lngth-($countA+$countC+$countG+$countT);
my $opercent = ($other/$lngth)*100;
my $round_o = sprintf("%.2f", $opercent);

print "The letter A occurs $countA out of $lngth times which is $round_a%\n";
print "The letter C occurs $countC out of $lngth times which is $round_c%\n";
print "The letter G occurs $countG out of $lngth times which is $round_g%\n";
print "The letter T occurs $countT out of $lngth times which is $round_t%\n";
print "There are $other incorrect letters out of $lngth in the squence which is $round_o%\n";

# find a way to remove any letters that aren't a, c, t or g
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
