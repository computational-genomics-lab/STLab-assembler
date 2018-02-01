##########################################################################################################################################
# This program takes 3 input in the follwing order
# 1) this file contains start and end of scaffolds to be stitched (it should be sorted)
# 2) this file contains sequence of the chromosome
# 3) this is the index of chromosome (i.e. 1 for chromosome1, 2 for chromosome 2)
# the program calculates the gap between 2 scaffolds and replaces the gap with equivalent number of "N"s
###########################################################################################################################################

#########################################################################################
# Receiving arguments into array
@a= `cat $ARGV[0]`;   #number, e.g chro33
@b= `cat $ARGV[1]`;   #sequence, e.g chr33_extr.fa
#########################################################################################

#########################################################################################
#printing the first scaffold
chomp($ARGV[2]); # header
print "\n>chr$ARGV[2]\n"; # header
chomp($b[0]); # scaffold
print "$b[0]"; #scaffold
#########################################################################################

#########################################################################################
# Calculating gaps and filling with "N"s

for($i=1;$i< scalar(@b);$i++){

	@first=split("\t", $a[$i-1]);
	@second=split("\t", $a[$i]);
	$gap= $second[0]-$first[1]; #calculating gaps
#print "$gap\n";

	if($gap > 0){
		for($k=1; $k < $gap; $k++){
			print "N"; #printing "N"s
		}
#print "\n";
		chomp($b[$i]);
		print "$b[$i]";
	}

# If there is no gap between subsequent scaffolds (i.e scaffolds are overlapping)
	else{
	$gap=$gap*(-1);
	$subseq = substr($b[$i], $gap);
	chomp($subseq);
	print $subseq;
	}
}
###########################################################################################
