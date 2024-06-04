use Bio::SearchIO;
use Bio::DB::SwissProt;
use Bio::SeqIO;

my $blast_file = "blast_local.out";
my $searchio   = Bio::SearchIO->new(
    -file   => $blast_file
);

my $precursor_name = "Canis lupus familiaris";

while (my $result = $searchio->next_result) {
    while (my $hit = $result->next_hit) {
    	my $description = $hit->description;
    	if ($description =~ /$precursor_name/i) {
		my $accession = $hit->accession;
		
		$db_obj = Bio::DB::SwissProt->new; 
		$seq_obj = $db_obj->get_Seq_by_acc($accession);
		
		$seqio_obj = Bio::SeqIO->new(-file => '>canis_lupus_seq.fasta', -format => 'fasta');
		$seqio_obj->write_seq($seq_obj);
	}
    }
}
