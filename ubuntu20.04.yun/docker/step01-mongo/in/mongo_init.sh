#!/bin/bash

mongod --smallfiles --dbpath /var/lib/mongodb --logpath /var/log/mongodb/mongodb.log --bind_ip 0.0.0.0
