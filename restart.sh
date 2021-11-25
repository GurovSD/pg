#! /bin/bash
set -e

(docker stop pg_jobers && docker rm pg_jobers) || true
sudo rm -rf /home/laooglee/gb/pg/data

docker run \
    -d \
    -p 5432:5432 \
    --name pg_jobers \
    -e POSTGRES_PASSWORD=pass \
    -e PGDATA=/var/lib/postgresql/data \
    -v /home/laooglee/gb/pg/data:/var/lib/postgresql/data \
    -v /home/laooglee/gb/pg/workdir:/workdir \
    -w /workdir \
    postgres:14.1
    # -v /home/laooglee/gb/pg/init:/docker-entrypoint-init.d \

# psql -U postgres -p 5432 -h localhost

# \i /workdir/schema.sql
# \i data.sql