#!/bin/bash

# I made this script mainly for myself and I only published it because I didnt find anything similar on the internet and I wanted to help others. 
# I know that its very badly written but I dont expect that more than a few people will ever use it.
# Author: linuximple@gmail.com
# YT: https://www.youtube.com/channel/UCW4LHmdX_qIE2lBT0_DW3VQ

clear
echo "Enter the number of the external port [Default: 80]"
read extPort

echo "Enter the number of the internal port [Default: 80]"
read intPort

echo "Select the protocol [tcp (Recommended)/udp]"
read proto

echo "Set the private ip of the client [Default: 10.8.0.6]"
read ip

if [[ $ip == "" ]]; then
    ip="10.8.0.6"
fi

if [[ $extPort == "" ]]; then
    extPort="80"
fi

if [[ $intPort == "" ]]; then
    intPort="80"
fi

if [[ $proto == "" ]]; then
    proto="tcp"
fi
clear
echo "This will redirect the traffic from the external port $extPort to the IP $ip:$intPort with the $proto protocol."
echo "Is that correct? [Y/n]"
read confirm

if [[ $confirm == "n" ]]; then
    exit 0
fi

if [[ $confirm == "N" ]]; then
    exit 0
fi


sudo iptables --table filter --insert INPUT --protocol $proto --dport $extPort --jump ACCEPT
sudo iptables --table filter --insert FORWARD 3 --protocol $proto --destination $ip --jump ACCEPT
sudo  iptables --table nat --append PREROUTING --protocol $proto --dport $extPort  --jump DNAT --to-destination $ip:$intPort
sudo iptables-save > /etc/iptables/rules.v4
echo "Theese rules will be cleard after a reboot, do You want to apply theese settings at every boot? [Y/n]"
read confirm2
if [[ $confirm2 == "n" ]]; then
    echo "You can re-apply theese settings by running: sudo iptables-restore < /etc/iptables/rules.v4 "
    exit 0
fi

if [[ $confirm2 == "N" ]]; then
    echo "You can re-apply theese settings by running: sudo iptables-restore < /etc/iptables/rules.v4 "
    exit 0
fi


curl -o reapply.sh https://raw.githubusercontent.com/linuximple/openvpn-port-forwarding/main/autorestore.sh && sudo bash reapply.sh

