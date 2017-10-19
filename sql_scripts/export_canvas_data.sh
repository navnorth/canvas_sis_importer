#!/bin/bash

mkdir ../canvas_csvs >/dev/null 2>&1
rm -r ../canvas_csvs/* >/dev/null 2>&1

database=$1
database_auth=$2

#####  Commented out in favor of just doing users.csv.
#for exportfile in 03_terms 04_accounts 05_userteachers 06_userstudents 07_courses 08_sections 09_students 10_teachers
#do
#    IFS='_' read -a exportfile_a <<< "$exportfile"
#    echo "Exporting ${exportfile_a[1]}."
#    statement=`cat ${exportfile_a[0]}_select_${exportfile_a[1]}.sql | tr '\n' ' '`
#    psql -d ${database} ${database_auth} -c "copy ($statement) to stdout with csv header delimiter ',';" > ../canvas_csvs/${exportfile_a[1]}.csv
#    rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
#    echo "Exported to: ../canvas_csvs/${exportfile_a[1]}.csv"
#    echo
#done

echo "Exporting Users"
statement=`cat select_users_by_school.sql | tr '\n' ' '`
psql -d ${database} ${database_auth} -c "copy ($statement) to stdout with csv header delimiter ',';" > ../canvas_csvs/users.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
echo "Finished exporting Users"
echo

# Test Security enrollments for certain employees
echo "Exporting Test Security Enrollments"
statement=`cat select_admins_testing_enrollment.sql | tr '\n' ' '`
psql -d ${database} ${database_auth} -c "copy ($statement) to stdout with csv header delimiter ',';" > ../canvas_csvs/enrollments.csv
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
echo "Finished exporting Test Security Enrollments"
echo
