#!/usr/bin/env sh

PUID=${PUID:-1000}
PGID=${PGID:-1000}

groupmod -o -g "$PGID" tesla_dashcam || true
usermod -o -u "$PUID" tesla_dashcam || true

chown -R tesla_dashcam:tesla_dashcam /recordings || true
chown -R tesla_dashcam:tesla_dashcam /usr/src/app/tesla_dashcam || true

exec su -c "$*" -s /bin/sh tesla_dashcam