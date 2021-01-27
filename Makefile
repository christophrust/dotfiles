##
# Bootstrap my installation
#
# @file
# @version 0.1
.PHONY: rust deb-packages alacritty alacritty-install Telegram

deb-packages:
	grep "^[^#;]" .debian-packages.conf | xargs sudo apt -y install

dotfiles:
	cp -r $(ls -a | grep "^\.[a-zA-Z]") ~/



rust:
	cd /tmp && curl --proto '=https' --tlsv1.2 -sSf https\://sh.rustup.rs | sh

forticlient:
	mkdir -p ~/.fctsslvpn_trustca
	wget https://pki.uni-regensburg.de/certs/DFNCA2/zertifikatskette_uni_r_ca2.pem -O ~/.fctsslvpn_trustca/fullchain.pem
	sudo cp aux/urvpn /usr/local/bin/
	sudo chmod +x /usr/local/bin/urvpn



alacritty:
	cd /tmp && git clone https\://github.com/alacritty/alacritty.git && cd alacritty && git checkout v0.5.0
	cd /tmp/alacritty && cargo build --release


alacritty-install:
	sudo cp /tmp/alacritty/target/release/alacritty /usr/local/bin
	sudo mkdir -p /usr/local/share/man/man1
	gzip -c /tmp/alacritty/extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
	mkdir -p ~/.bash_completion
	cp /tmp/alacritty/extra/completions/alacritty.bash ~/.bash_completion/alacritty


#echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

Telegram:
	cd /tmp && wget https://updates.tdesktop.com/tlinux/tsetup.2.5.1.tar.xz && tar -xf tsetup.2.5.1.tar.xz
	mv /tmp/Telegram ~/.local/
	echo "export PATH=~/.local/Telegram/:$PATH" >> ~/.profile



obs-studio:
	cd /tmp &&  git clone https\://github.com/GeorgesStavracas/obs-studio.git && cd obs-studio && git checkout feaneron/egl-wayland
	mkdir -p /tmp/obs-studio/build && cd /tmp/obs-studio/build && cmake -DUNIX_STRUCTURE=0 -DCMAKE_INSTALL_PREFIX=${HOME}/obs-studio -DENABLE_WAYLAND=true ..
	cd /tmp/obs-studio/build && make -j4 && make install
	echo "cd ~/obs-studio/bin/64bit/ && exec ./obs @" | sudo tee /usr/local/bin/obs-wayland
	sudo chmod +x /usr/local/bin/obs-wayland

wlrobs:
	cd /tmp && hg clone https://hg.sr.ht/~scoopta/wlrobs
	cd /tmp/wlrobs && meson build && ninja -C build
	mkdir -p ~/.config/obs-studio/plugins/wlrobs/bin/64bit
	cp /tmp/wlrobs/build/libwlrobs.so ~/.config/obs-studio/plugins/wlrobs/bin/64bit

obs-v4l2sink:
	cd /tmp & git clone https\://github.com/CatxFish/obs-v4l2sink.git
	mkdir -p /tmp/obs-v4l2sink/build
	cd /tmp/obs-v4l2sink/build && cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX=/home/cgr/.local ..
	cd /tmp/obs-v4l2sink/build && make -j4

##xournalpp:
##	cd /tmp && wget https\://github.com/xournalpp/xournalpp/releases/download/1.0.20/xournalpp-1.0.20-Debian-buster-x86_64.deb
##	cd /tmp && wget https\://github.com/xournalpp/xournalpp/releases/download/1.0.20-hotfix/xournalpp-1.0.20-hotfix-hotfix-Debian-buster-x86_64.deb

r-tmap:
	R -e "install.packages('tmap')"


tdrop:
	cd /tmp && git clone https\://github.com/noctuid/tdrop.git
	cd /tmp/tdrop && sudo make install
# end


stata:
	tar -xf ~/Dropbox/Linux/stata/Stata14Linux64.tar.gz
	mkdir -p stata14
	cd stata14 && tar -xf ../unix/linux.64/bins.taz && tar -xf ../unix/linux.64/ado.taz && tar -xf ../unix/linux.64/base.taz && tar -xf ../unix/linux.64/docs.taz
	sudo mv stata14 /usr/local/
	sudo cp ~/Dropbox/Linux/stata/stata.lic /usr/local/stata14/stata.lic


osrm:
	cd /tmp && git clone https://github.com/Project-OSRM/osrm-backend.git
	cd /tmp/osrm-backend && git checkout v5.23.0
	mkdir -p /tmp/osrm-backend/build
	cd /tmp/osrm-backend/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON && cmake --build .

osrm-install:
	cd /tmp/osrm-backend/build && sudo cmake --build . --target install
