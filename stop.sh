./create_backups.sh
docker stop $(docker ps -a -q --filter ancestor=mssql_mssql --format="{{.ID}}")
