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

DROP TABLE IF EXISTS excludeTitlesList;
CREATE TEMP TABLE excludeTitlesList (exclude_title) AS VALUES ('ATHLETICS DIRECTOR'),('ATHLETICS TRAINER'),('AUDIOLOGIST'),('COSMETOLOGIST'),('EDUC ASST: BEHAVIOR REDIRECTOR'),('EDUC ASST: CHILD DEVELOPMENT'),('EDUC ASST: HEALTH'),('EDUC ASST: KINDER PRE'),('EDUC ASST: PRE-KINDER'),('EDUC ASST: SP ED KINDER PRE'),('EDUCATIONAL DIAGNOSTICIAN'),('ELL DISTRICT COACH'),('EXCEPTIONAL STUDENT DISTRICT S'),('INTERPRETER FOR THE DEAF'),('NURSE'),('ORIENTATION/MOBILITY INSTRUCT'),('PATHOLOGIST: RELATED SERVICES'),('PATHOLOGIST: SPEECH-LANGUAGE'),('PRINCIPAL SUPPORT: RIO CLUSTER'),('RES TEACHER: APS/UNM PARTNER'),('RES TEACHER: LANG/CULTURE'),('RES TEACHER: SP ED/PROF DEV'),('RES TEACHER: TITLE I'),('RES TEACHER: TLS'),('RESOURCE TEACHER: ART'),('RESOURCE TEACHER: ASSESSMENT'),('RESOURCE TEACHER: INDIAN ED'),('RESOURCE TEACHER: LANG/CULTUR'),('RESOURCE TEACHER: MUSIC'),('SCHOOL PSYCHOLOGIST SP ED'),('SOCIAL WORKER'),('SOCIAL WORKER-REL SERVICES'),('SOCIAL WORKER-SP ED'),('SPECIALIST: BEHAVIOR MGMT'),('TEACHER: ADAPTED PE'),('TEACHER: ADAPTIVE PE'),('TEACHER: CHILDFIND'),('TEACHER: PAR CONSULTING'),('TEACHER: PROF LEARNING OFFICE'),('TEACHER: STEM IMPLEMENTATION'),('TEMP/HOURLY: ATHLETICS COACH'),('TEMP/HOURLY: OTHER'),('TEMPS/HOURLY: ACTIVITY LEADER'),('THERAPIST: OCCUPATIONAL'),('THERAPIST: OCCUP-REL SERVICE'),('THERAPIST: PHYSICAL'),('TRANS SPEC-REHAB COUNSELOR');

SELECT DISTINCT
    'TEST_SEC_STC' as course_id,
    trim(A.staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins A
WHERE ( trim(A.admin_title) NOT IN (SELECT exclude_title FROM excludeTitlesList) )
    AND (trim(A.schedule) = 'SPE')

UNION

SELECT DISTINCT
    'TEST_SEC_TA' as course_id,
    trim(A.staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins A
WHERE ( trim(A.admin_title) NOT IN (SELECT exclude_title FROM excludeTitlesList) )
    AND (trim(A.schedule) LIKE 'A SCHED%')

UNION

SELECT DISTINCT
    'TEST_SEC_STAFF' as course_id,
    trim(A.staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins A
WHERE ( trim(A.admin_title) NOT IN (SELECT exclude_title FROM excludeTitlesList) )
    AND (trim(A.schedule) = 'G1 SCHED')


/* put all teachers in TA course */
UNION

SELECT DISTINCT
    'TEST_SEC_TA' as course_id,
    trim(T.teacher_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_teachers T LEFT OUTER JOIN excludeTitlesList E ON trim(T.title) = E.exclude_title
WHERE ( trim(T.title) NOT IN (SELECT exclude_title FROM excludeTitlesList) ) AND
    ( trim(T.title) NOT LIKE '%PRINCIPAL%') AND
    trim(T.teacher_id) not in (
        'e999008','e999101','e999102','e999103','e999105','e999998','e999999',
        '777777777',
        'closed_sec',
        'e222222222',
        'SpEdPen',
        'e576999'
    )

