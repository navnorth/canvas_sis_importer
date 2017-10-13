with sections_canvas as (
    select
        school_id,
        section_id,
        teacher_id,
        name,
        grade,
        course_name,
        course_number,
        period,
        subject,
        term_name,
        trim(course_number)||'.'||trim(term_name)||'.'||trim(school_id) as course_id
    from sis_import_sections

    /* testing schools */
    WHERE trim(course_number)||'.'||trim(term_name)||'.'||trim(school_id) IN
('453c1c1.S1.592','445c2c1.S1.592','14008c2.S1.592','632c0c.S1.592','53055c3.S1.592','431111.S1.593','15011cde.S1.592','10043.S1.593','823c2c1.S1.592','826c2c1.S1.592','448c1c1.S1.592','20600.YR.420','330401.S1.420','20800.YR.435','40700.YR.435','2080e.YR.435','10600.YR.435','330401.S1.514','360801.S1.514','659s1.S1.455','87900.S1.455','441151.S1.525','655111.S1.525','411111.S1.525','661631.S1.525','10043.S1.525','110131.S1.515','160301.S1.515','063gd1.S1.515','40600.YR.465','51104.S1.465','7036.YR.415','07037.YR.415','060501.S1.530','803331.S1.580','803341.S1.580','803321.S1.580','15011de.S1.580','803311.S1.580','42111de1.S1.517','13011de.S1.580','330401.S1.580','310011.S1.580','11011de1.S1.580','20700.YR.413','0702a.YR.413','9082i1.S1.550','900001.S1.550','904501.S1.550','843041.S1.590','350401.S1.540','350402.S2.540','40800.YR.457')


), section_canvas_grouped as (
    select
        section_id,
        course_number,
        name
    from
        sections_canvas
    group by
        section_id,
        course_number,
        name
)
select
    student_id as user_id,
    'student' as role,
    '' as role_id,
    scg.section_id as section_id,
    'active' as status,
	TRUE as limit_section_privileges
from
    sis_import_enrollments e
        inner join section_canvas_grouped scg on trim(e.section_id) = scg.section_id
/*
where scg.course_id IN ('250311.S1.590','803331.S1.580','803341.S1.580','803321.S1.580','42111de1.S1.517')
*/
