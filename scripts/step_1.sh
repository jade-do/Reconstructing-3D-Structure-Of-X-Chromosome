/diskD/shared/project_1/software/bwa-0.6.2/bwa aln /diskD/shared/project_1/data/reference_genome_hg18/chrX.fa /diskD/shared/project_1/data/sra_1_chrX.fastq > ../data/sra_1_chrX.sai 
/diskD/shared/project_1/software/bwa-0.6.2/bwa samse /diskD/shared/project_1/data/reference_genome_hg18/chrX.fa ../data/sra_1_chrX.sai /diskD/shared/project_1/data/sra_1_chrX.fastq > ../data/sra_1_chrX.sam 

/diskD/shared/project_1/software/bwa-0.6.2/bwa aln /diskD/shared/project_1/data/reference_genome_hg18/chrX.fa /diskD/shared/project_1/data/sra_2_chrX.fastq > ../data/sra_2_chrX.sai 
/diskD/shared/project_1/software/bwa-0.6.2/bwa samse /diskD/shared/project_1/data/reference_genome_hg18/chrX.fa ../data/sra_2_chrX.sai /diskD/shared/project_1/data/sra_2_chrX.fastq > ../data/sra_2_chrX.sam

perl step_1_2.pl ../data/sra_1_chrX.sam ../data/sra_2_chrX.sam ../data/contact_library.txt
