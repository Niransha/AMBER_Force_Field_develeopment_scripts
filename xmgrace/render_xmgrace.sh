#!/bin/bash

#2400 1800 equal to 600 dpi 
gracebat rmsd1.agr -hdevice JPEG -printfile figure.jpg -fixed 2400 1800 

gracebat rmsd1.agr -hdevice EPS -printfile figure.eps -fixed 2400 1800 

convert figure.eps figure.pdf

