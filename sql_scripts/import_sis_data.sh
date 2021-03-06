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

importDir=$1
if ! [[ -d $importDir ]]; then
  echo 'first argument should be a directory with the APS export in it'
  exit 1
fi

database=$2
database_auth=$3

# tmp directory for manipulating import files
importTmpDir=$( pwd -P )/tmp
mkdir -p ${importTmpDir}

for importfile in 01_schema 02_terms
do
    IFS='_' read -a createfile_a <<< "$importfile"
    echo "Running ${createfile_a[1]}."
    psql -d ${database} ${database_auth} -f ${createfile_a[0]}_create_${createfile_a[1]}.sql
    rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi
    echo "Finished ${createfile_a[1]}"
    echo
done

# process each of the SIS source files
for f in ${importDir}/*.csv
do
    fileName=$(basename $f)

    #copy to tmpDir
    cp $f ${importTmpDir}/

    # convert to UTF-8, and hopefully the ñ won't kill it
    vim +"set nobomb | set fenc=utf8 | x" "${importTmpDir}/$fileName"

    # remove the header
    sed -i '1d' "${importTmpDir}/$fileName"

    echo "finished processing $fileName"
done


psql -d ${database} ${database_auth} -c "copy sis_import_admins(school_id, staff_id, admin_email, first_name, last_name, admin_title, username, password, schedule) from '${importTmpDir}/admins.csv' with (FORMAT csv);"
psql -d ${database} ${database_auth} -c "copy sis_import_enrollments(school_id, section_id, student_id) from '${importTmpDir}/enrollments.csv' with (FORMAT csv);"
psql -d ${database} ${database_auth} -c "copy sis_import_schools(school_id, state_id, school_name, school_address, school_city, school_state, school_zip, school_phone, low_grade, high_grade, principal, principal_email) from '${importTmpDir}/schools.csv' with (FORMAT csv);"
psql -d ${database} ${database_auth} -c "copy sis_import_sections(school_id, section_id, teacher_id, name, grade, course_name, course_number, period, subject, term_name) from '${importTmpDir}/sections.csv' with (FORMAT csv);"
psql -d ${database} ${database_auth} -c "copy sis_import_students(school_id, student_id, student_number, state_id, last_name, middle_name, first_name, grade, gender, dob, race, hispanic_latino, ell_status, frl_status, iep_status, student_street, student_city, student_state, student_zip, student_email, contact_relationship, contact_type, contact_name, contact_phone, contact_email, username, password) from '${importTmpDir}/students.csv' with (FORMAT csv);"
psql -d ${database} ${database_auth} -c "copy sis_import_teachers(school_id, teacher_id, teacher_number, state_teacher_id, last_name, middle_name, first_name, teacher_email, title, username, password) from '${importTmpDir}/teachers.csv' with (FORMAT csv);"

# cleanup tmp files
rm -Rf ${importTmpDir}
