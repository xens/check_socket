# intro

This bash script check if a socket exists for a given address/port using netstat
made for Icinga / Nagios. It does not require root privileges.

# usage

Usage: ./check_socket.sh -a <listen address> -p <port> -t (tcp) -u (udp)

# caveats

* only ipv4 is supported yet
* has very limited set of features

