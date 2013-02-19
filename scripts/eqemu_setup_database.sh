#!/bin/sh

. /home/vagrant/setup_scripts/eqemu_config.sh

echo
echo "Loading ProjectEQ database"
echo

cd $EQEMU_HOME/source

if [ ! -d peqdatabase ]; then
	echo "Downloading Database"
	svn co http://projecteqdb.googlecode.com/svn/trunk/peqdatabase
fi

cd peqdatabase

# Create the eqemu user with initial password

touch db_users.sql
echo "GRANT ALL PRIVILEGES ON *.* TO '$EQEMU_MYSQL_USERNAME'@'%' IDENTIFIED BY '$EQEMU_MYSQL_PASSWORD';" > db_users.sql
echo "flush privileges;" >> db_users.sql

mysql -u root -p$EQEMU_MYSQL_ROOTPW < db_users.sql
rm db_users.sql

# Get ready to load the database
mysql -u root -p$EQEMU_MYSQL_ROOTPW -e "drop database if exists $EQEMU_MYSQL_DATABASE; create database if not exists $EQEMU_MYSQL_DATABASE;"

for a in *.gz; do gunzip -c $a > `echo $a | sed s/.gz//`; done

echo "Importing SQL..."
for file in peqdb_*.sql; do
	echo "Importing $file..."
	mysql -u root -p$EQEMU_MYSQL_ROOTPW -f -D $EQEMU_MYSQL_DATABASE < $file
done

for file in "load_player.sql" "load_views.sql" "load_qs.sql" "load_bots.sql" "load_login.sql"
do
	echo "Importing $file..."
	mysql -u root -p$EQEMU_MYSQL_ROOTPW -f -D $EQEMU_MYSQL_DATABASE < $file
done

cp -f -v eqtime.cfg /home/vagrant/server/

# TODO: Load additional sql files?

mysql -u root -p$EQEMU_MYSQL_ROOTPW -f -D $EQEMU_MYSQL_DATABASE < $EQEMU_HOME/source/EQEmuServer/loginserver/login_util/EQEmuLoginServerDBInstall.sql

#
# Now we load that first account so we can have a GM account (or just muck around)
#
echo "insert into tblLoginServerAccounts (AccountName, AccountPassword ) values('xFN', sha('xPW') );" | \
	sed s/xFN/$EQEMU_ADMIN_USERNAME/ | sed s/xPW/$EQEMU_ADMIN_PASSWORD/ > lsa.sql
mysql -u root -p$EQEMU_MYSQL_ROOTPW -D $EQEMU_MYSQL_DATABASE < lsa.sql
rm lsa.sql

echo "UPDATE tblWorldServerRegistration SET ServerLongName = 'xLN', ServerShortName = 'xSN' WHERE ServerID = 1;" | \
	sed "s/xLN/$EQEMU_SERVER_LONGNAME/" | sed "s/xSN/$EQEMU_SERVER_SHORTNAME/" > wsr.sql
mysql -u root -p$EQEMU_MYSQL_ROOTPW -D $EQEMU_MYSQL_DATABASE < wsr.sql
rm wsr.sql
