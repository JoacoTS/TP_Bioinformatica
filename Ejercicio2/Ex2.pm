#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use Bio::SeqIO;
use Bio::Tools::Run::StandAloneBlastPlus;

# Default values
my $local_db;
my $remote_db = "swissprot";

# Parse command line options
GetOptions(
    "local=s" => \$local_db,    # Name of local database
);

# Input FASTA file containing amino acid sequences
my $fasta_file = shift @ARGV;
die "Usage: $0 [-local dbname] <fasta_file> <blast_output_file>\n" unless defined $fasta_file;

# Output file for BLAST results
my $blast_output_file = shift @ARGV;
die "Usage: $0 [-local dbname] <fasta_file> <blast_output_file>\n" unless defined $blast_output_file;

# Initialize a BLAST factory object
my %blast_options;
if ($local_db) {
    print("Using local db: " . $local_db);
    $blast_options{-db_name} = $local_db;
} else {
    print("Using remote db: swissprot");   
    $blast_options{-db_name} = $remote_db;
    $blast_options{-remote} = 1;
}

my $factory = Bio::Tools::Run::StandAloneBlastPlus->new(%blast_options);

# Perform BLAST search
$factory->blastp(
    -query => $fasta_file,
    -outfile => $blast_output_file
);
