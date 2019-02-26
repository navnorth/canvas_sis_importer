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

select
    'TEST_SEC_STC' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins
WHERE ( (trim(schedule) = 'SPE') OR (trim(schedule) = 'A SCHED2') OR (trim(schedule) = 'A SCHED4') OR (trim(schedule) = 'PSN') )

UNION

select
    'TEST_SEC_TA' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins
WHERE ( (trim(schedule) LIKE 'A SCHED%') OR (trim(schedule) = 'PSN') )

UNION

select
    'TEST_SEC_STAFF' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    sis_import_admins
WHERE ( (trim(schedule) = 'G1 SCHED') OR (trim(schedule) = 'A SCHED2') OR (trim(schedule) = 'A SCHED4') OR (trim(schedule) = 'PSN') )

