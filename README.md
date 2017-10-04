# NM SIS Importer

Consumes CSV files from a directory, zips them, and uploads the resulting zip
to the CanvasLMS system that's listed.

Both directory and upload destination are able to be modified with command line
arguments (source and destination)

The files need to be encoded as UTF-8 to make sure they work!

## Steps we perform

1. Find the CSV files posted to a directory by the SIS. (configurable directory)
2. Import those CSV contents into the Postgresql database and crunch some datas
3. Export to CSV files from postgres. (Postgres creds in a database.yml)
4. Zip the new CSV files (working directory stores temp csv's)
5. Post them and consume the body of the response. (destination configurable)
6. Notify of failure (somehow)?

## Installation requirements

Installation must create a database so ensure the installing user has the CREATEDB permission.
Also, the database that you create should be accessible by the same database user that
canvas itself uses.

`$ createdb apscanvas`
`$ chmod +x sql_scripts/export_canvas_data.sh`
`$ chmod +x sql_scripts/import_clever_data.sh`

Once that's all setup, make sure you setup your `.env` file with the right stuff.
You'll need an API access token for your canvas installation.  One difference is that
we're not running on the same database that the main canvas installation is running on
be sure to update that setting too.  (and create the correct database since that's not automatic)
