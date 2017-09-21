#!/bin/bash

mkdir csv_canvas >/dev/null 2>&1

for exportfile in 03_terms 04_accounts 05_userteachers 06_userstudents 07_courses 08_sections 09_students 10_teachers
do
    IFS='_' read -a exportfile_a <<< "$exportfile"
    echo "Exporting ${exportfile_a[1]}."
    statement=`cat ${exportfile_a[0]}_select_${exportfile_a[1]}.sql | tr '\n' ' '`
    psql -d apscanvas -c "copy ($statement) to stdout with csv header delimiter ',';" > ../source_folder/${exportfile_a[1]}.csv
    echo "Exported to: ../source_folder/${exportfile_a[1]}.csv"
    echo
done
