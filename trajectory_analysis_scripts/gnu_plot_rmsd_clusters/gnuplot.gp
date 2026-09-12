### variable line color
reset session

# create some test data
#set print $Data
#    do for [i=1:100] {
#        print sprintf("%g", rand(0)*i)
#    }
#set print


set palette maxcolors 10
set palette defined ("0" "black", "1" "red", "2" "green", "3" "blue", "4" "yellow", "5" "cyan", "6" "magenta", "7" "orange", "8" "violet", "9" "dark-red"  )


#set palette defined (0 "black", 1 "red", 2 "green", 3 "blue", 4 "yellow", 5 "cyan", 6 "magenta", 7 "orange", 8 "violet", 9 "dark-red" )

plot 'plot_gnu_data.dat' using ($1*20/1000000):2:3 with points pointtype 6 pointsize 0.2 lc palette notitle

#set terminal pngcairo size 3000,1300 enhanced font 'Arial,12' linewidth 1.5 background rgb '#f0f0f0'

#set output 'output.png'

set ylabel "RMSD {\305}"
set xlabel "Time {/Symbol m}s"


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

