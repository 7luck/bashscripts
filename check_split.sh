#!/bin/bash

# invoke with pattern
check_for_pattern() {
    local i=0
    for result in `grep -c $1 TESTDATA* | cut -d ":" -f 2`; do
	i=$((i+result))
    done
    check_result=$i
}


printf "Checker script started.\n"
src_file=uiid-file.csv
overall_counter=0
line_cnt=0
while IFS= read -r line
do
    check_for_pattern $line
    if [ $check_result -eq 1 ]
    then
	overall_counter=$((overall_counter+1))
    fi
    line_cnt=$((line_cnt+1))

    res=$((line_cnt%4000))
    if [ $res -eq 0 ]
    then
	printf "4000 pattern processed..\n"
    fi

done < $src_file

check_sum=$(wc -l $src_file | cut -d " " -f 1)

if [ $overall_counter -eq $check_sum ]
then
    printf "OK, all of %d patterns found in split files!\n" $overall_counter
    exit 0;
else
    printf "Not OK. Searched for %d pattern but only %d found!\n" $check_sum $overall_counter
    exit 1;
fi

