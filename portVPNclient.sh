#!/bin/bash

# I made this script mainly for myself and I only published it because I didnt find anything similar on the internet and I wanted to help others. 
# I know that its very badly written but I dont expect that more than a few people will ever use it.
# Author: linuximple@gmail.com
# YT: https://www.youtube.com/channel/UCW4LHmdX_qIE2lBT0_DW3VQ

sudo apt install openvpn
sudo touch /usr/local/sbin/vpn-autoconnect.sh.sh
sudo echo "#!/bin/bash" > /usr/local/sbin/vpn-autoconnect.sh
wd=$(pwd)

echo "Enter the path to the .OVPN file [Default: $wd/client.ovpn]"
read path

if [[ $path == "" ]]; then
    path="$wd/client.ovpn"
fi


sudo echo "sudo openvpn $path" >> /usr/local/sbin/vpn-autoconnect.sh

sudo chmod +x /usr/local/sbin/vpn-autoconnect.sh

sudo touch /etc/systemd/system/connect-to-vpn.service

sudo echo "" >> /etc/systemd/system/connect-to-vpn.service.service
sudo echo "[Unit]" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "Description=Automatically connect to VPN" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "[Service]" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "ExecStart=/usr/local/sbin/vpn-autoconnect.sh" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "[Install]" >> /etc/systemd/system/connect-to-vpn.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/connect-to-vpn.service

sudo systemctl enable connect-to-vpn.service
