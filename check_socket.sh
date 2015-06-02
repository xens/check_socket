#!/bin/bash
###########
# 2015.02.25 romain.aviolat@nagra.com - initial file creation
# check if a socket exists for a given address/port


tcp_opt=""
udp_opt=""
nb_sockets=0

help="Usage: $0 -a <listen address> -p <port> -t (tcp) -u (udp)"

while getopts 'a:p:tu' opt; do
  case $opt in
    a)
      address="${OPTARG}"
      ;;
    p)
      port="${OPTARG}"
      ;;
    t)
      tcp_netstat_opt="t"
      tcp_text="TCP"
      ;;
    u)
      udp_netstat_opt="u"
      udp_text="UDP"
      ;;
    \?|:)
      echo ${help}
      exit 3
      ;;
  esac
done

# standard Icinga plugin return codes.
STATUS_OK=0
STATUS_WARNING=1
STATUS_CRITICAL=2
STATUS_UNKNOWN=3

# control the options passed to the script
if [ -n "$tcp_netstat_opt" ] ; then
  let "nb_sockets = $nb_sockets + 1"
fi

if [ -n "$udp_netstat_opt" ] ; then
  let "nb_sockets = $nb_sockets + 1"
fi

if [ -z ${address} ] || [ -z ${port} ] || [ $nb_sockets == 0 ]  ; then
  echo ${help}
  exit 3
fi

output=$(netstat -"$tcp_netstat_opt""$udp_netstat_opt"ln4 | grep "$address:$port" | wc -l)

# formated output
if [ "$nb_sockets" == "$output" ] ; then
  echo "OK - listening on "$address":"$port" "$tcp_text" "$udp_text""

else
  echo "WARNING - not listening on "$address":"$port" "$tcp_text" "$udp_text""

fi

