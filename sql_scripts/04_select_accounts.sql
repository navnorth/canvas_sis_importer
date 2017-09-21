select
    school_id as account_id,
    null as parent_account_id,
    school_name as name,
    'active' as status
from
    clever_schools
WHERE school_id IN ('590','580','420')
