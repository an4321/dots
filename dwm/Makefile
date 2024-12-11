# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: dwm

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ} dwm-${VERSION}.tar.gz

dist: clean
	mkdir -p dwm-${VERSION}
	cp -R LICENSE Makefile README config.def.h config.mk\
		dwm.1 drw.h util.h ${SRC} dwm.png transient.c dwm-${VERSION}
	tar -cf dwm-${VERSION}.tar dwm-${VERSION}
	gzip dwm-${VERSION}.tar
	rm -rf dwm-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm\
		${DESTDIR}${MANPREFIX}/man1/dwm.1

arch:
	sudo pacman -S xorg xorg-xinit base-devel libx11 libxft libxinerama
	sudo apcman -S brightnessctl pamixer pavucontrol slock arandr feh copyq alacritty

debian:
	sudo apt install make gcc libx11-dev libxft-dev libxinerama-dev xorg psmisc
	sudo apt install brightnessctl pamixer pavucontrol slock arandr feh copyq

	# fonts:
	bash ~/Dots/bin/install_nf
	git clone https://github.com/githubnext/monaspace
	cd monaspace && bash util/install_linux.sh && cd .. && rm monaspace

	# audio:
	sudo apt install pipewire pipewire-audio-client-libraries
	sudo apt install libpipewire-0.3-0 libpipewire-0.3-dev libpipewire-0.3-modules
	sudo apt install libspa-0.2-bluetooth libspa-0.2-dev libspa-0.2-jack libspa-0.2-modules
	systemctl --user daemon-reload
	systemctl --user --now enable pipewire pipewire-pulse

	# TLP:
	sudo apt isntall tlp
	sudo tlp start

	# snap:
	sudo apt install snapd
	(read -p "Install Nvim (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && sudo snap install --classic nvim)
	(read -p "Install Alacritty (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && sudo snap install --classic alacritty)
	(read -p "Install Brave (y/N) " yn && [[ $yn =~ ^[Yy]$ ]] && sudo snap install --classic brave)


.PHONY: all clean dist install uninstall
