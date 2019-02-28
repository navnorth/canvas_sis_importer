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

SELECT DISTINCT
    'TEST_SEC_STC' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins
WHERE (trim(schedule) = 'SPE')

UNION

SELECT DISTINCT
    'TEST_SEC_TA' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins
WHERE (trim(schedule) LIKE 'A SCHED%')

UNION

SELECT DISTINCT
    'TEST_SEC_STAFF' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins
WHERE (trim(schedule) = 'G1 SCHED')


/* put all teachers in TA course */
UNION

SELECT DISTINCT
    'TEST_SEC_TA' as course_id,
    trim(teacher_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_teachers
WHERE
    teacher_id not in (
        'e999008','e999101','e999102','e999103','e999105','e999998','e999999',
        '777777777',
        'closed_sec',
        'e222222222',
        'SpEdPen',
        'e576999'
    )

