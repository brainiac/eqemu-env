#!/bin/sh

source /home/vagrant/setup_scripts/eqemu_config.sh

echo
echo "Loading ProjectEQ database"
echo

cd $EQEMU_HOME/source/peqdatabase

# Create the eqemu user with initial password

touch db_users.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$EQEMU_MYSQL_USERNAME'@'%' IDENTIFIED BY '$EQEMU_MYSQL_PASSWORD';" > db_users.sql
echo "flush privileges;" >> db_users.sql

mysql -u root -ppassword < db_users.sql
rm -f db_users.sql

# Get ready to load the database
mysql -u root -ppassword -e "drop database if exists $EQEMU_MYSQL_DATABASE; create database if not exists $EQEMU_MYSQL_DATABASE;"
gunzip peqdb_rev*.sql.gz

echo "Importing SQL..."
mysql -u root -ppassword -f -D $EQEMU_MYSQL_DATABASE < $EQEMU_HOME/source/peqdatabase/peqdb_*.sql
mysql -u root -ppassword -f -D $EQEMU_MYSQL_DATABASE < $EQEMU_HOME/source/peqdatabase/load_player.sql
mysql -u root -ppassword -f -D $EQEMU_MYSQL_DATABASE < $EQEMU_HOME/source/peqdatabase/load_login.sql
mysql -u root -ppassword -f -D $EQEMU_MYSQL_DATABASE < $EQEMU_HOME/source/peqdatabase/load_bots.sql

# TODO: Load additional sql files?

# TODO: Load login server info
#mysql -u root -ppassword -f -D peqdb < $EQEMU_HOME/source/EQEmuServer/EQEmuLoginServer/login_util/EQEmuLoginServerDBInstall.sql

