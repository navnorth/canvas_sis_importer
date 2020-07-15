#!/usr/bin/env bash

# Copyright (C) 2020 - present Navigation North
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# you can run this manually if logged in as postgres
# ./import_sis_data.sh /home/postgres/disabled.csv apscanvas`

importCSVFile=$1
if ! [[ -f $importCSVFile ]]; then
  echo 'first argument should be a CSV file with the APS disabled account export in it'
  exit 1
fi

database=$2
database_auth=$3

# tmp directory for manipulating import files
importTmpDir=$( pwd -P )/tmp
mkdir -p ${importTmpDir}

# process the SIS source file

fileName=$(basename $importCSVFile)

#copy to tmpDir
cp $importCSVFile ${importTmpDir}/

# convert to UTF-8, and hopefully the ñ won't kill it
vim +"set nobomb | set fenc=utf8 | x" "${importTmpDir}/$fileName"

# remove the header
sed -i '1d' "${importTmpDir}/$fileName"

echo "finished processing $fileName"

# if you need to create the initial table, use this
# create table sis_disabled (id serial PRIMARY KEY,first_name varchar(255) null,last_name varchar(255) null,sis_id varchar(64) not null,status bool not null);

psql -d ${database} ${database_auth} -c "copy sis_disabled(first_name, last_name, sis_id, status) from '${importTmpDir}/$fileName' with (FORMAT csv);"

echo "Exporting Disabled Users"
statement=`cat select_users_disabled.sql | tr '\n' ' '`
psql -d ${database} ${database_auth} -c "copy ($statement) to stdout with csv header delimiter ',';" > ../canvas_csvs/users_disabled_$(date +"%Y%m%d").csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

cd ../canvas_csvs

echo "Finished exporting Disabled Users"
echo "...almost done, now go home and do :"
echo "scp $(hostname):$(pwd)/users_disabled_$(date +"%Y%m%d").csv ./"




# cleanup tmp files
rm -Rf ${importTmpDir}

