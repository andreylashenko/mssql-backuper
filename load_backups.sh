./start.sh
./create_backups.sh
rm -r ./files.bak/*
cp ./backups/* ./files.bak
./build.sh
