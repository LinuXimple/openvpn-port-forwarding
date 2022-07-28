#!/bin/bash

# I made this script mainly for myself and I only published it because I didnt find anything similar on the internet and I wanted to help others. 
# I know that its very badly written but I dont expect that more than a few people will ever use it.
# Author: linuximple@gmail.com
# YT: https://www.youtube.com/channel/UCW4LHmdX_qIE2lBT0_DW3VQ

sudo touch /usr/local/sbin/re-apply-forwarding.sh

sudo echo "#!/bin/bash" > /usr/local/sbin/re-apply-forwarding.sh

sudo echo "sudo iptables-restore < /etc/iptables/rules.v4" >> /usr/local/sbin/re-apply-forwarding.sh

sudo chmod +x /usr/local/sbin/re-apply-forwarding.sh

sudo touch /etc/systemd/system/re-apply-forwarding.service

sudo echo "" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "[Unit]" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "Description=Re-apply port forwarding" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "[Service]" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "ExecStart=/usr/local/sbin/re-apply-forwarding.sh" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "[Install]" >> /etc/systemd/system/re-apply-forwarding.service
sudo echo "WantedBy=multi-user.target" >> /etc/systemd/system/re-apply-forwarding.service

sudo systemctl enable re-apply-forwarding.service


