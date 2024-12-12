#!/bin/bash

# Completely update the system
sudo apt update
sudo apt upgrade


# Install programs
curl -fsSL https://tailscale.com/install.sh | sh

sudo apt-get install ca-certificates apt-transport-https zsh curl wget git

wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/obsidian_1.7.7_amd64.deb -O obsidian.deb
dpkg -i obsidian.deb

sudo apt install extrepo -y
sudo extrepo enable librewolf
sudo apt update
sudo apt install librewolf -y

echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb

sudo apt install keepassxc

curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop

sudo apt install gparted libreoffice

sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update && sudo apt-get install syncthing
printf "Package: *\nPin: origin apt.syncthing.net\nPin-Priority: 990\n" | sudo tee /etc/apt/preferences.d/syncthing.pref

# Configure browser
librewolf https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/	\
https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/			\
https://addons.mozilla.org/en-US/firefox/addon/contain-amazon/			\
about:settings#privacy								\
about:settings#search								\
about:settings#home								\
https://extensions.gnome.org/


# Configure GNOME
sudo apt-get install gnome-browser-connector
librewolf https://extensions.gnome.org/extension/21/workspace-indicator/	\
https://extensions.gnome.org/extension/6655/openweather/			\
https://extensions.gnome.org/extension/7/removable-drive-menu/			\
https://extensions.gnome.org/extension/4655/date-menu-formatter/		\
https://addons.mozilla.org/en-US/firefox/addon/pushbullet/			\
https://addons.mozilla.org/en-US/firefox/addon/web-clipper-obsidian/
# Configure terminal
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo "Set ZSH_THEME to powerlevel10k/powerlevel10k"
nano ~/.zshrc
sudo chsh -s `which zsh` lburlingham
