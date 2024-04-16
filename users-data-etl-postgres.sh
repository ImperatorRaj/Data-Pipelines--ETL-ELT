#!/bin/bash

# Extracts data from /etc/passwd file into a CSV file.
echo "Extracting data"
# The csv data file contains the user name, user id and
# home directory of each user account defined in /etc/passwd
cut -d":" -f1,3,6 /etc/passwd > extracted-data-users.txt

# Transforms the text delimiter from ":" to ",".
tr ":" "," < extracted-data-users.txt > transformed-users.csv
# Loads the data from the CSV file into a table in PostgreSQL database.
echo "\c postgres; \COPY users FROM '/home/prahmodh/Temperature_ETL_Pipeline/transformed-users.csv' DELIMITERS ',' CSV;" | psql -U postgres -h '127.0.0.1'
