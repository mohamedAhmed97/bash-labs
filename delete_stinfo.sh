#!/bin/bash
## This script accepts 1 parameters and deletes from stinfo file

LINE=$(sed -n "/^$1:/p" stdetails)

if [ ${LINE} ]
then
	echo "Id $1 found in file stdetails, remove it "
	exit 1
fi

LINES=$(cat stinfo)
LINE=$(sed -n "/^$1:/p" stinfo)

if [ -z ${LINE} ]
then
	echo "Id $1 not found in file "
	exit 1
fi

echo -n "" > stinfo

for l in $LINES
do
	if [ ${l} != ${LINE} ]
	then
		echo ${l} >> stinfo
	fi
done

exit 0
