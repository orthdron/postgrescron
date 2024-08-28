ARG POSTGRES_DIGEST=16
FROM postgres:${POSTGRES_DIGEST}

LABEL maintainer="Postgres v.16 images based on postgres:16-bullseye with pg_cron and pgvector extensions."

# Install pg_cron
RUN apt-get update && apt-get install -y postgresql-16-cron && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Add pg_cron to shared_preload_libraries
RUN echo "shared_preload_libraries = 'pg_cron'" >> /usr/share/postgresql/postgresql.conf.sample

# Set up entrypoint to create extension
COPY ./init-pg-cron.sh /docker-entrypoint-initdb.d/
