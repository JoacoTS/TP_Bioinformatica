use Bio::DB::GenBank;
use Bio::SeqIO;

$rna_id = '3630';

$db_obj = Bio::DB::GenBank->new();
$seq_obj = $db_obj->get_Seq_by_gi($rna_id);

$prot_obj = $seq_obj->translate;

$file = Bio::SeqIO->new(-file => '>mrna.fasta', -format => 'fasta');
$file->write_seq($prot_obj);

$file_copy = Bio::SeqIO->new(-file => '>../Ejercicio2/mrna.fasta', -format => 'fasta');
$file_copy->write_seq($prot_obj);

$file_copy = Bio::SeqIO->new(-file => '>../Ejercicio2(remoto)/mrna.fasta', -format => 'fasta');
$file_copy->write_seq($prot_obj);
