use Bio::Tools::Run::StandAloneBlastPlus;

$fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_name => 'swissprot',
	-remote => 1
);

$result = $fac->blastp(-query => "mrna.fasta", -outfile => "mrna.bls");
