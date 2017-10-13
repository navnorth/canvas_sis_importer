select
    trim(staff_id) as user_id,
    '' as integration_id,
    trim(staff_id) as login_id,
    '3' as authentication_provider_id,
    trim(first_name)||' '||trim(last_name) as full_name,
    trim(admin_email) as email,
    'active' as status
from sis_import_admins
