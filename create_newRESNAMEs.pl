#!/usr/bin/perl -w
#
# Written on 4/20/2020. This script will replace the old residue names with the new ones, which we are utilizing in our dimeric RNA force field.
#
$file = <@ARGV>;
@tmp = split(/\./, $file);
$filenew = $tmp[0].".new.".$tmp[1];
#print "$file\n";
$seq = `cat $file | grep ATOM | awk '{print \$4" "\$5}' | uniq | awk '{l=l \$1}END{print l}'`;
chomp($seq);
@res = split(//, $seq); 
#print "$seq\n";
#print "$res[1]\n";
for($i=0; $i <= $#res; $i++){
  if($i == 0){
    $resnew[$i] = "5$res[$i]$res[$i+1]";
  } elsif($i == $#res){
    $resnew[$i] = "$res[$i-1]$res[$i]3";
  } else {
    $resnew[$i] = "$res[$i-1]$res[$i]$res[$i+1]";
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
open(F2W, ">", "$filenew") || die "cannot open $filenew: $!";
#
# We need to first read the data stored in $file. So, read the file $file through filehandler F2R
#
open(F2R, "<", "$file") || die "cannot open $file: $!";
while (<F2R>){
  if(/^ATOM/){
    chomp($_);
    @tmp = split(/\s+/, $_);
    print F2W sprintf("%-6s%5d %4s %3s  %4d    %8.3f%8.3f%8.3f\n", $tmp[0],$tmp[1],$tmp[2],$resnew[$tmp[4]-1],$tmp[4], $tmp[5], $tmp[6], $tmp[7]);
                                                                                                  #   ^ this tmp related to l/2 so it wont relate when no symmetry
  }
}
close(F2R) || die "cannot close $file: $!";
#
close(F2W) || die "cannot close $filenew: $!";


