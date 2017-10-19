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

select
    trim(staff_id) as user_id,
    '' as integration_id,
    trim(staff_id) as login_id,
    '3' as authentication_provider_id,
    trim(first_name)||' '||trim(last_name) as full_name,
    trim(admin_email) as email,
    'active' as status
from sis_import_admins
