##############################
####Sun jiawei   2021/8/10####
##############################
#!/bin/bash

DIR=`pwd`
rootPtah="/usr/local/install/SSET"
cnBinPath="${rootPtah}/bin/5G/core"
cnCnfPath="${rootPtah}/cnf/5G/core"
cnLogPath="${rootPtah}/var/log/core"

#global
N_OPTION=0
E_OPTION=0
NACOS_SERVER_IP=
LOG_PRINTF_LEVEL=
TMPVALUE=

function getArgv()
{
    echo "getArgv argv[]: $@, $#"
	#./sset_tools.sh 5gc -n 10.37.5.69 -e debug
	if [ $# -eq 1 ]
    then
        return 1
    elif [ $# -eq 3 ]
    then
		 case $2 in
		 "-n")
			 N_OPTION=1
			 NACOS_SERVER_IP=$3
			 return 2
			 ;;
		 "-e")
			 E_OPTION=1
			 LOG_PRINTF_LEVEL=$3
			 return 2
			 ;; 
		 *)
			 echo "error input!!!"
			 return 0
			 ;;
		 esac
    elif [ $# -eq 5 ]
    then
		case $2 in
		"-n")
		    NACOS_SERVER_IP=$3
		    LOG_PRINTF_LEVEL=$5
            return 3
		 ;;
		"-e")
		    NACOS_SERVER_IP=$5
		    LOG_PRINTF_LEVEL=$3
            return 3
		 ;; 
		*)
		    echo "error input!!!"
            return 0
		 ;;
		esac
    fi
	return 0
}

function usage()
{
    echo "Usage:"
    echo "\"$0 kill\"                                     to kill all process "
    echo "\"$0 5gc       -n [nacos ip] -e [level]\"       to start process one by one"
    echo "\"$0 restart   -n [nacos ip] -e [level]\"       to restart all process"
    echo "\"$0 5gcTest   -n [nacos ip] -e [level]\"       to start 5gc debug"
    echo "\"$0 5gcDocker -n [nacos ip] -e [level]\"       to start 5gc docker"
    echo "\"$0 5gcK8s    -n [nacos ip] -e [level]\"       to start 5gc K8s"
}

function killAll()
{

	pkill -9 sset-*
	#pkill -9 nr-*
    echo "kill all process success!!!"
}

function start5gc()
{
	#echo "start5gc argv[]: $@ ,${TMPVALUE}, ${NACOS_SERVER_IP}"
    cd ${cnBinPath}
	if [ ${TMPVALUE} -eq 1 ]
	then
        nohup ./sset-nrfd -c ${cnCnfPath}/nrf.yaml > /dev/null 2>&1 &
        nohup ./sset-upfd -c ${cnCnfPath}/upf.yaml > /dev/null 2>&1 &
        nohup ./sset-smfd -c ${cnCnfPath}/smf.yaml > /dev/null 2>&1 &
        nohup ./sset-amfd -c ${cnCnfPath}/amf.yaml > /dev/null 2>&1 &
        nohup ./sset-ausfd -c ${cnCnfPath}/ausf.yaml > /dev/null 2>&1 &
        nohup ./sset-udmd -c ${cnCnfPath}/udm.yaml > /dev/null 2>&1 &
        nohup ./sset-pcfd -c ${cnCnfPath}/pcf.yaml > /dev/null 2>&1 &
        nohup ./sset-bsfd -c ${cnCnfPath}/bsf.yaml > /dev/null 2>&1 &
        nohup ./sset-nssfd -c ${cnCnfPath}/nssf.yaml > /dev/null 2>&1  &
        nohup ./sset-udrd -c ${cnCnfPath}/udr.yaml > /dev/null 2>&1 &
		echo "start5gc process success!!!"
    elif [ ${TMPVALUE} -eq  2 ]
	then
        if [ ${N_OPTION} -eq 1 ]
        then        
        nohup ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-upfd -c ${cnCnfPath}/upf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-smfd -c ${cnCnfPath}/smf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-amfd -c ${cnCnfPath}/amf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-udmd -c ${cnCnfPath}/udm.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        nohup ./sset-udrd -c ${cnCnfPath}/udr.yaml -n ${NACOS_SERVER_IP} > /dev/null 2>&1 &
        fi
        if [ ${E_OPTION} -eq 1 ]
        then        
        nohup ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-upfd -c ${cnCnfPath}/upf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-smfd -c ${cnCnfPath}/smf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-amfd -c ${cnCnfPath}/amf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-udmd -c ${cnCnfPath}/udm.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-udrd -c ${cnCnfPath}/udr.yaml -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        fi
		echo "start5gc process success!!!"
    elif [ ${TMPVALUE} -eq 3 ]
    then
        nohup ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-upfd -c ${cnCnfPath}/upf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-smfd -c ${cnCnfPath}/smf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-amfd -c ${cnCnfPath}/amf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-udmd -c ${cnCnfPath}/udm.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
        nohup ./sset-udrd -c ${cnCnfPath}/udr.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} > /dev/null 2>&1 &
		echo "start5gc process success!!!"
    else
	    echo "start5gc input argv error!!!"
    fi
}

function ssetCheck()
{
    while [ 1 ];do
    sleep 15
    pid_num=$(ps -ef|grep "sset-" |grep -v "grep"|wc -l)
	if [ ${pid_num} -ne 10 ]
	then
	    echo "sset-cn process(${pid_num}) dead!!!"
	    return
    fi
	done
}

