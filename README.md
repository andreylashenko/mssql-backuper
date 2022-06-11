
# MSSQL Backuper
mssql docker with opportunity flexible backups managing.

project structure:

 - backups - directory contains backup files after using command ./create_backups.sh
 - databases - directory contains sql scripts for creating databases
 - files.bak - directory contains .bak files for restoring databases
 - files.sql - directory contains various sql files

## Project commands

```bash
# deploy docker with mssql and loading .bak files with sql scripts
$ ./build.sh
```

```bash
# create backups
$ ./create_backups.sh
```

```bash
# load backups (creating backups before loading)
$ ./load_backups.sh
```

```bash
# start container
$ ./start.sh
```

```bash
# stop container (create backups for stopping)
$ ./stop.sh
```

## notes

.bak file in files.bak directory must be named like database is.