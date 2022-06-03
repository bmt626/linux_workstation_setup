#!/bin/bash

WORKDIR=`pwd`

sudo apt -y update
sudo apt -y upgrade

sudo apt install -y libcurl4-openssl-dev
sudo apt install -y libssl-dev
sudo apt install -y curl
sudo apt install -y pkg-config
sudo apt install -y jq
sudo apt install -y ruby-full
sudo apt install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt install -y build-essential libffi-dev
sudo apt install -y python3-setuptools
sudo apt install -y libldns-dev
sudo apt install -y python3-pip
sudo apt install -y python-is-python3
sudo apt install -y python3-dnspython
sudo apt install -y rename
sudo apt install -y xargs
sudo apt install -y tmux
sudo apt install -y binwalk
sudo apt install -y nmap
sudo apt install -y john john-data
sudo apt install -y hydra hydra-gtk
sudo apt install -y hashcat
sudo apt install -y smbclient
sudo apt install -y openvpn
sudo apt install -y smbclient
sudo apt install -y python3-ldap3
sudo apt install -y python3-yaml
sudo apt install -y python3-impacket
sudo apt install -y wireshark
sudo apt install -y wavemon
sudo apt install -y macchanger
sudo apt install -y dsniff
sudo apt install -y aircrack-ng
sudo apt install -y openjdk-11-jdk
sudo apt install -y htop
sudo apt install -y ncdu
sudo apt install -y iperf3
sudo apt install -y iptraf-ng
sudo apt install -y mosh
sudo apt install -y sipcalc
sudo apt install -y screen
sudo apt install -y hcxdumptool
sudo apt install -y hcxtools
sudo apt install -y virtualbox
sudo apt install -y python3-venv

# add running user to wireshark group
sudo usermod -aG wireshark $USER

# add user to plugdev group
sudo usermod -aG plugdev $USER

# copy recon_profile to  ~/.recon_profile and add to bashrc
cp recon_profile ~/.recon_profile
cat <<EOT >> ~/.bashrc
if [ -f ~/.recon_profile ]; then
        . ~/.recon_profile
fi

EOT

# install go
if [[ -z "$GOPATH" ]];then
echo "It looks like go is not installed, would you like to install it now"
PS3="Please select an option : "
choices=("yes" "no")
select choice in "${choices[@]}"; do
        case $choice in
                yes)

					echo "Installing Golang"
					wget https://dl.google.com/go/go1.17.6.linux-amd64.tar.gz
					sudo tar -xvf go1.17.6.linux-amd64.tar.gz
					sudo mv go /usr/local
					export GOROOT=/usr/local/go
					export GOPATH=$HOME/go
					export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
					echo 'export GOROOT=/usr/local/go' >> ~/.bashrc
					echo 'export GOPATH=$HOME/go'	>> ~/.bashrc			
					echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc	
					source ~/.bashrc
					sleep 1
					break
					;;
				no)
					echo "Please install go and rerun this script"
					echo "Aborting installation..."
					exit 1
					;;
	esac	
done
fi

rm go1.16.linux-amd64.tar.gz

#create a tools folder in ~/
mkdir ~/tools
cd ~/tools/

#install aquatone
echo "Installing Aquatone"
go get github.com/michenriksen/aquatone
echo "done"

#install chromium
echo "Installing Chromium"
sudo snap install chromium
echo "done"

echo "installing Sublist3r"
git clone https://github.com/aboul3la/Sublist3r.git
cd Sublist3r*
pip3 install -r requirements.txt
cd ~/tools/
echo "done"

echo "installing teh_s3_bucketeers"
git clone https://github.com/tomdev/teh_s3_bucketeers.git
cd ~/tools/
echo "done"

echo "installing wpscan"
git clone https://github.com/wpscanteam/wpscan.git
cd wpscan*
sudo gem install bundler && bundle install --without test
sudo gem install wpscan
mkdir ~/.wpscan
cp $WORKDIR/wpscan/scan.json ~/.wpscan/scan.json
cd ~/tools/
echo "done"

echo "installing dirsearch"
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools/
echo "done"

echo "installing lazys3"
git clone https://github.com/nahamsec/lazys3.git
cd ~/tools/
echo "done"

echo "installing virtual host discovery"
git clone https://github.com/jobertabma/virtual-host-discovery.git
cd ~/tools/
echo "done"

echo "installing sqlmap"
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git
cd ~/tools/
echo "done"

echo "installing knock.py"
git clone https://github.com/guelfoweb/knock.git
cd ~/tools/
echo "done"

echo "installing lazyrecon"
git clone https://github.com/nahamsec/lazyrecon.git
cd ~/tools/
echo "done"

echo "installing massdns"
git clone https://github.com/blechschmidt/massdns.git
cd ~/tools/massdns
make
cd ~/tools/
echo "done"

echo "installing asnlookup"
git clone https://github.com/yassineaboukir/asnlookup.git
cd ~/tools/asnlookup
pip3 install -r requirements.txt
cd ~/tools/
echo "done"

echo "installing httprobe"
go install github.com/tomnomnom/httprobe@latest 
echo "done"

echo "installing unfurl"
go install github.com/tomnomnom/unfurl@latest 
echo "done"

echo "installing waybackurls"
go install github.com/tomnomnom/waybackurls@latest
echo "done"

echo "installing crtndstry"
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

echo "installing gobuster"
go install github.com/OJ/gobuster@latest
echo "done"

echo "installing ffuf"
go install github.com/ffuf/ffuf@latest
echo "done"

echo "installing hakrawler"
go install github.com/hakluke/hakrawler@latest
echo "done"

echo "installing hakrevdns"
go install github.com/hakluke/hakrevdns@latest
echo "done"

echo "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/

echo "installing linPEAS & winPEAS"
mkdir PEASS-ng
cd PEASS-ng
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEAS.bat
cd ~/tools
echo "done"

echo "installing enum4linux-ng"
git clone https://github.com/cddmp/enum4linux-ng
echo "done"

echo "installing responder"
git clone https://github.com/lgandx/Responder.git
echo "done"

echo "installing OneRuleToRuleThemAll"
git clone https://github.com/NotSoSecure/password_cracking_rules.git
echo "done"

echo "installing httpx"
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
echo "done"

echo "install metasploit"
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
cd ~/tools
echo "done"

echo "installing trape"
git clone https://github.com/jofpin/trape.git
cd trape
pip3 install -r requirements.txt
cd ~/tools
echo "done"

echo "getting mobsf"
git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
cd Mobile-Security-Framework-MobSF
./setup.sh
cd ~/tools
echo "done"

echo "getting proxmark3"
git clone https://github.com/RfidResearchGroup/proxmark3.git
cd proxmark3
sudo apt-get install --no-install-recommends git ca-certificates build-essential pkg-config libreadline-dev gcc-arm-none-eabi libnewlib-dev qtbase5-dev libbz2-dev libbluetooth-dev libpython3-dev libssl-dev -y
make accessrights
cp ~/linux_workstation_setup/proxmark3/Makefile.platform ~/tools/proxmark3/Makefile.platform
make clean && make -j
sudo make install
cd ~/tools
echo "done"

echo "getting john the ripper jumbo"
git clone https://github.com/openwall/john.git
cd john/scr
./configure && make -s clean && make
~/tools
echo "done"

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
echo "Don't forget to add your api key for wpscan to ~/.wpscan/scan.json"
