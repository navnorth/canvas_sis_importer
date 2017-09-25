#!/usr/bin/env bash

for importfile in 01_schema 02_terms
do
    IFS='_' read -a createfile_a <<< "$importfile"
    echo "Creating ${createfile_a[1]}."
    psql -d apscanvas -f ${createfile_a[0]}_create_${createfile_a[1]}.sql
    echo "Created ${createfile_a[1]}"
    echo
done

importDir=$1
if ! [[ -d $importDir ]]; then
  echo 'first argument should be a directory with the APS export in it'
  exit 1
fi

psql -d apscanvas -c "copy clever_admins(school_id, staff_id, admin_email, first_name, last_name, admin_title, username, password) from '${importDir}/admins.csv' with (FORMAT csv);"
psql -d apscanvas -c "copy clever_enrollments(school_id, section_id, student_id) from '${importDir}/enrollments.csv' with (FORMAT csv);"
psql -d apscanvas -c "copy clever_schools(school_id, state_id, school_name, school_address, school_city, school_state, school_zip, school_phone, low_grade, high_grade, principal, principal_email) from '${importDir}/schools.csv' with (FORMAT csv);"
psql -d apscanvas -c "copy clever_sections(school_id, section_id, teacher_id, name, grade, course_name, course_number, period, subject, term_name) from '${importDir}/sections.csv' with (FORMAT csv);"
psql -d apscanvas -c "copy clever_students(school_id, student_id, student_number, state_id, last_name, middle_name, first_name, grade, gender, dob, race, hispanic_latino, ell_status, frl_status, iep_status, student_street, student_city, student_state, student_zip, student_email, contact_relationship, contact_type, contact_name, contact_phone, contact_email, username, password) from '${importDir}/students.csv' with (FORMAT csv);"
psql -d apscanvas -c "copy clever_teachers(school_id, teacher_id, teacher_number, state_teacher_id, last_name, middle_name, first_name, teacher_email, title, username, password) from '${importDir}/teachers.csv' with (FORMAT csv);"
