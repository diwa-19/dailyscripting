#!/bin/bash
#configure network
read -p "Please input your IP address : " pip
sed '6d' /etc/netplan/00-installer-config.yaml >> /etc/netplan/00.temp
cp /etc/netplan/00.temp /etc/netplan/00-installer-config.yaml
rm /etc/netplan/00.temp
sed -i '6i\      - '$pip'/24' /etc/netplan/00-installer-config.yaml
yes | netplan try
yes | netplan apply
#configure apache & firewall
read -p "Please input your apache2 port : " phttp
sed -i '/Listen 96/d' /etc/apache2/ports.conf
sed -i '5i\Listen '$phttp /etc/apache2/ports.conf
service apache2 restart
yes | ufw reset
ufw allow 232/tcp
ufw allow 161/udp
ufw allow from 103.18.133.200 to any port $phttp
ufw allow from 103.18.133.200 to any port 3306
ufw allow from 103.18.132.207 to any port $phttp
ufw allow from 103.18.132.207 to any port 3306
ufw reload
yes | ufw enable
