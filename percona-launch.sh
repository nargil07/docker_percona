#!/usr/bin/env bash

set -m
set -e

/etc/init.d/mysql start

mysql -v -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'azerty'"
mysql -v -u root -e "CREATE DATABASE IF NOT EXISTS wordpress"
mysql -v -u root -e "GRANT ALL ON wordpress.* to '@'%' IDENTIFIED BY 'azerty'"
mysql -v -u root -e "FLUSH PRIVILEGES"

/etc/init.d/mysql stop

mysqld_safe &

fg
