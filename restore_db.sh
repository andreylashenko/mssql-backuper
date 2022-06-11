#!/bin/bash
source config.sh
red=`tput setaf 1`
reset=`tput sgr0`
echo ""
echo "${red}------------ Bak Recovery ------------"
echo ""
for file in `find ./files.bak/*.bak -type f `
do
   file_info=$(sqlcmd -S $db_host -U $db_user -P $db_pass -Q "RESTORE FILELISTONLY FROM DISK='$file';" | tail -n +3 | head -n -2 | awk '{ print $1 }')
   mdf=$(echo $file_info | awk '{print $1}')
   ldf=$(echo $file_info | awk '{print $2}')

   awk 'BEGIN { print "RESTORE DATABASE '$mdf' FROM DISK= '\'$file\''" }
        BEGIN { print "WITH MOVE '\'${mdf}\'' TO \"/var/opt/mssql/data/'${mdf}'.mdf\"," }
        BEGIN { print "MOVE '\'${ldf}\'' TO \"/var/opt/mssql/data/'${ldf}'.ldf\"" }' >./restore_3_TSQL.sql

   query_result=$(sqlcmd -S $db_host -U $db_user -P $db_pass -i ./restore_3_TSQL.sql);

   if [[ "$query_result" == *"RESTORE DATABASE successfully"* ]]; then
      green=`tput setaf 2`
      reset=`tput sgr0`
      echo "${green}Restored successfully: ${file:12}";
      echo "${reset}---------------------------------------------"
   else
      echo $query_result
      red=`tput setaf 1`
      echo "${red}Restored unsuccessfully: ${file:12}";
      echo "${reset}---------------------------------------------"
   fi

   rm ./restore_3_TSQL.sql
done
