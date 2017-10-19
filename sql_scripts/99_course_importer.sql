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

DO $$
DECLARE @listOfCourseIDs table (id TEXT);
BEGIN
  insert @listOfCourseIDs(id) values ('453c1c1.S1.592'),('445c2c1.S1.592'),('14008c2.S1.592'),('632c0c.S1.592'),('53055c3.S1.592'),('431111.S1.593'),('15011cde.S1.592'),('10043.S1.593'),('823c2c1.S1.592'),('826c2c1.S1.592'),('448c1c1.S1.592'),('20600.YR.420'),('330401.S1.420'),('20800.YR.435'),('40700.YR.435'),('2080e.YR.435'),('10600.YR.435'),('330401.S1.514'),('360801.S1.514'),('659s1.S1.455'),('87900.S1.455'),('441151.S1.525'),('655111.S1.525'),('411111.S1.525'),('661631.S1.525'),('10043.S1.525'),('110131.S1.515'),('160301.S1.515'),('063gd1.S1.515'),('40600.YR.465'),('51104.S1.465'),('7036.YR.415'),('07037.YR.415'),('060501.S1.530'),('803331.S1.580'),('803341.S1.580'),('803321.S1.580'),('15011de.S1.580'),('803311.S1.580'),('42111de1.S1.517'),('13011de.S1.580'),('330401.S1.580'),('310011.S1.580'),('11011de1.S1.580'),('20700.YR.413'),('0702a.YR.413'),('9082i1.S1.550'),('900001.S1.550'),('904501.S1.550'),('843041.S1.590'),('350401.S1.540'),('350402.S2.540'),('40800.YR.457');

	select DISTINCT
		trim(D.student_id) as user_id,
		trim(D.state_id) as integration_id,
		trim(D.student_id) as login_id,
		'3' as authentication_provider_id,
		regexp_replace(trim(D.first_name)||' '||trim(D.middle_name)||' '||trim(D.last_name), '\s+', ' ', 'g') as full_name,
		trim(D.student_email) as email,
		'active' as status
	FROM sis_import_students D INNER join sis_import_enrollments E on D.student_id = E.student_id
	INNER JOIN sis_import_sections SX on SX.section_id = E.section_id
	WHERE  SX.course_id IN (select id from @listOfCourseIDs)

	UNION

	SELECT DISTINCT
		trim(T.teacher_id) as user_id,
		trim(T.state_teacher_id) as integration_id,
		trim(T.teacher_id) as login_id,
		'3' as authentication_provider_id,
		trim(T.first_name)||'.'||' '||trim(T.middle_name)||'.'||' '||trim(T.last_name) as full_name,
		trim(T.teacher_email) as email,
		'active' as status
	FROM sis_import_teachers T INNER join sis_import_sections S on S.teacher_id = T.teacher_id
	WHERE
		T.teacher_id not like 'e999%'
		AND T.teacher_id not in (
			'777777777',
			'closed_sec',
			'e222222222',
			'SpEdPen',
			'e576999'
		)
	AND S.course_id IN (select id from @listOfCourseIDs)


END $$;
