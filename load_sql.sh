#!/bin/bash
source config.sh
red=`tput setaf 1`
reset=`tput sgr0`
echo ""
echo "${red}------------ SQL Scripts ------------"
echo ""

for file in `find ./files.sql/*.sql -type f`
do
    green=`tput setaf 3`
    reset=`tput sgr0`
    echo "${green}execute sql: ${file:12}";
    echo "${reset}---------------------------------------------"

    sqlcmd -S $db_host -U $db_user -P $db_pass -i $file > /dev/null
done