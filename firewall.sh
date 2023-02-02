#!/bin/bash
read -p "Please input your apache2 port : " phttp

ufw reset
yes | reset-configure-ufw
ufw allow 232/tcp
ufw allow 161/udp
ufw allow from 103.18.133.200 to any port $phttp
ufw allow from 103.18.133.200 to any port 3306
ufw allow from 103.18.132.207 to any port $phttp
ufw allow from 103.18.132.207 to any port 3306
ufw reload
ufw enable
