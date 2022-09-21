#!/bin/bash
IPT="/sbin/iptables"

IN_FACE="ens3"                   # NIC connected to the internet
WG_FACE="wg0"                    # WG NIC 
SUB_NET="10.8.0.0/24"            # WG IPv4 subnet
WG_PORT="42069"                  # WG udp port
## IPv4 ##
$IPT -t nat -A POSTROUTING -s $SUB_NET -o $IN_FACE -j MASQUERADE
$IPT -A INPUT -i $WG_FACE -m state --state ESTABLISHED,RELATED -j ACCEPT
$IPT -A INPUT -i $WG_FACE -j DROP
$IPT -A FORWARD -i $IN_FACE -o $WG_FACE -j ACCEPT
$IPT -A FORWARD -i $WG_FACE -o $IN_FACE -j ACCEPT
$IPT -A INPUT -i $IN_FACE -p udp --dport $WG_PORT -j ACCEPT
