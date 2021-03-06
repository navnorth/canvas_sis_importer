/*
 Copyright (C) 2017 - present Navigation North

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

begin;

DROP TABLE IF EXISTS sis_import_admins;

CREATE TABLE IF NOT EXISTS sis_import_admins (
    id serial,
    school_id text,
    staff_id text,
    admin_email text,
    first_name text,
    last_name text,
    admin_title text,
    username text,
    password text,
    schedule text
);

DROP TABLE IF EXISTS sis_import_enrollments;

CREATE TABLE IF NOT EXISTS sis_import_enrollments (
    id serial,
    school_id text,
    section_id text,
    student_id text,
    imported bool NOT NULL DEFAULT FALSE

);

DROP TABLE IF EXISTS sis_import_schools;

CREATE TABLE IF NOT EXISTS sis_import_schools (
    id serial,
    school_id text,
    state_id text,
    school_name text,
    school_address text,
    school_city text,
    school_state text,
    school_zip text,
    school_phone text,
    low_grade text,
    high_grade text,
    principal text,
    principal_email text
);

DROP TABLE IF EXISTS sis_import_sections;

CREATE TABLE IF NOT EXISTS sis_import_sections (
    id serial,
    school_id text,
    section_id text,
    teacher_id text,
    name text,
    grade text,
    course_name text,
    course_number text,
    period text,
    subject text,
    term_name text
);

DROP TABLE IF EXISTS sis_import_students;

CREATE TABLE IF NOT EXISTS sis_import_students (
    id serial,
    school_id text,
    student_id text,
    student_number text,
    state_id text,
    last_name text,
    middle_name text,
    first_name text,
    grade text,
    gender text,
    dob text,
    race text,
    hispanic_latino text,
    ell_status text,
    frl_status text,
    iep_status text,
    student_street text,
    student_city text,
    student_state text,
    student_zip text,
    student_email text,
    contact_relationship text,
    contact_type text,
    contact_name text,
    contact_phone text,
    contact_email text,
    username text,
    password text
);

DROP TABLE IF EXISTS sis_import_teachers;

CREATE TABLE IF NOT EXISTS sis_import_teachers (
    id serial,
    school_id text,
    teacher_id text,
    teacher_number text,
    state_teacher_id text,
    last_name text,
    middle_name text,
    first_name text,
    teacher_email text,
    title text,
    username text,
    password text
);

commit;
