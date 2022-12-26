#!/bin/sh

SYSTEM=`uname`;

if [ $# -ne 2 ]
then
    echo "get subnet-ip error, argv[]: $@, $#!"
	exit 1
fi

DOCKER_GET_UPF_SUB4_IP=$1
DOCKER_GET_UPF_SUB6_IP=$2

if [ "$SYSTEM" = "Linux" ]; then
    if ! grep "ogstun" /proc/net/dev > /dev/null; then
        ip tuntap add name ogstun mode tun
    fi
	#if test "x`sysctl -n net.ipv6.conf.ogstun.disable_ipv6`" = x1; then
	#	echo "net.ipv6.conf.ogstun.disable_ipv6=0" > /etc/sysctl.d/30-sset.conf
	#	sysctl -p /etc/sysctl.d/30-sset.conf
	#fi
    ip addr del $DOCKER_GET_UPF_SUB4_IP dev ogstun 2> /dev/null
    ip addr add $DOCKER_GET_UPF_SUB4_IP dev ogstun
    ip addr del $DOCKER_GET_UPF_SUB6_IP dev ogstun 2> /dev/null
    ip addr add $DOCKER_GET_UPF_SUB6_IP dev ogstun
    ip link set ogstun up

### Enable IPv4/IPv6 Forwarding
    sysctl -w net.ipv4.ip_forward=1
    sysctl -w net.ipv6.conf.all.forwarding=1

### Add NAT Rule
    iptables -t nat -A POSTROUTING -s $DOCKER_GET_UPF_SUB4_IP ! -o ogstun -j MASQUERADE
    ip6tables -t nat -A POSTROUTING -s $DOCKER_GET_UPF_SUB6_IP ! -o ogstun -j MASQUERADE
###host docker support
    #iptables -A FORWARD -o ogstun -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
    #iptables -A FORWARD -o ogstun -j DOCKER
    #iptables -A FORWARD -i ogstun ! -o ogstun -j ACCEPT
    #iptables -A FORWARD -i ogstun -o ogstun -j ACCEPT

else
    sysctl -w net.inet.ip.forwarding=1
    sysctl -w net.inet6.ip6.forwarding=1
    ifconfig lo0 alias 127.0.0.2 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.3 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.4 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.5 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.6 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.7 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.8 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.9 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.10 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.11 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.12 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.13 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.14 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.15 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.16 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.17 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.18 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.19 netmask 255.255.255.255
    ifconfig lo0 alias 127.0.0.20 netmask 255.255.255.255
    if [ "$SYSTEM" = "Darwin" ]; then
        if ! test -f /etc/pf.anchors/org.sset; then
            sudo sh -c "echo 'nat on {en0} from 10.45.0.0/16 to any -> {en0}' > /etc/pf.anchors/org.sset"
            sudo sh -c "echo 'nat on {en0} from 2001:230:cafe::1/48 to any -> {en0}' > /etc/pf.anchors/org.sset"
        fi
        pfctl -e -f /etc/pf.anchors/org.sset
    fi
fi

exit 0
