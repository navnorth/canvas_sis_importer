select DISTINCT
    trim(A.staff_id) as user_id,
    '' as integration_id,
    trim(A.staff_id) as login_id,
    '3' as authentication_provider_id,
    INITCAP(trim(A.first_name)||' '||trim(A.last_name)) as full_name,
    trim(A.admin_email) as email,
    'active' as status
FROM clever_admins A
WHERE A.staff_id IN ('e205436','e208286','e201316','e202048','e207766','e204458','e119065','e200697','e121335','e126360','e126852','e138709','e130383','e131490','e212243','e076245','e210967','e210738','e137484','e212120','e141150','e210370','e131117','e210678','e140670','e117566','e200330','e128354','e205257','e103102','e108346','e211922','e211195','e035004','e113324','e116592','e211612','e127959','e127997','e115480','e205153','e126891','e135123','e135428','e106816','e129479','e129463','e207416','e121374','e101991','e135716','e139448','e104010','e204494','e208838','e021434','e109563','e204920','e008838','e205951','e107648','e207962','e114031','e132965','e206157','e121892','e139898','e212506','e204412','e124657','e212245','e124443','e118138','e110279','e130428','e208472','e201256','e207906','e203053','e204158','e202135','e204610','e071822','e206349','e202012','e121599','e107850','e119169','e130429','e210400','e209774','e114212','e125602','e049348','e120797','e136705','e201994','e130565','e204826','e136091','e209965','e206976','e211846','e117027','e212186','e208841','e138007','e130558','e139584','e105240','e209450','e205142','e212016','e067470','e118143','e212042','e210932','e204181','e212239','e207052','e141043','e128702','e202104','e005588','e119262','e102482','e120066','e206584','e114448','e131021','e137096','e108045','e207052','e141043','e128702','e202104','e005588','e119262','e102482','e120066','e206584','e114448','e131021','e137096','e108045','e127133','e114375','e122080','e210498','e136285','e131191','e132797','e212227','e139615','e130768','e210599','e210646','e129514','e130334','e116517','e104168','e112740','e107179','e125445','e130009','e207136','e211273','e141660','e205280','e063631','e211789','e117838','e203376','e207829','e135504','e131891','e204672','e204380','e206498','e204848','e211242','e210318','e122622','e118020','e138486','e108523','e130514','e106318','e138984','e201900','e106547','e132764','e139603','e134874','e203856','e134142','e136131')

UNION

select DISTINCT
    trim(D.student_id) as user_id,
    trim(D.state_id) as integration_id,
    trim(D.student_id) as login_id,
    '3' as authentication_provider_id,
    regexp_replace(trim(D.first_name)||' '||trim(D.middle_name)||'. '||trim(D.last_name), ' . ', ' ', 'g') as full_name,
    trim(D.student_email) as email,
    'active' as status
FROM clever_students D INNER join clever_enrollments E on D.student_id = E.student_id
INNER JOIN clever_sections SX on SX.section_id = E.section_id
WHERE D.student_id IN ('970071745','970038353','970071761','970065768','980031768','980028303','970022553','189115587','980025564','970026624','970071029','980044842','980039337','980012385','970076403','980005945','970052821','970074722','970035063','970074983','970064642','970070542','980042591','970025939','970096521','970074594','970074456','970070151','970035868','970076706','980042751','980042511','980034823','970072214','970034377','970042229','980042593','970071027','970089309','970075492','980022741','970071398','980019808','980017613','970074647')

UNION

SELECT DISTINCT
    trim(T.teacher_id) as user_id,
    trim(T.state_teacher_id) as integration_id,
    trim(T.teacher_id) as login_id,
    '3' as authentication_provider_id,
    regexp_replace(trim(T.first_name)||'. '||trim(T.middle_name)||'. '||trim(T.last_name), ' . ', ' ', 'g') as full_name,
    trim(T.teacher_email) as email,
    'active' as status
FROM clever_teachers T INNER join clever_sections S on S.teacher_id = T.teacher_id
WHERE
    T.teacher_id not like 'e999%'
    AND T.teacher_id not in (
        '777777777',
        'closed_sec',
        'e222222222',
        'SpEdPen',
        'e576999'
    )
AND T.teacher_id IN ('e205436','e208286','e201316','e202048','e207766','e204458','e119065','e200697','e121335','e126360','e126852','e138709','e130383','e131490','e212243','e076245','e210967','e210738','e137484','e212120','e141150','e210370','e131117','e210678','e140670','e117566','e200330','e128354','e205257','e103102','e108346','e211922','e211195','e035004','e113324','e116592','e211612','e127959','e127997','e115480','e205153','e126891','e135123','e135428','e106816','e129479','e129463','e207416','e121374','e101991','e135716','e139448','e104010','e204494','e208838','e021434','e109563','e204920','e008838','e205951','e107648','e207962','e114031','e132965','e206157','e121892','e139898','e212506','e204412','e124657','e212245','e124443','e118138','e110279','e130428','e208472','e201256','e207906','e203053','e204158','e202135','e204610','e071822','e206349','e202012','e121599','e107850','e119169','e130429','e210400','e209774','e114212','e125602','e049348','e120797','e136705','e201994','e130565','e204826','e136091','e209965','e206976','e211846','e117027','e212186','e208841','e138007','e130558','e139584','e105240','e209450','e205142','e212016','e067470','e118143','e212042','e210932','e204181','e212239','e207052','e141043','e128702','e202104','e005588','e119262','e102482','e120066','e206584','e114448','e131021','e137096','e108045','e207052','e141043','e128702','e202104','e005588','e119262','e102482','e120066','e206584','e114448','e131021','e137096','e108045','e127133','e114375','e122080','e210498','e136285','e131191','e132797','e212227','e139615','e130768','e210599','e210646','e129514','e130334','e116517','e104168','e112740','e107179','e125445','e130009','e207136','e211273','e141660','e205280','e063631','e211789','e117838','e203376','e207829','e135504','e131891','e204672','e204380','e206498','e204848','e211242','e210318','e122622','e118020','e138486','e108523','e130514','e106318','e138984','e201900','e106547','e132764','e139603','e134874','e203856','e134142','e136131')
