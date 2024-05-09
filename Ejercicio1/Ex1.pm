#!/usr/bin/perl

use strict;
use warnings;
use Bio::SeqIO;

# Check for proper usage
if (@ARGV != 2) {
    die "Usage: $0 <input_genbank_file> <output_fasta_file>\n";
}

# Get input and output file names
my ($input_file, $output_file) = @ARGV;

# Create SeqIO objects for reading input and writing output
my $seq_in  = Bio::SeqIO->new(-file => $input_file, -format => 'genbank');
my $seq_out = Bio::SeqIO->new(-file => ">$output_file", -format => 'fasta');

# Process each sequence in the input file
while (my $seq = $seq_in->next_seq) {
    my $mRNA_seq = $seq->seq;

    # Find open reading frames (ORFs)
    my @ORFs = $mRNA_seq =~ /ATG(?:(?!TAA|TAG|TGA)...)*(?:TAA|TAG|TGA)/ig;

    # Translate each ORF and write to output
    my $orf_id = 0;
    foreach my $orf (@ORFs) {
        my $aa_seq = translate($orf);
        $seq_out->write_seq(Bio::Seq->new(-seq => $aa_seq, -id => $seq->display_id . "_ORF_" . (++$orf_id), -desc => "Translated ORF"));
    }
}

# Translate DNA sequence to amino acid sequence
sub translate {
    my ($dna) = @_;
    my $seq_obj = Bio::Seq->new(-seq => $dna);
    return $seq_obj->translate->seq;
}
