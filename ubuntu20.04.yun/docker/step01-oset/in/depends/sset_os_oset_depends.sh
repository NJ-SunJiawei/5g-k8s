# write by sunjiawei
#!/bin/bash


scriptDir=$(cd $(dirname $0); pwd)
#file location
osetdep="${scriptDir}/oset_depends"
linuxdep="${scriptDir}/linux_depends"

oset_linux_open=0
oset_core1_open=0

function config_install_start() {
	echo "************************************************************"
	echo "*********************OSET平台依赖安装***********************"
	echo "************************************************************"
	if [ $oset_linux_open -eq 1 ];then
		cd ${linuxdep}
		uname -a |grep "Ubuntu" >/dev/null
		if [ $? == 0 ]; then
			tar -zxvf ubuntu20.04.tar.gz
			cd  ubuntu20.04/
			dpkg -i *.deb
			cd .. && rm -rf ubuntu20.04/
		else
			tar -zxvf centos7.4.tar.gz
			cd  centos7.4/
			yum install -y *.rpm --nogpgcheck
			cd .. && rm -rf centos7.4/
		fi
	fi
	cd ${osetdep}
}

function config_install_preln() {
	uname -a |grep "Ubuntu" >/dev/null
	if [ $? == 0 ]; then
		ln -s /usr/include/locale.h /usr/include/xlocale.h
	fi
}

function config_install_end() {
	ldconfig
	echo "************************************************************"
	echo "***********************安装结束*****************************"
}

#更新perl版本
function config_install_perl() {
	PERL_TAR=perl-5.16.3.tar.bz2
	PERL_DIR=perl-5.16.3

	uname -a |grep "Ubuntu" >/dev/null
	if [ $? == 0 ]; then
        return
	fi

	perl -v |grep  "version 16" >/dev/null
	if [ $? == 0 ]; then
		echo "**perl v5.16.3 already install!!!**"
		return
	fi

	#uninstall ori perl
	mv /usr/bin/perl /usr/bin/perl.old
	#mv /usr/bin/perl5.30-x86_64-linux-gnu /usr/bin/perl5.30-x86_64-linux-gnu.old
	#mv /usr/lib/x86_64-linux-gnu/perl  /usr/lib/x86_64-linux-gnu/perl.old
	#mv /etc/perl /etc/perl.old
	#mv /usr/local/bin/perl  /usr/local/bin/perl.old
	#mv /usr/share/perl /usr/share/perl.old
	#mv /usr/share/man/man1/perl.1.gz /usr/share/man/man1/perl.1.gz.old
	rm -rf /usr/bin/perl /usr/bin/perl5.30-x86_64-linux-gnu /usr/lib/x86_64-linux-gnu/perl /etc/perl /usr/local/bin/perl /usr/share/perl /usr/share/man/man1/perl.1.gz

	#ubuntu install perl5.16.3
	tar -jxvf ${PERL_TAR}
	cd ${PERL_DIR}
	./Configure -des -Dusethreda -Uversiononly -A ccflags=-fPIC
	make && make install

	ln -s /usr/local/perl/bin/perl /usr/bin/perl
	cp /usr/local/perl/bin/perl /usr/local/bin/perl

	cd ../
	rm -rf ${PERL_DIR}
	return
}

#安装autoconf
function config_install_autoconf() {
	AUTOCONF_TAR=autoconf-2.69.tar.gz
	AUTOCONF_DIR=autoconf-2.69

	autoconf --version >/dev/null
	if [ $? == 0 ]; then
		echo "**autoconf already install!!!**"
		#return
	fi

	tar -zxvf ${AUTOCONF_TAR}
	cd ${AUTOCONF_DIR}

	chmod +x configure
	./configure
	make && make install

	cd ../
	rm -rf  ${AUTOCONF_DIR}
}

