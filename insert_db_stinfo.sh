#!/bin/bash
## Script accepts id,name,email, and insert it into file db_stinfo
## Exit codes:
##	0: normal
##	1: Invalid paramters
##	2: ID is not integer
##	3: ID is already exists

declare -A DBSETTINGS
DBSETTINGS["DBHOST"]="localhost"
DBSETTINGS["DBUSER"]="root"
DBSETTINGS["DBPASS"]="123/456/"
DBSETTINGS["DBNAME"]="amrawey"


if [ ! $# -eq 3 ]
then
	echo "Invalid paramters"
	echo "Usage: ./sc12 id name email"
	echo "Note: If name contains spaces, include it into \""
	exit 1
fi

ID=$1
NAME=$2
EMAIL=$3

#### Check if ID is integer
temp1="^[0-9]+$"
if ! [[ $ID =~ $temp1 ]] 
then
	echo "Invalid ID format, must be integer"
	exit 2
fi

############## Must check for email address :-)
###################################################

## Get lines contains the ID
LINE=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "select * from stinfo where id=$ID")
if [ -z "$LINE" ]
then 
	mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "insert into stinfo values($ID,'$NAME','$EMAIL')"
	echo "$ID is inserted"
else
	echo "id invalid or already exist"
fi

exit 0
