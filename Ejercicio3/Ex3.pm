use Bio::Tools::Run::Alignment::Clustalw;

$factory = Bio::Tools::Run::Alignment::Clustalw->new(-matrix => 'BLOSUM');
$ktuple = 2;
$factory->ktuple($ktuple);

my $input_file1 = "NM_001025366.3_ORFs.fasta";
my $seq_in1 = Bio::SeqIO->new( -format => 'fasta', -file   => $input_file1);

my @seq_array; 
while ( my $seq = $seq_in1->next_seq() ) {
   push(@seq_array,$seq);
}

my $input_file2 = "seq2.fasta";
my $seq_in2 = Bio::SeqIO->new( -format => 'fasta', -file   => $input_file2);

my @seq_array; 
while ( my $seq = $seq_in2->next_seq() ) {
   push(@seq_array,$seq);
}

$seq_array_ref = @seq_array;

$aln = $factory->align($seq_array_ref)
