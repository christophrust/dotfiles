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



alacritty:
	cd /tmp && git clone https\://github.com/alacritty/alacritty.git
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


obs:
	cd /

# end
