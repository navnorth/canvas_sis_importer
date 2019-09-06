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
CREATE TEMP TABLE excludeTitlesList (exclude_title) AS VALUES ('ATHLETICS DIRECTOR','AVID TUTOR','BOOKKEEPER: HIGH SCHOOL','ED ASST: HEALTH','EDUC ASST: BEHAVIOR REDIRECTOR','EDUC ASST: CHAPTER 1','EDUC ASST: CHILD DEVELOPMENT','EDUC ASST: HEALTH','EDUC ASST: KINDER PRE','EDUC ASST: TITLE I','EDUCATIONAL ASST: HEALTH: ES','INTERPRETER FOR THE DEAF','LIAISON: EARLY CHILDHOOD','MANAGER: TITLE I INSTRUCTIONAL','NURSE','PATHOLOGIST: RELATED SERVICES','PATHOLOGIST: SPEECH-LANGUAGE','RES TEACHER: SP ED/PROF DEV','RESOURCE TEACHER: MUSIC','SOCIAL WORKER','SOCIAL WORKER-SP ED','SPECIALIST: BEHAVIOR MGMT','TEACHER: ADAPTED PE','TEACHER: BEHAVIOR INTERVENTION','TEACHER: CHILDFIND','TEACHER: ITINERANT ART','TEACHER: ITINERANT MUSIC','TEACHER: MUSIC/CHOR/BND/ORCH','TEACHER: TITLE I','TEACHER: TITLE I READING RECOV','TEACHER: TITLE VII','TEACHER: TRANSITION EARLY CHIL','TECHNICIAN: CHILDCARE','TEMP/HOURLY: ATHLETICS COACH','TEMP/HOURLY: ATHLETICS COACH','TEMPS/HOURLY: NON APS EMP','TEMPS/HOURLY: OTHER','TEMPS/HOURLY: TEACHER','THERAPIST: OCCUPATIONAL','THERAPIST: PHYSICAL','TRANS SPEC-REHAB COUNSELOR');

SELECT DISTINCT
    'TEST_SEC_STC' as course_id,
    trim(A.staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins A LEFT OUTER JOIN excludeTitlesList E ON trim(A.admin_title) = E.exclude_title
WHERE (trim(A.schedule) = 'SPE')

UNION

SELECT DISTINCT
    'TEST_SEC_TA' as course_id,
    trim(A.staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins A LEFT OUTER JOIN excludeTitlesList E ON trim(A.admin_title) = E.exclude_title
WHERE (trim(A.schedule) LIKE 'A SCHED%')

UNION

SELECT DISTINCT
    'TEST_SEC_STAFF' as course_id,
    trim(A.staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins A LEFT OUTER JOIN excludeTitlesList E ON trim(A.admin_title) = E.exclude_title
WHERE (trim(A.schedule) = 'G1 SCHED')


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
WHERE
    T.teacher_id not in (
        'e999008','e999101','e999102','e999103','e999105','e999998','e999999',
        '777777777',
        'closed_sec',
        'e222222222',
        'SpEdPen',
        'e576999'
    )

