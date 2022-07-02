#!/bin/bash

while getopts f:l: flag
do
    case "${flag}" in
        f) inputfile=${OPTARG};;
	l) splitline=${OPTARG};;
    esac
done

if [ -z "$inputfile" ]
then
    printf "Arg 'inputfile' (-f) is empty! Aborting.."
    exit 1
fi

if [ -z "$splitline" ]
then
    printf "Arg 'splitline' (-l) is empty! Aborting..)"
    exit 1
fi

temp=temp.txt
resultdir=results

# clean up
printf "Cleaning up files from previous runs..\n"
#rm $temp
#rm -rf $resultdir

rows=$(wc -l $inputfile | cut -d " " -f 1)

printf "Will start using input file:%s with rows:%s. Do split after %s lines.\n" $inputfile $rows $splitline

prefix=TESTDATA

cat $inputfile | sed -e 's/^/"/g' \
		     -e 's/$/"/g' > $temp;split -d -l 3 $temp $prefix

mkdir $resultdir
mv $prefix* $resultdir

filecount=$(ls $resultdir | wc -l)
printf "Processing finished. Created folder %s with %s files in it!\n" $resultdir $filecount

exit 0






