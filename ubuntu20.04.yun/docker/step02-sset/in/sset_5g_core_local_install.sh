#!/bin/bash

if [ $# -ne 3 ]
then
    echo "get docker-ip error, argv[]: $@, $#!"
	exit 1
fi

DOCKER_GET_IP=$1
DOCKER_GET_UPF_SUB4_IP=$2
DOCKER_GET_UPF_SUB6_IP=$3

cp /home/cn/sset_cnf/5gcn/*.yaml /usr/local/install/SSET/cnf/5G/core

#plmn
sed -i 's|MNC|'$MNC'|g' /usr/local/install/SSET/cnf/5G/core/amf.yaml
sed -i 's|MCC|'$MCC'|g' /usr/local/install/SSET/cnf/5G/core/amf.yaml

#localip
sed -i 's|DOCKER_CNF_IP|'$DOCKER_GET_IP'|g' /usr/local/install/SSET/cnf/5G/core/amf.yaml
sed -i 's|DOCKER_CNF_IP|'$DOCKER_GET_IP'|g' /usr/local/install/SSET/cnf/5G/core/upf.yaml

#mongo
sed -i 's|MONGO_PATH|'$MONGO_PATH'|g' /usr/local/install/SSET/cnf/5G/core/udr.yaml
sed -i 's|MONGO_PATH|'$MONGO_PATH'|g' /usr/local/install/SSET/cnf/5G/core/pcf.yaml
sed -i 's|MONGO_PATH|'$MONGO_PATH'|g' /usr/local/install/SSET/cnf/5G/core/nrf.yaml
sed -i 's|MONGO_PATH|'$MONGO_PATH'|g' /usr/local/install/SSET/cnf/5G/core/bsf.yaml

#upf subnet
sed -i 's|DOCKER_UPF_SUB4_IP|'$DOCKER_GET_UPF_SUB4_IP'|g' /usr/local/install/SSET/cnf/5G/core/upf.yaml
sed -i 's|DOCKER_UPF_SUB6_IP|'$DOCKER_GET_UPF_SUB6_IP'|g' /usr/local/install/SSET/cnf/5G/core/upf.yaml
#smf subnet
sed -i 's|DOCKER_UPF_SUB4_IP|'$DOCKER_GET_UPF_SUB4_IP'|g' /usr/local/install/SSET/cnf/5G/core/smf.yaml
sed -i 's|DOCKER_UPF_SUB6_IP|'$DOCKER_GET_UPF_SUB6_IP'|g' /usr/local/install/SSET/cnf/5G/core/smf.yaml

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
