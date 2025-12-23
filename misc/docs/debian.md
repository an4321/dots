### audio
```sh
sudo apt install -y \
    pipewire pipewire-audio-client-libraries \
    libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules \
    libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules
systemctl --user daemon-reload
systemctl --user --now enable pipewire pipewire-pulse
```

### bluetooth
```sh
sudo apt install -y bluez bluetooth blueman && sudo systemctl enable bluetooth
```

### misc
* disable sudo for brightnessctl `sudo usermod -aG video $USER`
  or `sudo visudo` -> <user> ALL=(ALL) NOPASSWD: /usr/bin/brightnessctl