#安装automake
function config_install_automake() {
	AUTOMAKE_TAR=automake-1.15.tar.gz
	AUTOMAKE_DIR=automake-1.15

	automake --version >/dev/null
	if [ $? == 0 ]; then
		echo "**automake already install!!!**"
		#return
	fi

	tar -zxvf ${AUTOMAKE_TAR}
	cd ${AUTOMAKE_DIR}

	chmod +x configure
	./configure
	make && make install

	cd ../
	rm -rf  ${AUTOMAKE_DIR}
}

#安装libtool
function config_install_libtool() {
	LIBTOOL_TAR=libtool-2.4.2.tar.gz
	LIBTOOL_DIR=libtool-2.4.2

	ldconfig -p | grep libltdl  >/dev/null
	if [ $? == 0 ]; then
		echo "**libtool already install!!!**"
		#return
	fi

	tar -zxvf ${LIBTOOL_TAR}
	cd ${LIBTOOL_DIR}

	chmod +x configure
	./configure
	make && make install

	cd ../
	rm -rf  ${LIBTOOL_DIR}
}

#更新cmake版本
function config_install_cmake() {
	CMAKE_TAR=cmake-3.12.0.tar.gz
	CMAKE_DIR=cmake-3.12.0

    CURRENT_VERSION=`cmake --version | grep version | awk '{print $3}'`
    CMPARETO_VERSION='3'
    #echo -e ${CURRENT_VERSION}

    if [ $CURRENT_VERSION \> $CMPARETO_VERSION ]; then
	    echo "当前版本大于${CMPARETO_VERSION}，可用"
	    return
    else
	    echo "当前版本为${CURRENT_VERSION} 需要安装"
    fi

	echo "**OS is Centos**"

	tar -zxvf ${CMAKE_TAR}
	cd ${CMAKE_DIR}
	
	./configure
	make && make install

	cd ../
	rm -rf ${CMAKE_DIR}
	return
}

#安装gperftools
function config_install_gperftools() {
	GPERFTOOLS_TAR=gperftools.tar.gz
	GPERFTOOLS_DIR=gperftools

	ldconfig -p | grep libtcmalloc >/dev/null
	if [ $? == 0 ]; then	
		echo "**gperftools already install!!!**"
		return
	fi

	tar -zxvf ${GPERFTOOLS_TAR}
	cd ${GPERFTOOLS_DIR}

	mkdir build
	cd build && cmake ..
	make && make install

	cd ../../
	rm -rf  ${GPERFTOOLS_DIR}
}

#安装sctp
function config_install_sctp() {
	SCTP_TAR=lksctp-tools-1.0.17.tar.gz
	SCTP_DIR=lksctp-tools-1.0.17

	uname -a |grep "Ubuntu" >/dev/null
	if [ $? == 0 ]; then
		return
	fi

	ldconfig -p | grep libsctp >/dev/null
	if [ $? == 0 ]; then	
		echo "**libsctp already install!!!**"
		return
	fi

	tar -zxvf ${SCTP_TAR}
	cd ${SCTP_DIR}

	chmod +x configure
	./configure
	make && make install

	cd ../
	rm -rf  ${SCTP_DIR}
}

#安装cstl
function config_install_cstl() {
	CSTL_TAR=libcstl-2.3.0.tar.gz
	CSTL_DIR=libcstl-2.3.0

	ldconfig -p | grep libcstl >/dev/null
	if [ $? == 0 ] ; then
		echo "**libcstl already install!!!**"
		return
	fi

	tar -zxvf ${CSTL_TAR}
	cd ${CSTL_DIR}

	chmod +x configure
	./configure
	make && make install

	cd ../
	rm -rf  ${CSTL_DIR}
}

