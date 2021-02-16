# import-meadata

Import FINOS metadata JSON file.

# Running locally

- Run the import locally (as cron executes it): `` IMPORT_DIR="`realpath .`" ./finos_metadata_local.sh local ``.


# Prod deployment

- Deploy cron job that will run `finos_metadata_prod.sh`: `crontab -e`, add entry from `cron/finos_metadata_prod.crontab`.
- Copy `finos_metadata_prod.sh` to `/usr/bin/`: `cp finos_metadata_prod.sh /usr/bin`.
