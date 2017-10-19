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

select DISTINCT
    trim(D.student_id) as user_id,
    trim(D.state_id) as integration_id,
    trim(D.student_id) as login_id,
    '3' as authentication_provider_id,
    regexp_replace(trim(D.first_name)||' '||trim(D.middle_name)||'. '||trim(D.last_name), ' . ', ' ', 'g') as full_name,
    trim(D.student_email) as email,
    'active' as status
FROM sis_import_students D INNER join sis_import_enrollments E on D.student_id = E.student_id
    INNER JOIN sis_import_sections SX on SX.section_id = E.section_id
    /* INNER JOIN accounts A ON  A.sis_source_id = SX.school_id */

UNION

SELECT DISTINCT
    trim(T.teacher_id) as user_id,
    trim(T.state_teacher_id) as integration_id,
    trim(T.teacher_id) as login_id,
    '3' as authentication_provider_id,
    regexp_replace(trim(T.first_name)||'. '||trim(T.middle_name)||'. '||trim(T.last_name), ' . ', ' ', 'g') as full_name,
    trim(T.teacher_email) as email,
    'active' as status
FROM sis_import_teachers T INNER join sis_import_sections S on S.teacher_id = T.teacher_id
    /* INNER JOIN accounts A ON  A.sis_source_id = S.school_id */

WHERE
    T.teacher_id not like 'e999%'
    AND T.teacher_id not in (
        '777777777',
        'closed_sec',
        'e222222222',
        'SpEdPen',
        'e576999'
    )
