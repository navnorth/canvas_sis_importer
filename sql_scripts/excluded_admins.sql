/* find admins excluded */
SELECT DISTINCT
    trim(D.staff_id) as user_id,
    '' as integration_id,
    trim(D.staff_id) as login_id,
    INITCAP(trim(D.first_name)||' '||trim(D.last_name)) as full_name,
    trim(D.admin_email) as email,
    D.Schedule,
    D.school_id, S.School_name
FROM sis_import_admins D
    LEFT JOIN sis_import_schools S ON S.school_id = D.school_id

WHERE ( trim(D.schedule) NOT LIKE 'A SCHED%')
    AND trim(D.schedule) NOT IN ('SPE','G1 SCHED')
ORDER BY user_id
