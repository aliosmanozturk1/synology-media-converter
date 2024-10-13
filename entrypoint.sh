#!/bin/sh

if [ -z "${CRON_INTERVAL+x}" ]; then
    CRON_INTERVAL="0 1 * * *"
fi
echo "$CRON_INTERVAL /usr/bin/node /app/main.js" > /etc/crontabs/root
crond -f