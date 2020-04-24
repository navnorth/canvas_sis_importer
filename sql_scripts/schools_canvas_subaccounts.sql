SELECT trim(S.School_id) as school_id, trim(S.School_name) as school_name, A.id as canvas_subaccount_id, A.name as canvas_sub_acccount,
'https://canvas.aps.edu/accounts/'||A.id AS Canvas_Link
FROM sis_import_schools S INNER JOIN accounts A ON  A.sis_source_id = S.school_id
ORDER BY school_name
