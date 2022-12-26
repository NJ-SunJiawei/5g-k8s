##############################
####Sun jiawei   2021/8/10####
####Pan yang     2021/8/18####
####Sun jiawei   2022/2/15####
##############################
#!/bin/bash

DIR=`pwd`
rootPtah="/usr/local/install/SSET"

nrBinPath="${rootPtah}/bin/5G/ueran"
nrCnfPath="${rootPtah}/cnf/5G/ueran"
nrLogPath="${rootPtah}/var/log/ueran"

#global
NACOS_SERVER_IP=
LOG_PRINTF_LEVEL=
TMPVALUE=
START_OPTION=
UE_OPTION=0
IMSI_OPTION=0
UE_NUMBER=1
#IMSI=`awk -F "['-]" '/supi:/{print $3;exit}' ${nrCnfPath}/open5gs-ue.yaml`
IMSI=

function getArgv()
{
    echo "getArgv argv[]: $@, $#"
	  if [ $# -eq 1 ]
    then
        return 1
    elif [ $# -eq 2 ]
    then
        case $1 in
        "ue")
             START_OPTION=$2
             return 2
             ;;
        "gnb")
             START_OPTION=$2
             return 2
             ;;
        *)
             echo "error input!!!"
             return 2
             ;;
        esac
    elif [ $# -eq 4 ]
    then
        case $1 in
        "ue")
            case $3 in
            "-n")
                START_OPTION=$2
                UE_OPTION=1
                UE_NUMBER=$4
                ;;
            "-i")
                START_OPTION=$2
                IMSI_OPTION=1
                IMSI=$4
                ;;
            *)
                echo "error input!!!"
                ;;
            esac
            ;;
        *)
            echo "error input!!!"
            ;;
        esac
        return 4
    elif [ $# -eq 6 ]
    then
        case $3 in
        "-i")
            UE_OPTION=1
            IMSI_OPTION=1
            START_OPTION=$2
            UE_NUMBER=$4
            IMSI=$6
            ;;
        "-n")
            UE_OPTION=1
            IMSI_OPTION=1
            START_OPTION=$2
            UE_NUMBER=$6
            IMSI=$4
            ;;
         *)
            echo "error input!!!"
            ;;
        esac 
        return 6
  fi
	return 0
}


function usage()
{
    echo "Usage:"
    echo "\"$0 kill                                      \"       to kill all process "
 	echo "\"$0 gnb  -Y/N                                 \"       to start gnb process"
    echo "\"$0 ue   -Y/N  -n [ue numbers] -i [IMSI]      \"       to start ue process"
}

function killAll()
{

	pkill -9 sset-*
    echo "kill all process success!!!"
}

function startue()
{
	#echo "startue argv[]: $@ ,${TMPVALUE}"
	cd ${nrBinPath}
    if [ ${TMPVALUE} -eq 2 ]
	then
        case ${START_OPTION} in
        "-Y")
	    	 sleep 10
             ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml
             ;;
        "-N")
             nohup ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml > ${nrLogPath}/ue.log 2>&1 &
             echo "startue process success!!!"
             ;;
        *)
             echo "error input!!!"
             ;;
        esac
    elif [ ${TMPVALUE} -eq 4 ]
	then
        case ${START_OPTION} in
        "-Y")
	    	sleep 10
            if [ ${IMSI_OPTION} -eq 1 ]
            then
                ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml -i ${IMSI} 
            fi
            if [ ${UE_OPTION} -eq 1 ]
            then
                ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml -n ${UE_NUMBER} 
            fi
            ;;
        "-N")
            if [ ${IMSI_OPTION} -eq 1 ]
            then
                nohup ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml -i ${IMSI} > ${nrLogPath}/ue.log 2>&1 &
                echo "startue process success!!!"
            fi
            if [ ${UE_OPTION} -eq 1 ]
            then
                nohup ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml -n ${UE_NUMBER} > ${nrLogPath}/ue.log 2>&1 &
                echo "startue process success!!!"
            fi
            ;;
        *)
            echo "error input!!!"
            ;;
        esac
    elif [ ${TMPVALUE} -eq 6 ]
	then
        case ${START_OPTION} in
        "-Y")
	    	 sleep 10
             ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml -n ${UE_NUMBER} -i ${IMSI}
             ;;
        "-N")
             nohup ./sset-ue -c ${nrCnfPath}/sset5g-ue.yaml -n ${UE_NUMBER} -i ${IMSI} > ${nrLogPath}/ue.log 2>&1 &
             echo "startue process success!!!"
             ;;
        *)
             echo "error input!!!"
             ;;
        esac
    else
	    echo "startue input argv error!!!"
    fi
}

function startgnb()
{
	#echo "startgnb argv[]: $@ ,${TMPVALUE}"
    cd ${nrBinPath}
    if [ ${TMPVALUE} -eq 2 ]
	then
        case ${START_OPTION} in
        "-Y")
			 sleep 5
             ./sset-gnb -c ${nrCnfPath}/sset5g-gnb.yaml
             ;;
        "-N")
            nohup ./sset-gnb -c ${nrCnfPath}/sset5g-gnb.yaml > ${nrLogPath}/gnb.log 2>&1 &
            echo "startgnb process success!!!"
             ;;
        *)
             echo "error input!!!"
             ;;
        esac
    else
	    echo "startgnb input argv error!!!"
    fi
}

function restart()
{
	echo "restart process begin!!!"
	pkill -9 sset-*
	cd ${nrLogPath} && rm -rf *.log
	sleep 5
    cd ${nrBinPath}
    startgnb
    startue TMPVALUE
	#echo "restart process success!!!"
}


if [ $# = '0' ]
then 
	usage
else
  getArgv $@
  TMPVALUE=$?
  echo "TMPVALUE = ${TMPVALUE}"
	if [ $1 = "kill" ]
	then
	    killAll
	elif [ $1 = "ue" ]
	then
        startue TMPVALUE #START_OPTION UE_OPTION IMSI_OPTION UE_NUMBER IMSI 
	elif [ $1 = "gnb" ]
	then
        startgnb TMPVALUE
	fi
fi

