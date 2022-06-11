docker-compose up --build -d
sleep 5
./restore_db.sh
./load_sql.sh