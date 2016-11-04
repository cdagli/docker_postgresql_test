#!/bin/sh
createdb -U docker -T template_postgis $1

DELIMITER=${2:-;}

SQL_FILES=/data/*.sql
for file in $SQL_FILES
do
    psql -U docker -d $1 -f $file
done

DATA_FILES=/data/*.csv
for fullfile in $DATA_FILES
do
    filename=$(basename "$fullfile")
    extension="${filename##*.}"
    filename="${filename%.*}"
    echo "Processing $filename file..."
    psql -U docker -d $1 -c "COPY $filename FROM '$fullfile' DELIMITER '$DELIMITER' CSV";
done
