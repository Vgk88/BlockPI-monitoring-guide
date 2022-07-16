#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
PURPLE="\e[36m"
ENDCOLOR="\e[0m"

sleep 2
echo -e "${GREEN}---------------------------------------${GREEN}"
echo -e "${RED}>> Installing node_exporter...${RED}"
echo -e "${GREEN}---------------------------------------${GREEN}"
echo -e "${GREEN}by lateful${GREEN}"
sleep 2
curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest \
| grep browser_download_url \
| grep linux-amd64 \
| cut -d '"' -f 4 \
| wget -qi -
sleep 1
tar -xvf node_exporter*.tar.gz
cd  node_exporter*/
sudo cp node_exporter /usr/local/bin
sudo tee /etc/systemd/system/node_exporter.service <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF
sleep 2
sudo systemctl daemon-reload
sleep 1
sudo systemctl enable node_exporter
sleep 1
echo -e "${ENDCOLOR}>> node_exporter has been successfully installed${ENDCOLOR}"