function start5gcDocker()
{
	#echo "start5gcDocker argv[]: $@ ,${TMPVALUE}, ${NACOS_SERVER_IP}"
    cd ${cnBinPath}
	if [ ${TMPVALUE} -eq 1 ]
	then
         ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -D
         ./sset-upfd -c ${cnCnfPath}/upf.yaml -D
         ./sset-smfd -c ${cnCnfPath}/smf.yaml -D
         ./sset-amfd -c ${cnCnfPath}/amf.yaml -D
         ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -D
         ./sset-udmd -c ${cnCnfPath}/udm.yaml -D
         ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -D
         ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -D
         ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -D
         ./sset-udrd -c ${cnCnfPath}/udr.yaml -D
		 echo "start5gcDocker process success!!!"
    elif [ ${TMPVALUE} -eq  2 ]
	then
        if [ ${N_OPTION} -eq 1 ]
        then        
         ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-upfd -c ${cnCnfPath}/upf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-smfd -c ${cnCnfPath}/smf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-amfd -c ${cnCnfPath}/amf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-udmd -c ${cnCnfPath}/udm.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-udrd -c ${cnCnfPath}/udr.yaml -n ${NACOS_SERVER_IP} -D
        fi
        if [ ${E_OPTION} -eq 1 ]
        then        
         ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-upfd -c ${cnCnfPath}/upf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-smfd -c ${cnCnfPath}/smf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-amfd -c ${cnCnfPath}/amf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udmd -c ${cnCnfPath}/udm.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udrd -c ${cnCnfPath}/udr.yaml -e ${LOG_PRINTF_LEVEL} -D
        fi
		echo "start5gcDocker process success!!!"
    elif [ ${TMPVALUE} -eq 3 ]
    then
         ./sset-nrfd -c ${cnCnfPath}/nrf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-upfd -c ${cnCnfPath}/upf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-smfd -c ${cnCnfPath}/smf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-amfd -c ${cnCnfPath}/amf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-ausfd -c ${cnCnfPath}/ausf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udmd -c ${cnCnfPath}/udm.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-pcfd -c ${cnCnfPath}/pcf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-bsfd -c ${cnCnfPath}/bsf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-nssfd -c ${cnCnfPath}/nssf.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udrd -c ${cnCnfPath}/udr.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
		echo "start5gcDocker process success!!!"
    else
	    echo "start5gcDocker input argv error!!!"
    fi
}

function start5gcK8s()
{
	#echo "start5gcK8s argv[]: $@ ,${TMPVALUE}, ${NACOS_SERVER_IP}"
    cd ${cnBinPath}
	if [ ${TMPVALUE} -eq 1 ]
	then
         ./sset-nrfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-upfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-smfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-amfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-ausfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-udmd -c ${cnCnfPath}/sample.yaml -D
         ./sset-pcfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-bsfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-nssfd -c ${cnCnfPath}/sample.yaml -D
         ./sset-udrd -c ${cnCnfPath}/sample.yaml -D
		 echo "start5gcK8s process success!!!"
    elif [ ${TMPVALUE} -eq  2 ]
	then
        if [ ${N_OPTION} -eq 1 ]
        then        
         ./sset-nrfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-upfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-smfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-amfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-ausfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-udmd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-pcfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-bsfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-nssfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
         ./sset-udrd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -D
        fi
        if [ ${E_OPTION} -eq 1 ]
        then        
         ./sset-nrfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-upfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-smfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-amfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-ausfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udmd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-pcfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-bsfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-nssfd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udrd -c ${cnCnfPath}/sample.yaml -e ${LOG_PRINTF_LEVEL} -D
        fi
		echo "start5gcK8s process success!!!"
    elif [ ${TMPVALUE} -eq 3 ]
    then
         ./sset-nrfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-upfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-smfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-amfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-ausfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udmd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-pcfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-bsfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-nssfd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
         ./sset-udrd -c ${cnCnfPath}/sample.yaml -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL} -D
		echo "start5gcK8s process success!!!"
    else
	    echo "start5gcK8s input argv error!!!"
    fi
}


function restart()
{
	echo "restart process begin!!!"
	pkill -9 sset-*
	cd ${cnLogPath} && rm -rf *.log
	sleep 5
    cd ${cnBinPath}
    start5gc TMPVALUE
	#echo "restart process success!!!"
}

function start5gcTest()
{
	if [ ${TMPVALUE} -eq 1 ]
	then
	    cd ${DIR} && cd ..
	    cd $(pwd)/build/protocl/5G/core/tests/app && ./5gc
		echo "start5gcTest process close success!!!"
    elif [ ${TMPVALUE} -eq 2 ]
	then
	    cd ${DIR} && cd ..
        if [ ${N_OPTION} -eq 1 ]
        then      
	    cd $(pwd)/build/protocl/5G/core/tests/app && ./5gc -n ${NACOS_SERVER_IP}
		fi
        if [ ${E_OPTION} -eq 1 ]
        then      
	    cd $(pwd)/build/protocl/5G/core/tests/app && ./5gc -e ${LOG_PRINTF_LEVEL}
		fi
		echo "start5gcTest process close success!!!"
    elif [ ${TMPVALUE} -eq 3 ]
    then
	    cd ${DIR} && cd ..
	    cd $(pwd)/build/protocl/5G/core/tests/app && ./5gc -n ${NACOS_SERVER_IP} -e ${LOG_PRINTF_LEVEL}
		echo "start5gcTest process close success!!!"
    else
	      echo "start5gcTest input argv error!!!"
    fi
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
	elif [ $1 = "restart" ]
	then 	
        restart TMPVALUE
	elif [ $1 = "5gcTest" ]
	then
        start5gcTest TMPVALUE
	elif [ $1 = "5gc" ]
	then
        start5gc TMPVALUE
	elif [ $1 = "5gcDocker" ]
	then
        start5gcDocker TMPVALUE
        ssetCheck
	elif [ $1 = "5gcK8s" ]
	then
        start5gcK8s TMPVALUE
        ssetCheck
	fi
fi


