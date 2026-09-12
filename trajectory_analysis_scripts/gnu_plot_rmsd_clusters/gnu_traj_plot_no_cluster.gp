
xmin=0
xmax=`tail -1 rmsd.dat | awk '{printf "%.1f" , $1*20/1000000}'`

set xrange [xmin:xmax]

set palette maxcolors 10
set palette defined ("0" "black", "1" "red", "2" "green", "3" "blue", "4" "yellow", "5" "cyan", "6" "magenta", "7" "orange", "8" "violet", "9" "dark-red"  )


plot 'rmsd.dat' using ($1*20/1000000):2 with points pointtype 6 pointsize 0.2 notitle


set ylabel "RMSD (Å)"
set xlabel "Time {/Symbol m}s"

#xmin = 0
#set xrange [xmin:xmax]

### end of code


pause -1



#set palette defined (1 "black", 2 "red", 3 "green", 4 "blue", 5"yellow", 6 "cyan", 7 "magenta", 8"orange" , 9 "violet", 10 "aqua" )
#plot 'plot_gnu_data.dat' u ($1*20*1000000):2:(int($3)-1) with points pointtype 6 pointsize 0.2 lc var notitle
#plot 'tmp.dat' u 1:2:3 with points pointtype 6 pointsize 0.2 lc palette notitle 

#set palette maxcolors 10
#set palette defined (1 "black", 2 "red", 3 "green", 4 "blue", 5 "yellow", 6 "cyan", 7 "magenta", 8 "orange", 9 "violet" )

#set palette defined (1 "black", 2 "red")
#splot 'tmp.dat' using ($1*20/1000000):2:3 with points pointtype 6 pointsize 0.2 lc palette notitle
#set palette maxcolors 10
#set palette defined (0 "#FF0000", 1 "#FF8000", 2 "#FFFF00", 3 "#80FF00", 4 "#00FF00", \
#                     5 "#00FF80", 6 "#00FFFF", 7 "#0080FF", 8 "#0000FF", 9 "#8000FF")

