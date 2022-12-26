#!/bin/bash

if [ ${MONGO_IP} ]
then
   export DB_URI="mongodb://${MONGO_IP}/open5gs"
fi

cd /home/webui && npm run dev

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
