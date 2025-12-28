# Arch BTW

https://wiki.archlinux.org/title/Installation_guide

- get the iso & boot into it & do `setfont -d`
- connect to wifi `iwctl station wlan0 connect <wifi>`
- partition the disk using cfdisk with the name of the drive you want (lsblk)
   1g -> boot, 4g -> swap, rest -> root
- format:
  ```sh
  mkfs.ext4 /dev/root_partition
  mkswap /dev/swap_partition`
  mkfs.fat -F 32 /dev/efi_system_partition
  ```
- mount:
  ```sh
  mount /dev/root_partition /mnt
  mkdir -p /mnt/boot/efi
  mount /dev/efi_system_partition /mnt/boot/efi
  swapon /dev/swap_partition
  ```
- installation:
  `pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr network manager vim`
  on intel also install `intel-ucode` and on amd also install `amd-ucode`
- genfstab: `genfstab -U /mnt >/mnt/etc/fstab`
- chroot: `arch-chroot /mnt`
- time: `ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && hwclock --systohc`
- localization: `vim /etc/locale.gen && locale-gen` and then `echo 'LANG=en_US.UTF-8' >/etc/locale.conf`
- hostname: `echo arch >/etc/hostname` & `passwd`
- user: `useradd -m -G wheel -s /bin/bash user` and `passwd user`
- sudo access: `EDITOR=vim visudo` find wheel all and uncomment it
- enable services: `systemctl enable NetworkManager`
- grub: `grub-install /dev/<the-disk>` then `grub-mkconfig -o /boot/grub/grub.cfg`
- done: `exit & umount -a & reboot`
