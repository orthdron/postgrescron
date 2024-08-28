#!/bin/bash
set -e

# Ensure pg_cron extension is created for the database
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS pg_cron;
EOSQL
