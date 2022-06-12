./create_backups.sh
docker stop $(docker ps -a -q --filter ancestor=mssql-backuper_mssql --format="{{.ID}}")
