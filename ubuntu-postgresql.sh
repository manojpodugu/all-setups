#!/bin/bash

set -e

sudo apt update -y
sudo apt upgrade -y

sudo apt install postgresql postgresql-contrib -y

sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo systemctl status postgresql
psql --version


# su - postgres --> switch to postgres user.
# psql - opens postgresql shell to run postgrssql commands.
