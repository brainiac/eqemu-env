
echo
echo "Loading ProjectEQ database"
echo

cd /home/vagrant/source/peqdatabase

# Create the eqemu user with initial password eqemupw

touch db_users.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'eqemu'@'%' IDENTIFIED BY 'eqemupw';" > db_users.sql
echo "flush privileges;" >> db_users.sql

mysql -u root -ppassword < db_users.sql
rm -f db_users.sql

# Get ready to load the database
mysql -u root -ppassword -e "drop database if exists peqdb; create database if not exists peqdb;"
gunzip peqdb_rev*.sql.gz

echo "Importing SQL..."
mysql -u root -ppassword -f -D peqdb < /home/vagrant/source/peqdatabase/peqdb_*.sql
mysql -u root -ppassword -f -D peqdb < /home/vagrant/source/peqdatabase/load_player.sql
mysql -u root -ppassword -f -D peqdb < /home/vagrant/source/peqdatabase/load_login.sql
mysql -u root -ppassword -f -D peqdb < /home/vagrant/source/peqdatabase/load_bots.sql

# TODO: Load login server info
#mysql -u root -ppassword -f -D peqdb < /home/vagrant/source/EQEmuServer/EQEmuLoginServer/login_util/EQEmuLoginServerDBInstall.sql

