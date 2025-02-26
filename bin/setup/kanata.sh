#!/bin/env bash

# install kanata
wget $(curl -s https://api.github.com/repos/jtroo/kanata/releases/latest | grep -o "https://github.com/jtroo/kanata/releases/download/.*kanata" | head -n 1)
chmod +x kanata
sudo mv ./kanata /bin/

# setup source https://github.com/jtroo/kanata/blob/main/docs/setup-linux.md

# step 1 If the uinput group does not exist, create a new group
sudo groupadd uinput

# step 2 add your user to the input and the uinput group
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

# step 3 uinput device permissions
echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/99-input.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

# step 5 create and enable a systemd daemon service
mkdir -p ~/.config/systemd/user
touch ~/.config/systemd/user/kanata.service
/bin/cat <<EOF > ~/.config/systemd/user/kanata.service
[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Environment=PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
Type=simple
ExecStart=/bin/sh -c '/bin/kanata --cfg ${HOME}/.config/kanata/config.kbd'
Restart=no

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
# check whether the service is running
# systemctl --user status kanata.service

(read -p "reboot now (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && systemctl reboot)

