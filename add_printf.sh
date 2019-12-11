#!/bin/sh

filelist=`ls *.c`
for file in $filelist
do 
perl add_printf_to_all_func.pl ${file}  ${file}.c
mv  ${file}.c ${file}
done

