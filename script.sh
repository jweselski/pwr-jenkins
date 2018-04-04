#!/usr/bin/env bash

mysql -u $MYSQL_USER -p$MYSQL_PASSWORD -e 'UPDATE core_config_data SET value = '" $FACT_FINDER_ACTIVATION "'  WHERE path = "factfinder/general/is_enabled"' $MYSQL_DATABASE
