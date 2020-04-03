#!/bin/bash
### Accept ID, cost and insert into db_details
##Exit codes
##	0:	Normal termination
##	1:	Invalid paramters
##	2:	Invalid id, must be integer
##	3:	Invalid price, mustbe integer
##	4:	ID is not found in the master

declare -A DBSETTINGS
DBSETTINGS["DBHOST"]="localhost"
DBSETTINGS["DBUSER"]="root"
DBSETTINGS["DBPASS"]="123/456/"
DBSETTINGS["DBNAME"]="amrawey"
#########################################################

if [ ! $# -eq 2 ]
then
	echo "Invalid paramters"
	echo "Usage: ./sc14 ID Price"
	exit 1
fi

########## Check if id, and price are integers
temp1="^[0-9]+$"
ID=$1
PRICE=$2
if ! [[ $ID =~ $temp1 ]]
then
	echo "Invalid ID, must be an integer"
	exit 2
fi

if ! [[ $PRICE =~ $temp1 ]]
then
        echo "Invalid price, must be an integer"
        exit 3
fi

########### Check if ID is exists in db or no
LINE=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "select * from stinfo where id=$ID")
if [ -z "$LINE" ]
then
	echo "Error: stinfo table has no ID, can not insert"
	exit 4
fi

mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "insert into stdetails values($ID,$PRICE)"
echo "$ID inserted into info table"

exit 0
