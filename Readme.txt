STLab-AsSeMbLeR software suite Version 1.0		INSTALLATION INSTRUCTIONS

DESCRIPTION

STLab-AsSeMbLeR takes the Reference whole chromosome or genome, along with the contigs provided, it performs the mummer to align the contigs to the referencegenome or reference chromosome and based on the alignment and length cutoff provided by the user to filter the region which are poorly aligned, and it makes the genome assembly to the level of full chromosome, and pad the gaps with the N's wherever the gap resgions are found.

CITATION



DOWNLOAD

STLab-AsSeMbLeR is a property of Genomics and Computational Biology Lab, Indian Institute of chemical Biology, the download site is 
	



PRE-INSTALLATION

STLab-AsSeMbLeR will run mostly on the UNIX platforms.specifically, the following programs are necessary :

	1.awk
	2.sed
	3.BEDTOOLS 2.0 
	4.Mummer 
	5.samtools
	6.Perl

STLab-AsSeMbLeR Version 1.0 package consists of two files: 

	Readme	This file

	STLab-AsSeMbLeR.tar.gz	compressed tar archive

	stitch_with_N.pl	perl script

	test_data	A directory of test data contains test data sets of
ecoli to check the installations and compatability

INSTALLATION

	1. Uncompress the file using tar -xvzf xxxx.tar.gz

	2. Set the path information of BEDTOOLS 2 at the line no.94 [DONT
CHANGE ANYTHING THAN THE PATH]

	3. Test the STLab-AsSeMbLeR for test data provided at the
directory test_data. Before running or after running please make sure to delete the
all_chr.fasta otherwise it will append in the existing file.

	./assemble.sh test_ecoli sequence.fasta ecoli_contigs.fa 1 [ for having
the chromosome fasta file separately like chr1.fa chr2.fa] or

Can have all thechromosomes together by providing 

./assemble.sh test_ecoli sequence.fasta ecoli_contigs.fa 2

After performing the alignment the program will ask the user for providing the
cutoff for filtering the poorly aligned regions.

eg: Length cutoff
1500

Now it will filter the alignment length which are lower than the length cutoff
of 1500 and align the contigs using chromosome.

4. after the alignment it creates the output file of all_chr.fasta the whole genome
assembly to the level of chromosome.

5.Happy assembly ...

HELP
Please check the help file or  ./assemble.sh -h


PROBLEMS AND QUESTIONS
In case of technical problems (bugs etc.) please contact
mmadhubioinfo@gmail.com , subhadeep1024@gmail.com

Questions on the scientific aspects of the method  should go to
Sucheta Tripathy, tsucheta@iicb.res.in or tsucheta@gmail.com



C&G IICB, 24 May 2016

