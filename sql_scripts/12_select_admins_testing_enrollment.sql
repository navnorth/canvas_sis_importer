select
    'TEST_SEC_STC' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    clever_admins
WHERE trim(schedule) = 'SPE'

UNION

select
    'TEST_SEC_TA' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    clever_admins
WHERE trim(schedule) LIKE 'A SCHED%'

UNION

select
    'TEST_SEC_STAFF' as course_id,
    trim(staff_id) as user_id,
    'student' as role,
    '' as role_id,
    '' as section_id,
    'active' as status
from
    clever_admins
WHERE trim(schedule) = 'G1 SCHED'
