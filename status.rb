#
# Copyright (C) 2017 - present Navigation North
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'date'
require 'json'
require 'unirest'
require 'yaml'
# Load ENV variables from .env
require 'dotenv/load'

# These should all be pulled in through environment variables
access_token = ENV['CANVAS_IMPORT_ACCESS_TOKEN']
domain = ENV['CANVAS_IMPORT_DOMAIN'] || 'canvas.instructure.com'
protocol = ENV['CANVAS_IMPORT_DOMAIN_PROTO'] || 'https'

puts "What Canvas job do you want status for? "
job_id = gets.strip

test_url = "#{protocol}://#{domain}/api/v1/accounts/self"
endpoint_url = "#{test_url}/sis_imports.json?import_type=instructure_csv"

# Make generic API call to test token, domain, and env.
test = Unirest.get(test_url, headers: { "Authorization" => "Bearer #{access_token}" })

unless test.code == 200
  raise "Error: The token, domain, or env variables are not set correctly"
end

# echo the start time
time1 = Time.new
puts "Uploaded zip at " + time1.inspect

import_status_url = "#{test_url}/sis_imports/#{job_id}"
puts "Status url is " + import_status_url

import_status = Unirest.get(import_status_url,
                              headers: {
                                  "Authorization" => "Bearer #{access_token}"
                              }
  )
job = import_status.body

while job["workflow_state"] == "created" || job["workflow_state"] == "importing"
  puts "importing: #{job['progress']} %"
  sleep(10)

  import_status = Unirest.get(import_status_url,
                              headers: {
                                  "Authorization" => "Bearer #{access_token}"
                              }
  )
  job = import_status.body
end
