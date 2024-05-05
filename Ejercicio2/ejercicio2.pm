use Bio::Tools::Run::StandAloneBlastPlus;

$blast_db_path = "/home/usuario/Blast/ncbi-blast-2.10.0+/data2/prot_db";
$fac = Bio::Tools::Run::StandAloneBlastPlus->new(
	-db_name => $blast_db_path
);

$result = $fac->blastp(-query => "mrna.fasta", -outfile => "mrna.bls");
