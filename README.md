# NM SIS Importer

Takes CSV files exported from APS's SIS system, selects and reformats the
data for Canvas, and uploads the data to a CanvasLMS system.

Both directory and upload destination are able to be modified with command line
arguments (source and destination)

The files need to be encoded as UTF-8 to make sure they work!

## Steps we perform

1. Find the CSV files posted to a directory by the SIS. (configurable directory)
2. Import those CSV contents into the Postgresql database and crunch some datas
3. Export to Canvas formatted CSV files from postgres. (Postgres creds in a database.yml)
4. Zip the new CSV files (working directory stores temp CSV's)
5. Post them and consume the body of the response. (destination configurable)
6. Notify of failure (somehow)?

## Installation requirements

First make sure you setup your `.env` file with the right stuff. You'll need an API
access token for your canvas installation (go to http://canvas.aps.edu/profile/settings
and click the **New Access Token** button). You may need to install the ruby bundler:

`$ sudo apt-get install ruby-bundler`

Now install the dependencies (done locally here):

`$ bundle install --path vendor/bundle`

If you get errors with the JSON gem, then you may also need to install `g++` and `make`.

Now update the shell scripts to be executable:

`$ chmod +x sql_scripts/*.sh`

Once those are set, to run the script:

`$ bundle exec ruby sis_script.rb`

## Other Notes

 * scripts assume the SIS import data will be stored in the same db that Canvas uses
 * the user importing must be a superuser (so you may want a different account than Canvas uses)
 * only users from schools that have subaccounts with SIS IDs in Canvas will be imported


