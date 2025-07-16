#!/bin/bash

sudo apt install -y android-sdk-platform-tools
sudo apt install -y binwalk
sudo apt install -y curl
sudo apt install -y git
sudo apt install -y hackrf
sudo apt install -y hashcat
sudo apt install -y hcxdumptool
sudo apt install -y hcxtools
sudo apt install -y htop
sudo apt install -y john john-data
sudo apt install -y jq
sudo apt install -y libimage-exiftool-perl
sudo apt install -y libpcap-dev
sudo apt install -y libssl-dev
sudo apt install -y openjdk-21-jdk
sudo apt install -y python3-pip
sudo apt install -y python-is-python3
sudo apt install -y python3-ldap3
sudo apt install -y python3-yamlsou
sudo apt install -y python3-impacket
sudo apt install -y pipx
sudo apt install -y qrencode
sudo apt install -y smbclient
sudo apt install -y tmux
sudo apt install -y tshark
sudo apt install -y wireguard
sudo apt instlal -y xclip

# Install wireshark and auto answer setuid question to true
echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections && sudo DEBIAN_FRONTEN=noninteractive apt install -y wireshark

# Add current user to wireshark group
sudo usermod -aG wireshark $USER

# Create tools directory and set toolsdir variable
mkdir $HOME/tools
export toolsdir=$HOME/tools

# copy tools_profile to  ~/.tools_profile and add to bashrc
cp tools_profile ~/.tools_profile
cat <<EOT >> ~/.bashrc
if [ -f ~/.tools_profile ]; then
        . ~/.tools_profile
fi

EOT

# copy bash_aliases to home dir
cp bash_aliases ~/.bash_aliases

# Add pipx to path
pipx ensurepath

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install naabu - libcap on Linux: sudo apt install -y libpcap-dev, on Mac: brew install libpcap
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# install cvemap
go install github.com/projectdiscovery/cvemap/cmd/cvemap@latest

# Install nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# Install hakoriginfinder
go install github.com/hakluke/hakoriginfinder@latest

# Install hakcheckurl
go install github.com/hakluke/hakcheckurl@latest

# Install hakrevdns
go install github.com/hakluke/hakrevdns@latest

# Install hakrawler
go install github.com/hakluke/hakrawler@latest

# Git Nuclei Templates
cd $toolsdir
git clone https://github.com/projectdiscovery/nuclei-templates.git

# Install ffuf
go install github.com/ffuf/ffuf/v2@latest

# Install gobuster
go install github.com/OJ/gobuster/v3@latest

# Install RustScan
cargo install rustscan

# Install search-that-hash
# https://github.com/bee-san/Search-That-Hash
pipx install search-that-hash

# Install name-that-hash
# https://github.com/bee-san/Name-That-Hash
pipx install name-that-hash


# Install pywhat
# https://github.com/bee-san/pyWhat
pipx install pywhat

# Get seclists
cd $toolsdir
git clone https://github.com/danielmiessler/SecLists.git

# Install feroxbuster
curl -sL https://raw.githubusercontent.com/epi052/feroxbuster/main/install-nix.sh | bash -s $HOME/.local/bin

# Install impacket
# pipx install impacket

# Install sqlmap
cd $toolsdir
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git

# Git peass-ng repo
cd $toolsdir
git clone https://github.com/peass-ng/PEASS-ng.git


# Get peass-ng scripts and exes
cd $toolsdir
mkdir PEASS-ng-releases
cd PEASS-ng-releases

latest_peass_url=$(curl -s https://api.github.com/repos/peass-ng/PEASS-ng/releases/latest)

# get linpeas.sh
peass_file="linpeas.sh"
download_url=$(echo "$latest_peass_url"|jq -r '.assets[]|select(.name=="'$peass_file'").browser_download_url')
curl -L -o $peass_file $download_url
chmod +x $peass_file

# get  linpeas_fat.sh 
peass_file="linpeas_fat.sh"
download_url=$(echo "$latest_peass_url"|jq -r '.assets[]|select(.name=="'$peass_file'").browser_download_url')
curl -L -o $peass_file $download_url
chmod +x $peass_file

# get winPEAS.bat  
peass_file="winPEAS.bat"
download_url=$(echo "$latest_peass_url"|jq -r '.assets[]|select(.name=="'$peass_file'").browser_download_url')
curl -L -o $peass_file $download_url

# get winPEASx64.exe  
peass_file="winPEASx64.exe"
download_url=$(echo "$latest_peass_url"|jq -r '.assets[]|select(.name=="'$peass_file'").browser_download_url')
curl -L -o $peass_file $download_url

# get winPEASx64_ofs.exe  
peass_file="winPEASx64_ofs.exe"
download_url=$(echo "$latest_peass_url"|jq -r '.assets[]|select(.name=="'$peass_file'").browser_download_url')
curl -L -o $peass_file $download_url

# get winPEAS.ps1
curl -LO https://raw.githubusercontent.com/peass-ng/PEASS-ng/refs/heads/master/winPEAS/winPEASps1/winPEAS.ps1

# Install enum4linux-ng
cd $toolsdir
git clone https://github.com/cddmp/enum4linux-ng && \
cd enum4linux-ng && \
python3 -m venv venv &&\
source venv/bin/activate && \
pip install wheel && \
pip install -r requirements.txt && \
deactivate && \
# fix enum4linux-ng.py to activate venv when ran
sed -i "1s|^#\!/usr/bin/env python3$|#\!${toolsdir}/enum4linux-ng/venv/bin/python3|" enum4linux-ng.py

# Install metasploit
cd $toolsdir
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
rm msfinstall

# Install ghidra
cd /tmp
curl -s https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest |\
jq -r '.assets[] | select(.name | test("^ghidra.*\\.zip$")) | .browser_download_url' |\
xargs -n 1 curl -LO
unzip ghidra*.zip
echo "Installing ghidra to /opt"
sudo mv ghidra*/ /opt/ghidra

#Fix ghidra.ico
# On Debian the icon shows up glitched and does not render
cd /tmp
curl -LO https://raw.githubusercontent.com/bmt626/AppIcons/refs/heads/main/ghidra/ghidra.svg
sudo mv ghidra.svg /opt/ghidra/support/

# Create desktop / menu entry
echo "Creating menu entry"
cat <<EOT >> $HOME/.local/share/applications/ghidra.desktop
[Desktop Entry]
Name=Ghidra
Exec=/opt/ghidra/ghidraRun
Comment=
Terminal=false
Icon=/opt/ghidra/support/ghidra.svg
Type=Application

EOT
