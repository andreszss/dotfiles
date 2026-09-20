#!/bin/sh
#
# sync - script to install/sync the dotfiles repo

log() {
    printf '\033[32m->\033[m %s.\n' "$*"
}

war() {
    printf '\033[33m->\033[m %s.\n' "$*"
}

err() {
    printf '\033[31m->\033[m %s.\n' "$*" >&2
    exit 1
}

prompt() {
	 echo "Press Enter to continue or Ctrl+C to abort"
	 read -r
}

link() {
	rm ./wallpapers/*
	cp ~/.vimrc ./vim/.vimrc 
	cp ~/imagenes/wallpapers/* ./wallpapers
	cp ~/.config/sway/config ./sway
	cp ~/.config/foot/foot.ini ./foot
	cp ~/.config/mako/ini ./mako
	cp ~/.bashrc ./home
	cp ~/.bash_logout ./home
	cp ~/.bash_profile ./home
}

install() {
	mkdir -p ~/imagenes/wallpaper
	mkdir -p ~/.config/sway
	mkdir -p ~/.config/foot
	mkdir -p ~/.config/mako
	cp ./vim/.vimrc ~/.vimrc
	cp ./wallpapers/* ~/imagenes/wallpapers
	cp ./sway/config ~/.config/sway/config
	cp ./foot/foot.ini ~/.config/foot/foot.ini
	cp ./mako/ini ~/.config/mako/ini
}


g() {
	git pull
	git add .
	git commit -m "docs: update"
	git push
}

main() {
	if [ "$1" = link ]; then
		log linking dotfiles, overwritting old dotfiles
		link
		log dotfiles linked successfully

		log upload changes to repo?
		prompt
		g
	elif [ "$1" = install ]; then
		war you are about to install the dotfiles, if you have dotfiles in sway, foot, mako, vim, these will be overwritten
		prompt
		if install > log.log 2>&1; then
			log "dotfiles installed successfully"
		else
			err "dotfiles not installed. Check 'log.log' for details"
		fi
	else
		printf "use: sync.sh <install/link>\n"
	fi
}

main "$1"
