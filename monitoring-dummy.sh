#!/bin/bash
#configure network
read -p "Please input your IP address : " pip
echo "Configure netplan in process.."
sed '6d' /etc/netplan/00-installer-config.yaml >> /etc/netplan/00.temp
cp /etc/netplan/00.temp /etc/netplan/00-installer-config.yaml
rm /etc/netplan/00.temp
sed -i '6i\      - '$pip'/24' /etc/netplan/00-installer-config.yaml
yes | netplan try > /dev/null 2>&1
yes | netplan apply > /dev/null 2>&1
echo "Configure netplan success"
#configure apache & firewall
read -p "Please input your apache2 port : " phttp
echo "Configure Apache & Firewall.."
wget https://raw.githubusercontent.com/diwa-19/dailyscripting/main/ports.conf > /dev/null 2>&1
cp ports.conf /etc/apache2/ports.conf
rm ports.conf
sed -i '/Listen 80/d' /etc/apache2/ports.conf
sed -i '5i\Listen '$phttp /etc/apache2/ports.conf
service apache2 restart
echo "Configure Apache success"
yes | ufw reset
ufw allow 232/tcp
ufw allow 161/udp
ufw allow from 103.18.133.200 to any port $phttp
ufw allow from 103.18.133.200 to any port 3306
ufw allow from 103.18.132.207 to any port $phttp
ufw allow from 103.18.132.207 to any port 3306
ufw reload
yes | ufw enable > /dev/null 2>&1
echo "Configure Firewall success, now your port is : SSH(232/tcp), SNMP(161/udp), HTTP("$phttp"/tcp), MYSQL(3306)"
echo "Make sure port is running!"
netstat -tulpn
echo ""
echo "Make sure rule firewall is OK!"
ufw status
