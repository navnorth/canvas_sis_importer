/*
 Copyright (C) 2020 - present Navigation North

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

SELECT DISTINCT CONCAT(trim(D.first_name), ' ', trim(D.last_name)) AS deactivated_name, U.name AS canvas_name, P.unique_id,
	P.last_login_at,  U.created_at, U.updated_at, U.deleted_at
FROM sis_disabled D INNER JOIN pseudonyms P ON P.unique_id = D.sis_id
INNER JOIN users U on U.id = P.user_id
WHERE U.deleted_at IS NULL
ORDER BY P.unique_id