#安装net-snmp
function config_install_net_snmp() {
	#vars
	NET_SNMP_TAR=net-snmp-5.7.2.tar.gz
	NET_SNMP_DIR=net-snmp-5.7.2
	NET_SNMPD_COFIG=snmpd.conf
	NET_SNMP_CONFIG_DIR=/usr/local/share/snmp

	#check snmpd installed already or not
	command -v snmpget >/dev/null
	if [ $? == 0 ]; then
		echo "**net-snmp already install!!!**"
		return
	fi

	tar -zxvf ${NET_SNMP_TAR}
	cd ${NET_SNMP_DIR}

	# install
	chmod +x configure
	./configure --with-snmp=/usr/local/net-snmp --with-openssl=internal -with-default-snmp-version="3" --with-sys-contact="oset" --with-sys-location="oset" --with-logfile=/var/log/snmpd.log --with-persistent-directory=/var/net-snmp

	make && make install

	cd ../
	rm -rf ${NET_SNMP_DIR}

	# configure
	echo "Copy configuration ${NET_SNMPD_COFIG} to ${NET_SNMP_CONFIG_DIR}"
	cp ${NET_SNMPD_COFIG} ${NET_SNMP_CONFIG_DIR}
	#echo "/usr/local/lib" >> /etc/ld.so.conf
	#echo "/usr/local/lib64" >> /etc/ld.so.conf

	ldconfig
	pkill -9 snmpd
	snmpd
}

function config_install_json_c(){

    TAR_FILE=json-c-master.tar.gz
    UNTAR_DIR=json-c-master

    ldconfig -p | grep libjson-c >/dev/null
    if [ $? == 0 ]; then
		echo "**json_c already install!!!**"
		return
    fi

	tar -zxvf ${TAR_FILE}
	cd ${UNTAR_DIR}

	mkdir build
	cd build && cmake ..
	make && make install

    PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

    #echo -e "\033[1;31m Install Json-c result: "
    pkg-config --libs --cflags json-c
    #echo -e "\033[m"

    cd ../../
    rm -rf ${UNTAR_DIR}
}

function config_install_libubox() {

    TAR_FILE=libubox-master.tar.gz
    UNTAR_DIR=libubox-master

    ldconfig -p | grep libubox >/dev/null
    if [ $? == 0 ]; then
		echo "**libubox already install!!!**"
		return
    fi

    tar -zxvf  ${TAR_FILE}
    cd ${UNTAR_DIR}

	mkdir build
	cd build && cmake .. -DBUILD_LUA=OFF
    make && make install

    mkdir -p /usr/share/libubox/
    #ln -sf /usr/local/lib/libubox.so /usr/lib/libubox.so
    #ln -sf /usr/local/share/libubox/jshn.sh /usr/share/libubox/jshn.sh

    cd ../../
    rm -rf ${UNTAR_DIR}
}


#安装ubus
function config_install_ubus() {
    TAR_FILE=ubus-master.tar.gz
    UNTAR_DIR=ubus-master

    ldconfig -p | grep libubus >/dev/null
    if [ $? == 0 ]; then
		echo "**ubus already install!!!**"
		return
    fi

    tar -zxvf ${TAR_FILE}
    cd ${UNTAR_DIR}

	mkdir build
	cd build && cmake .. -DBUILD_LUA=OFF
	make && make install

    #ln -sf /usr/local/sbin/ubus /usr/sbin/ubus
    #ln -sf /usr/local/lib/libubus.so /usr/lib/libubus.so

    cd ../../
    rm -rf ${UNTAR_DIR}
}

function config_install_rocketmq() {

    MQ_FILE=rocketmq-client-cpp-1.2.1.tar.gz
    MQ_DIR=rocketmq-client-cpp-1.2.1

    ldconfig -p | grep librocketmq >/dev/null
    if [ $? == 0 ]; then
		echo "**rocketMq already install!!!**"
		return
    fi

    tar -zxvf  ${MQ_FILE}
    cd ${MQ_DIR}
	
	chmod +x build.sh
	./build.sh
    rm -rf ${MQ_DIR}
}

function config_install_nacos() {
	NACOS_TAR=nacos-sdk-cpp.tar.gz
	NACOS_DIR=nacos-sdk-cpp

	ldconfig -p | grep libnacos-cli >/dev/null
	if [ $? == 0 ]; then	
		echo "**nacos already install!!!**"
		return
	fi

	tar -zxvf ${NACOS_TAR}
	cd ${NACOS_DIR}

	mkdir build
	cd build && cmake ..
	make && make install

	cd ../../
	rm -rf  ${NACOS_DIR}
}

