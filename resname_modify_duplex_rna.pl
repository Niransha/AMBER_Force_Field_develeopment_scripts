######################################################
############ PBD RESNAME CHANGE#######################
############# modified by NRK 27 Jun 2020 ### ########
######################################################


#!/usr/bin/perl 
#
# Written on 4/20/2020. This script will replace the old residue names with the new ones, which we are utilizing in our dimeric RNA force field.
#
$file = <@ARGV>;                                    # read file abc.pdb
@tmp = split(/\./, $file);							#name			
$filenew = $tmp[0].".new.".$tmp[1];					
#print "$file\n";
$seq = `cat $file | grep ATOM | awk '{print \$4" "\$5}' | uniq | awk '{l=l \$1}END{print l}'`;   #get uniq RNA sequence
chomp($seq); 				#remove \n
@res = split(//, $seq);     #split uniq sequence
#print "$seq\n";
#print "$res[0]\n";
#print "$file\n"
#print " $#res \n ";



for($i=0; $i <= (($#res-1)/2) ; $i++){		#until first 5' to first 3'	
  if($i == 0){					# first 5' first resnames	
    $resnew[$i] = "5$res[$i]$res[$i+1]";
  } elsif($i ==  (($#res-1)/2)  ){  		# first 3' resname 
    $resnew[$i] = "$res[$i-1]$res[$i]3";         
    } else {					# every resname in between first 5' to 3' except 5' and 3'
    $resnew[$i] = "$res[$i-1]$res[$i]$res[$i+1]";
  }
}

for($i=(($#res+1)/2) ; $i <= $#res ; $i++){	# second 5' to second 3'	
  
  if($i == (($#res+1)/2) ) {			# second 5' first resname
    $resnew_half[$i] = "5$res[$i]$res[$i+1]";   
  } 
  	elsif($i == $#res ){                    # second 3' last resname    
    $resnew_half[$i] = "$res[$i-1]$res[$i]3";
  	} 
  	else {					# every resname inbetween second 5' and 3' except 5' and 3'
    $resnew_half[$i] = "$res[$i-1]$res[$i]$res[$i+1]";
  	}
}

#
# At this point, we have a new array called @resnew, which has the new residue names.
#
#for($i=0; $i <= $#res; $i++){
#  print "$res[$i]\t$resnew[$i]\n";
#}
#
# We are going to write it to a file named $filenew. Our writing operation is done through F2W
#
open(F2W, ">", "$filenew") || die "cannot open $filenew: $!";     # file to write
#
# We need to first read the data stored in $file. So, read the file $file through filehandler F2R
#
open(F2R, "<", "$file") || die "cannot open $file: $!";         # file to read

while (<F2R>){

  if(/^ATOM/){			#when ATOM
 # if($i == 0){
	chomp($_);		# line by line split
    @tmp = split(/\s+/, $_);     # line  split by spaces

	print F2W sprintf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $tmp[0],$tmp[1],$tmp[2],$resnew[$tmp[4]-1],$tmp[4], $tmp[5], $tmp[6], $tmp[7]);   # print with new resnames until first TER met 
	#print F2W sprintf("%-6s\n", "TER")
	} 
	
	else {
	#	print F2W sprintf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $tmp[0],$tmp[1],$tmp[2],$resnew_half[$tmp[4]-1],$tmp[4], $tmp[5], $tmp[6], $tmp[7]);
   	#  	print F2W sprintf("%-6s\n", TER);
	last;  # break when TER met
 	}

} #while loop end here

print F2W sprintf("%-6s\n", "TER"); # print TER to file

#@seq_half = $( sed -ne '/^TER/ { :a; n; p; ba; }' $file );
#$seq = `cat $file | grep ATOM | awk '{print \$4" "\$5}' | uniq | awk '{l=l \$1}END{print l}'`;
#chomp($seq);
#@res = split(//, $seq); 


#$file_half = `sed -ne '/^TER/ { :a; n; p; ba; }' $file`;

`sed -ne '/^TER/ { :a; n; p; ba; }' $file >> half.pdb`;  #grab everything after TER, and put into new file 

#sed -ne '/^TER/ { :a; n; p; ba; }' $file > file_half.pdb

#print "$file_half"

#$file_half = open("./file_half.pdb") ;  # Much nicer

open(F2RH, "<", "./half.pdb") || die "cannot open half.pdb: $!";  # read that file half.pdb

while (<F2RH>){

  if(/^ATOM/){			# begin with atom of half.pdb
 # if($i == 0){
	chomp($_);		# line bby line
    @tmp = split(/\s+/, $_);	#split lines by spaces

	print F2W sprintf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $tmp[0],$tmp[1],$tmp[2],$resnew_half[$tmp[4]-1],$tmp[4], $tmp[5], $tmp[6], $tmp[7]);	# print with new resnames until second TER (first TER of half.pdb )
	#print F2W sprintf("%-6s\n", "TER")
	} 
	
	else {
	#	print F2W sprintf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $tmp[0],$tmp[1],$tmp[2],$resnew_half[$tmp[4]-1],$tmp[4], $tmp[5], $tmp[6], $tmp[7]);
   	#  	print F2W sprintf("%-6s\n", TER);
	last;  #break at final TER  (first of half.pdb 
 	}

} #while loop end here

print F2W sprintf("%-6s\n", "TER"); # print final TER


close(F2R) || die "cannot close $file: $!";
#
close(F2W) || die "cannot close $filenew: $!";

`rm half.pdb`

   # if($tmp[0] eq "TER"){
#	last;


#  if($tmp[0] eq "TER"){
#    chomp($_);
 #   @tmp = split(/\s+/, $_);
	
#    print F2W sprintf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $tmp[0],$tmp[1],$tmp[2],$resnew[$tmp[4]-1],$tmp[4], $tmp[5], $tmp[6], $tmp[7]);
#	}
 #  else {
#	last;
 	
 #	}
#} #while loop end here

