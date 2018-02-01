################################################################################################################################################################################################
## command line options: 

# -p name in nucmer
# -r file to be used in nucmer
# -f fasta file to be used in nucmer
# -m 1 results in output as several chromosome files; anything other than 1 will generate single fasta file named all_chr.fasta
# -c cutoff
# -h help
###############################################################################################################################################################################################

MODE=0

while getopts "p:r:f:c:mh" opt; do
       case $opt in 
		p)
			PREFIX=$OPTARG
			;;
		r)
			SEQ=$OPTARG
			;;
		f)
			FASTA=$OPTARG
			;;
		m)
			MODE=1
			;;
		c)
			cutoff=$OPTARG
			;;
		h)
#################################################################################################
# PLACE FOR HELP FILE
			echo "*****************************************************************************************************************************************************"
			#echo ""
			echo "Welcome to STLab-AsSeMbLeR software suite. This tool is developed by Subhadeep Das & Mathumalar C at Computational Genomics lab, IICB, INDIA"
			echo ""
			echo "It does reference based assembly and outputs the chromosomes or scaffolds to the level of closed assembly with improved N50 and coverage...."
			#echo ""
			echo "******************************************************************************************************************************************************"
			echo ""
			echo "The options and arguments accepted by this tool are given below"
			echo ""
			echo "all the options except -m and -h are mandatory"
			echo "-p	prefix name for the mummer co-ordinates"
			echo "-r	reference sequence file"
			echo "-f	multi-fasta or contig file"
			echo "-m 	results in output as several chromosome files. without this option, output will be in one fasta file"
			echo "-c	alignment length cutoff"
			;;
###################################################################################################
		\?)
			echo "Invalid option -$OPTARG"
			exit 1
			;;
		:)
			echo "option -$OPTARG requires an argument"
			exit 1
			;;
	esac
done

#############################################################################
# Running nucmer and processing files for downstream analysis
nucmer --mumreference --prefix=$PREFIX $SEQ  $FASTA

show-coords -lcr -B $PREFIX.delta > $PREFIX.coords

cut -f1,3,6,7,8,9,10,13,19 $PREFIX.coords > tmp_out 
############################################################################


############################################################################
# Preparing chromosome list
cut -f3 tmp_out | sort| uniq > chr_list
############################################################################



#################################################################################################################################################
# Running bedtools over each chromosome, extracting sequence and stitch with "N"s
oldIFS="$IFS"
IFS=$'\n' chromosome=($(<chr_list))
IFS="$oldIFS"

j=1

for i in ${chromosome[@]}
	do
		grep "$i" tmp_out | awk -v var="$cutoff" '$8 >= var' | sort -nk6,7 > $i.tmp
		cut -f1,4,5 $i.tmp | awk '{if($3> $2){print $1"\t"$2"\t"$3"\t.\t.\t+"} else{print $1"\t"$3"\t"$2"\t.\t.\t-"}}'> $i.bed
		samtools faidx $FASTA
		/home/sutripa/bedtools2/bin/bedtools getfasta -fi $FASTA -bed $i.bed -s -fo tmp
		sed '/^>/d' tmp > extr_$i.fa
		cut -f6,7 $i.tmp > chro_$i
		## This program stitches scaffolds with "N"s
		case $MODE in
			1)
				perl stitch_with_N.pl chro_$i extr_$i.fa $j > $i.fasta
				;;
			*)
				perl stitch_with_N.pl chro_$i extr_$i.fa $j >> all_chr.fasta
				;;
		esac	
			# icreasing j as cromosome number
		j=$((j + 1))
		done
rm *.tmp *.bed extr* chro*

