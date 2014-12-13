#!/bin/bash

set -u
set -e

DB_NAME="ghost"
GHOST="/ghost"
OVERRIDE="/ghost-content"
IMAGES="content/images"
THEMES="content/themes"

chown -R postgres:postgres /data

# start db if /data exists, otherwise initialize a new db
if [ "$(ls -A /data)" ]; then
	echo "/data exists. starting postgres"
	su - postgres -c "/usr/lib/postgresql/9.3/bin/pg_ctl -w -D /data start"
else
	echo "starting postgres and creating ghost db"
	su - postgres -c "/usr/lib/postgresql/9.3/bin/initdb -D /data"	
	su - postgres -c "/usr/lib/postgresql/9.3/bin/pg_ctl -w -D /data start"
	su - postgres -c "/usr/lib/postgresql/9.3/bin/createdb ${DB_NAME}"
fi

echo "configuring ghost"
mkdir -p "$OVERRIDE/$IMAGES"
mkdir -p "$OVERRIDE/$THEMES"

echo "adding caspar theme unless it exists"
if [ ! -d "$OVERRIDE/$THEMES/casper" ]; then
	cp -r /casper "$OVERRIDE/$THEMES"
fi

cd /ghost

echo "adding envvars to config.js"
sed  -i 's/%GMAIL%/'${GMAIL}'/;
		s/%GMAIL_PASSWORD%/'${GMAIL_PASSWORD}'/;
		s/%HOSTNAME%/'${HOSTNAME}'/' /ghost/config.js	

echo "adding symlinks for images and themes dirs"
rm -fr "$GHOST/$IMAGES"
ln -s "$OVERRIDE/$IMAGES" "$IMAGES"
for theme in $(find "$OVERRIDE/$THEMES" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
do
rm -fr "$THEMES/$theme"
ln -s "$OVERRIDE/$THEMES/$theme" "$THEMES/$theme"
done

echo "setting permissions"
chown -R ghost:ghost "$OVERRIDE"
chown -R ghost:ghost /ghost

echo "Starting Ghost"
su ghost << EOF
NODE_ENV=${NODE_ENV:-production} npm start
EOF