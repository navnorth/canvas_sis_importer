/* find teachers that are excluded */
SELECT DISTINCT
    trim(T.teacher_id) as user_id,
    trim(T.state_teacher_id) as integration_id,
    trim(T.teacher_id) as login_id,
    regexp_replace(trim(T.first_name)||'. '||trim(T.middle_name)||'. '||trim(T.last_name), ' . ', ' ', 'g') as full_name,
    trim(T.teacher_email) as email,
    trim(S.Section_id) as section_id
FROM sis_import_teachers T LEFT OUTER join sis_import_sections S on S.teacher_id = T.teacher_id
WHERE section_id IS NULL
ORDER BY user_id
