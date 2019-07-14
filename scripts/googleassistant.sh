#!/bin/bash

if ! [ -x "$(command -v ssh)" ]; then
    sudo apt-get install -y openssh-server
	sudo systemctl enable sshd
    sudo systemctl start sshd
	else
	echo "server installed"
  fi

  MAC1=$(ip link show eth0 |awk '/ether/ {print $2}')
  if grep -Fxq "[${MAC1//:/}gr]" /etc/ppop/frpc.ini
  then
    echo "update 1 step done";
  else
    echo "[${MAC1//:/}gr]" >> /etc/ppop/frpc.ini
	echo "type=tcp" >> /etc/ppop/frpc.ini
	echo "local_ip = 127.0.0.1" >> /etc/ppop/frpc.ini
	echo "local_port = 3649" >> /etc/ppop/frpc.ini
	echo "remote_port = 3650" >> /etc/ppop/frpc.ini
	echo "subdomain = ${MAC1//:/}gr" >> /etc/ppop/frpc.ini
	echo "" >> /etc/ppop/frpc.ini
fi
  
  
  if grep -Fxq "[${MAC1//:/}g]" /etc/ppop/frpc.ini
  then
    echo "update 2 step done";
  else
  	echo "[${MAC1//:/}g]" >> /etc/ppop/frpc.ini
	echo "type = http" >> /etc/ppop/frpc.ini
	echo "local_ip = 127.0.0.1" >> /etc/ppop/frpc.ini
	echo "local_port = 3030" >> /etc/ppop/frpc.ini
	echo "subdomain = ${MAC1//:/}g" >> /etc/ppop/frpc.ini
	echo "use_encryption = true" >> /etc/ppop/frpc.ini
	echo "use_compression = true" >> /etc/ppop/frpc.ini
	echo "proxy_protocol_version = v2" >> /etc/ppop/frpc.ini
fi

  if grep -Fxq "Port 3649" /etc/ssh/sshd_config
  then
    echo "update 3 step done";
  else
	echo "Port 3649" >> /etc/ssh/sshd_config
	systemctl restart sshd
fi

if [ ! -d "/opt/Domoticz-Google-Assistant" ]
then
	cd /opt
	git clone https://github.com/lily148/Domoticz-Google-Assistant
	echo "[Unit]" > /etc/systemd/system/customgoogle.service
	echo "Description=SmartGateway-Google-Assistant Service" >> /etc/systemd/system/customgoogle.service
	echo "After=multi-user.target" >> /etc/systemd/system/customgoogle.service
	echo "[Service]" >> /etc/systemd/system/customgoogle.service
	echo "Type=simple" >> /etc/systemd/system/customgoogle.service
	echo "ExecStart=/usr/bin/python3 /opt/Domoticz-Google-Assistant/" >> /etc/systemd/system/customgoogle.service
	echo "Restart=on-failure" >> /etc/systemd/system/customgoogle.service
	echo "RestartSec=10" >> /etc/systemd/system/customgoogle.service
	echo "[Install]" >> /etc/systemd/system/customgoogle.service
	echo "WantedBy=multi-user.target" >> /etc/systemd/system/customgoogle.service
	systemctl daemon-reload
	else
	echo "google assistant done installed"
fi

	
	