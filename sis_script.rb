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

require 'fileutils'
require 'date'
require 'json'
require 'unirest'
require 'zip'
require 'yaml'
# Load ENV variables from .env
require 'dotenv/load'

# These should all be pulled in through environment variables
access_token = ENV['CANVAS_IMPORT_ACCESS_TOKEN']
domain = ENV['CANVAS_IMPORT_DOMAIN'] || 'canvas.instructure.com'
source_folder = 'canvas_csvs' # This is an internal setting that shouldn't need to be modified
archive_folder = ENV['CANVAS_IMPORT_ARCHIVE_FOLDER'] || 'archived_imports'
protocol = ENV['CANVAS_IMPORT_DOMAIN_PROTO'] || 'https'
sis_export_folder = File.join(Dir.getwd, ENV['CANVAS_IMPORT_SOURCE_FOLDER'] || 'data')
environment = ENV['ENVIRONMENT'] || 'development'
database_config = YAML.load(File.read(ENV['CANVAS_DATABASE_YML']))[environment]
database = ENV['CANVAS_IMPORT_DATABASE'] || 'canvas'

raise "CANVAS_IMPORT_ARCHIVE_FOLDER isn't a directory" unless File.directory?(archive_folder)
raise "CANVAS_IMPORT_SOURCE_FOLDER isn't a directory" unless File.directory?(sis_export_folder)

if not database_config.nil?
  database_auth = "'--host=#{database_config['host']} --username=#{database_config['username']} -w'"
  database_password = "PGPASSWORD=#{database_config['password']} "
else
  puts 'No database.yml was loaded...'
  database_auth = ''
  database_password = ''
end
####
# run all those import and export scripts

Dir.chdir('sql_scripts') do
  puts `#{database_password}./import_sis_import_data.sh #{sis_export_folder} #{database} #{database_auth}`
  raise "Error: Importing from SIS CSVs failed!" if $? != 0
  puts `#{database_password}./export_canvas_data.sh #{database} #{database_auth}`
  raise "Error: Exporting from translation database failed!" if $? != 0
end

test_url = "#{protocol}://#{domain}/api/v1/accounts/self"
endpoint_url = "#{test_url}/sis_imports.json?import_type=instructure_csv"

# Make generic API call to test token, domain, and env.
test = Unirest.get(test_url, headers: { "Authorization" => "Bearer #{access_token}" })

unless test.code == 200
  raise "Error: The token, domain, or env variables are not set correctly"
end

# Methods to check if the source_folder works
unless Dir.exist?(source_folder)
  raise "Error: source_folder isn't a directory, or can't be located."
end

unless Dir.entries(source_folder).detect {|f| f.match /.*(.csv)/}
  raise "Error: There are no CSV's in the source directory"
end

unless Dir.exist?(archive_folder)
  Dir.mkdir archive_folder
  puts "Created archive folder at #{archive_folder}"
end

files_to_zip = []
Dir.foreach(source_folder) { |file| files_to_zip.push(file) }

zipfile_name = "#{source_folder}/archive.zip"
Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  files_to_zip.each do |file|
    zipfile.add(file, "#{source_folder}/#{file}")
  end
end

#Push to the CSV API endpoint.
upload = Unirest.post(endpoint_url,
                      headers: {
                          "Authorization" => "Bearer #{access_token}"
                      },
                      parameters: {
                          attachment: File.new(zipfile_name, "r")
                      }
)
job = upload.body

import_status_url = "#{test_url}/sis_imports/#{job['id']}"

while job["workflow_state"] == "created" || job["workflow_state"] == "importing"
  puts "importing"
  sleep(3)

  import_status = Unirest.get(import_status_url,
                              headers: {
                                  "Authorization" => "Bearer #{access_token}"
                              }
  )
  job = import_status.body
end

if job["processing_errors"]
  File.delete(zipfile_name)
  puts "Processing Errors: #{job["processing_errors"]}"
  raise "An error occurred uploading this file. \n #{job}"
end

if job["processing_warnings"]
  puts "Processing Warnings: #{job["processing_warnings"]}"
end

puts "Successfully uploaded files"
timestamp = Time.now.to_s.gsub(/\s/, '-').gsub(/:/, '-')
FileUtils.mv(zipfile_name, "#{archive_folder}/archive-#{timestamp}.zip")
FileUtils.rm Dir.glob("#{source_folder}/*")
