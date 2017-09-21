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
        trim(course_number)||'.'||trim(term_name)||'.'||trim(school_id)
    from clever_sections

	/* testing schools */
    WHERE trim(course_number)||'.'||trim(term_name)||'.'||trim(school_id) IN
('453c1c1.S1.592','445c2c1.S1.592','14008c2.S1.592','632c0c.S1.592','53055c3.S1.592','431111.S1.593','15011cde.S1.592','10043.S1.593','823c2c1.S1.592','826c2c1.S1.592','448c1c1.S1.592','20600.YR.420','330401.S1.420','20800.YR.435','40700.YR.435','2080e.YR.435','10600.YR.435','330401.S1.514','360801.S1.514','659s1.S1.455','87900.S1.455','441151.S1.525','655111.S1.525','411111.S1.525','661631.S1.525','10043.S1.525','110131.S1.515','160301.S1.515','063gd1.S1.515','40600.YR.465','51104.S1.465','7036.YR.415','07037.YR.415','060501.S1.530','803331.S1.580','803341.S1.580','803321.S1.580','15011de.S1.580','803311.S1.580','42111de1.S1.517','13011de.S1.580','330401.S1.580','310011.S1.580','11011de1.S1.580','20700.YR.413','0702a.YR.413','9082i1.S1.550','900001.S1.550','904501.S1.550','843041.S1.590','350401.S1.540','350402.S2.540','40800.YR.457')


)
select
    course_number,
    course_name as short_name,
    course_name as long_name,
    school_id as account_id,
    clever_terms.term_id as term_id,
    'active' as status
from
    sections_canvas
    left join clever_terms on trim(sections_canvas.term_name) = clever_terms.name
group by
    course_number,
    course_name,
    school_id,
    term_id
