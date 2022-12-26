#!/bin/bash

if [ $# -ne 2 ]
then
    echo "get docker-ip error, argv[]: $@, $#!"
	exit 1
fi

DOCKER_GET_UE_IMSI=$1
DOCKER_GET_GNB_IP=$2

cp /home/ueran/sset_cnf/5gueran/*.yaml /usr/local/install/SSET/cnf/5G/ueran

#plmn
sed -i 's|MNC|'$MNC'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml
sed -i 's|MCC|'$MCC'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml


sed -i 's|UE_KI|'$UE_KI'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml
sed -i 's|UE_OP|'$UE_OP'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml
sed -i 's|UE_AMF|'$UE_AMF'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml

sed -i 's|UE_IMSI|'$DOCKER_GET_UE_IMSI'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml
sed -i 's|DOCKER_GNB_IP|'$DOCKER_GET_GNB_IP'|g' /usr/local/install/SSET/cnf/5G/ueran/sset5g-ue.yaml

# Sync docker time
#ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
