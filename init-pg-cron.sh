#!/bin/bash
set -e

# Ensure pg_cron extension is created for the database
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pg_cron;
EOSQL

# Set up a test cron job
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    SELECT cron.schedule('* * * * *', $$SELECT 'Hello from pg_cron' AS message$$);
EOSQL

echo "pg_cron extension and test job have been set up."
