#!/bin/bash
## This script accepts 1 paramter and print the record from stinfo and stdetails files

sed -n "/^$1:/p" stinfo | cut -f1,2,3 -d':' --output-delimiter=', '
sed -n "/^$1:/p" stdetails | cut -f2,3,4 -d':' --output-delimiter=', '
