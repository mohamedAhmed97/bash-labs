#!/bin/bash
## This script accepts 1 parameters and deletes from stdetails file

LINES=$(cat stdetails)
LINE=$(sed -n "/^$1:/p" stdetails)

if [ -z ${LINE} ]
then
	echo "Id $1 not found in file stdetails"
	exit 1
fi

echo -n "" > stdetails

for l in $LINES
do
	if [ ${l} != ${LINE} ]
	then
		echo ${l} >> stdetails
	fi
done

exit 0
