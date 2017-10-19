#!/usr/bin/env bash

# Copyright (C) 2017 - present Navigation North
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
