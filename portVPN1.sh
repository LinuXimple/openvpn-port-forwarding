#!/bin/bash

# I made this script mainly for myself and I only published it because I didnt find anything similar on the internet and I wanted to help others. 
# I know that its very badly written but I dont expect that more than a few people will ever use it.
# Author: linuximple@gmail.com
# YT: https://www.youtube.com/channel/UCW4LHmdX_qIE2lBT0_DW3VQ

wget https://raw.githubusercontent.com/LinuXimple/openvpn-install/master/openvpn-install.sh -O vpn-inst.sh
curl -o portVPN2.sh https://raw.githubusercontent.com/linuximple/openvpn-port-forwarding/main/openvpn2.sh
sudo bash vpn-inst.sh
sudo mkdir /etc/openvpn/ccd
sudo mkdir /etc/iptables/
sudo echo "client-config-dir /etc/openvpn/ccd" >> /etc/openvpn/server/server.conf
clear
echo "Set the private ip of the client [Default: 10.8.0.6]"
read ip
echo "What is the name of the certificate fo the client [Default: client]"
read client
if [[ $ip == "" ]]; then
    ip="10.8.0.6"
fi

if [[ $client == "" ]]; then
    client="client"
fi

echo "Assigning $ip to $client"

sudo echo "ifconfig-push $ip 255.255.255.0" > /etc/openvpn/ccd/$client

pubip=$(curl ifconfig.me)
user=$(whoami)
wd=$(pwd)
echo "Get this OVPN file by running this on the client mashine: 'scp $user@$pubip:$wd/$client.ovpn ~ '"

echo "Do you want to reboot ? [y/N]"
read reb

if [[ $reb == "y" ]]; then
    echo "Run the second part of this script after reboot: sudo bash portVPN2.sh' "
    sleep 5
    sudo reboot
    
fi
echo
