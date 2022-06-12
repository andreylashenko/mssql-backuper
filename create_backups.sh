#!/bin/bash
source config.sh
mkdir -p backups
reset=`tput sgr0`
id=$(docker ps -a -q --filter ancestor=mssql-backuper_mssql --format="{{.ID}}")

getDbName() {
    echo $1 | rev | cut -c 5- | rev
}
for file in `find ./files.bak/*.bak -type f`
do
  db=$(getDbName ${file:12})

  red=`tput setaf 2`
  reset=`tput sgr0`
  echo ""
  echo "${red}------------ Backup ${db} ------------"
  echo ""

  docker exec $id rm -rf "/var/opt/mssql/data/${file:12}"
  sqlcmd -S $db_host -U $db_user -P $db_pass -Q "BACKUP DATABASE ${db} TO DISK = N'/var/opt/mssql/data/${file:12}'"
  docker cp "$id:/var/opt/mssql/data/${file:12}" /home/andrey.lashchenko/pet-projects/mssql-backuper/backups
done
echo $reset
