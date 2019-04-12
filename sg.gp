#!/usr/bin/gnuplot

##
## (C) 2019 Ville Karaila
##

##
## Some parameters here
##

maxtime=28
targetFG=1.023
set output 'mead_sg.png'

##
## Careful below this line
##


set terminal pngcairo

set style line 1 \
    linecolor rgb '#ff0f0f' \
    linetype 1 linewidth 1 \
    pointtype 4 pointsize 0.5

set style line 2 \
    linecolor rgb '#ff0fff' \
    pointinterval 5 linewidth 1 \
    dt 2

set style line 3 \
    linecolor rgb '#0f0fff' \
    pointinterval 5 linewidth 1 \
    dt 3

set style arrow 1 nohead

set xrange [1:maxtime]
set termoption enhanced

set fit logfile 'sg_fit.log'
f(x) = a*x**b;
fit f(x) 'sg.dat' via a,b
g(x) = m*x + n;
fit g(x) 'sg.dat' via m,n

set xlabel 'Day' 
set ylabel 'SG' 
set title 'Brew progress'

set arrow 1 from 1,targetFG to maxtime,targetFG nohead dt "." 
set label 'FG target' at maxtime/2,targetFG

plot 'sg.dat' with linespoints ls 1 title 'data points', \
     f(x) with lines ls 2 title sprintf('f(x) = %.2f·x^{%.2f}', a, b), \
     g(x) with lines ls 3 title sprintf('f(x) = %.2f·x+%.2f', m, n) 

