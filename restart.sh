#! /bin/bash
set -e

(docker stop pg_jobers && docker rm pg_jobers) || true
sudo rm -rf /home/laooglee/gb/pg/data
