#!/usr/bin/perl -w

$pmemd  = "\$AMBERHOME/bin/pmemd.cuda";
$jold = 24;              # initial value

for($i=26; $i<=50; $i++){
  #######################################################################
  # First, read the md_*.rst files in the directory and sort it. The last term in that file is the current finished md.
  #
  @rstfiles = <md_*.rst>;
  foreach (@rstfiles) {
    s/^md_//g;
    s/\.rst$//g;
  }
  @rstfilessorted = sort { $a <=> $b } @rstfiles;
  if($#rstfilessorted == -1){   # There is no md_*.rst files; so start with first run
    $jnew = 1;
  } else {
    $jold = $rstfilessorted[$#rstfilessorted];  # jold = job old
    $jnew = $jold + 1;                          # jnew = job new
  }
  #######################################################################
  # if $jnew > 210, this means that there is no need to create .in and .sh files. So, quit/die.
  if($jnew > 50){die};
  if($jnew == 1) {
    $mdold = "eq2";
    $mdnew = "md_$jnew";
  } else {
    $mdold = "md_$jold";
    $mdnew = "md_$jnew";
  }
  $line = "$pmemd -O -i md.in -p prmtop.new -c $mdold\.rst -o $mdnew\.out -r $mdnew\.rst -x $mdnew\.mdcrd  < /dev/null || goto error";
  system("$line");
#  system("gzip -9 $mdnew\.mdcrd");
#  system("cp $mdnew\.* \$SLURM_SUBMIT_DIR");
}
