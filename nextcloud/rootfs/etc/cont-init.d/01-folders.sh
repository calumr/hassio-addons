#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

PUID=$(bashio::config "PUID")
PGID=$(bashio::config "PGID")

echo "Updating permissions..."
echo "... Config directory : /data"
mkdir -p /data/config
chmod 755 -R /data/config
chown -R "$PUID:$PGID" "/data/config"

# Check current version
if [ -f /data/config/www/nextcloud/config/config.php ]; then
    datadirectory="$(sed -n "s|.*datadirectory' => '*\(.*[^ ]\) *',.*|\1|p" /data/config/www/nextcloud/config/config.php)"
echo "... Data directory detected : $datadirectory"

else
    datadirectory=/share/nextcloud
fi



mkdir -p "$datadirectory"
chmod 755 -R "$datadirectory"
chown -R "$PUID:$PGID" "$datadirectory"

echo "...done"
echo " "
