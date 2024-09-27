FROM postgres:17-bullseye

# Update package list and install necessary packages
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get install -y postgresql-16-cron \
    && apt-get install -y postgresql-server-dev-16 \
    && apt-get install -y build-essential libcurl4-openssl-dev \
    && apt-get install -y git

# Clone and install pgsql_http extension
RUN git clone https://github.com/pramsey/pgsql-http.git /tmp/pgsql-http \
    && cd /tmp/pgsql-http \
    && make \
    && make install \
    && rm -rf /tmp/pgsql-http

# Configure PostgreSQL to load extensions
RUN echo "shared_preload_libraries='pg_cron'" >> /usr/share/postgresql/postgresql.conf.sample \
    && echo "cron.database_name='postgres'" >> /usr/share/postgresql/postgresql.conf.sample

# Expose PostgreSQL port
EXPOSE 5432