function config_install_yaml() {
	YAML_TAR=libyaml-0.2.5.tar.gz
	YAML_DIR=libyaml-master

	uname -a |grep "Ubuntu" >/dev/null
	if [ $? == 0 ]; then
		return
	fi

	ldconfig -p | grep libyaml >/dev/null
	if [ $? == 0 ]; then	
		echo "**yaml already install!!!**"
		#return
	fi

	tar -zxvf ${YAML_TAR}
	cd ${YAML_DIR}
	
	./bootstrap
	./configure
	make &&  make install
	rm -rf  ${YAML_DIR}
}

function config_install_check() {
	echo "**[0]-success, [1]-error**"

	perl -v |grep "version 16" >/dev/null
	echo "**perf install [$?]"
	sleep 1
	automake --version >/dev/null
	echo "**automake install [$?]"
	sleep 1
	autoconf --version >/dev/null
	echo "**autoconf install [$?]"
	sleep 1
	ldconfig -p | grep libltdl >/dev/null	
	echo "**libtool install [$?]"
	sleep 1
	cmake --version |grep "version 3." >/dev/null
	echo "**cmake install [$?]"
	sleep 1
if [ $oset_core1_open -eq 1 ];then
	ldconfig -p | grep libtcmalloc >/dev/null	
	echo "**gperftools install [$?]"
	sleep 1
	ldconfig -p | grep libsctp >/dev/null	
	echo "**lksctp-tools install [$?]"
	sleep 1
	ldconfig -p | grep libcstl >/dev/null	
	echo "**libtcstl install [$?]"
	sleep 1
	#check snmpd installed already or not
	ldconfig -p | grep  libnetsnmp >/dev/null
	echo "**net-snmp install [$?]"
	sleep 1
	#ldconfig -p | grep  libjson-c >/dev/null
	#echo "**json-c install [$?]"
	#sleep 1
    #ldconfig -p | grep libubox >/dev/null
	#echo "**libubox install [$?]"
	#sleep 1
    #ldconfig -p | grep libubus >/dev/null
	#echo "**ubus install [$?]"
	#sleep 1
fi
	ldconfig -p | grep librocketmq >/dev/null
	echo "**rocketmq install [$?]"
    sleep 1
	ldconfig -p | grep libnacos-cli >/dev/null
	echo "**nacos install [$?]"
    sleep 1
	ldconfig -p | grep libyaml >/dev/null
	echo "**yaml install [$?]"
}



config_install_start
sleep 1

#config_install_perl
#echo "*********************perl finish***********************"
#sleep 2

#config_install_autoconf
#echo "*********************autoconf finish*******************"
#sleep 2

#config_install_automake
#echo "*********************automake finish*******************"
#sleep 2

#config_install_libtool
#echo "*********************libtool finish*******************"
#sleep 2

#config_install_cmake
#echo "*********************cmake finish*******************"
#sleep 2

if [ $oset_core1_open -eq 1 ];then
#config_install_gperftools
#echo "*********************gperftools finish*****************"
#sleep 2

#config_install_sctp
#echo "*********************sctp finish***********************"
#sleep 2

config_install_cstl
echo "*********************cstl finish***********************"
sleep 2

config_install_net_snmp
echo "*********************net_snmp finish*******************"
sleep 2

#config_install_json_c
#echo "*********************json-c finish*******************"
#sleep 2

#config_install_libubox
#echo "*********************libubox finish*******************"
#sleep 2

#config_install_ubus
#echo "*********************ubus finish*******************"
#sleep 2
fi

config_install_rocketmq
echo "*********************rocketmq finish*******************"
sleep 2

config_install_nacos
echo "*********************nacos finish*******************"
sleep 2

#config_install_yaml
#echo "*********************yaml finish*******************"
#sleep 2

config_install_check
config_install_end


