#!/bin/bash
########### Script accepts ID, and prints the details and sum
##Exit code:
##	0: Normal termination
##	1: Invalid paramters
##	2: ID is not an integer
##	3: ID is not in master file
##	4: ID has no details

declare -A DBSETTINGS
DBSETTINGS["DBHOST"]="localhost"
DBSETTINGS["DBUSER"]="root"
DBSETTINGS["DBPASS"]="123/456/"
DBSETTINGS["DBNAME"]="amrawey"
#########################################################

if [ ! $# -eq 1 ]
then
	echo "Invalid paramters"
	echo "Usage: ./sc15 ID"
	exit 1
fi

### Check if id is an integer
ID=$1
temp="^[0-9]+$"
if ! [[ $ID =~ $temp ]]
then
	echo "Invalid id format, must be an integer"
	exit 2
fi

### Check if id in the stinfo table
LINE=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "select id from stinfo where id=$ID")
if [ -z "$LINE" ]
then
	echo "ID $ID is not exist in the stinfo table"
	exit 3
fi

#### Read the info, and parse it
NAME=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "select name from stinfo where id=$ID")
EMAIL=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "select email from stinfo where id=$ID")
echo "ID=${ID}"
echo -n "NAME="
echo $NAME | cut -d' ' -f2
echo -n "EMAIL="
echo $EMAIL | cut -d' ' -f2

### Read the details
LINE=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -e "select id from stdetails where id=$ID")
if [ -z "$LINE" ]
then
	echo "The user with id $ID has no details!!"
	exit 4
fi

LINES=$(mysql -u ${DBSETTINGS["DBUSER"]} -p${DBSETTINGS["DBPASS"]} ${DBSETTINGS["DBNAME"]} -N -e "select price from stdetails where id=$ID")
for l in $LINES
do
	echo "$ID paid $l"
	s=$[l+s]
done

echo "Total for $ID = $s"
exit 0
