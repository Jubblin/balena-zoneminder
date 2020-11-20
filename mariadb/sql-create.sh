# create random password
PASSWDDB="$(openssl rand -base64 12)"

# replace "-" with "_" for database username
MAINDB=${USER_NAME//[^a-zA-Z0-9]/_}

mysql -u root -p<<MYSQL_SCRIPT
CREATE DATABASE $MAINDB;

CREATE DATABASE IF NOT EXISTS ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;
CREATE USER IF NOT EXISTS ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';
GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT
