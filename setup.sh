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
sudo apt install -y openjdk-17-jdk
sudo apt install -y htop
sudo apt install -y ncdu
sudo apt install -y iperf3
sudo apt install -y iptraf-ng
sudo apt install -y mosh
sudo apt install -y sipcalc
sudo apt install -y screen

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
go get -u github.com/tomnomnom/httprobe 
echo "done"

echo "installing unfurl"
go get -u github.com/tomnomnom/unfurl 
echo "done"

echo "installing waybackurls"
go get github.com/tomnomnom/waybackurls
echo "done"

echo "installing crtndstry"
git clone https://github.com/nahamsec/crtndstry.git
echo "done"

echo "installing gobuster"
go get github.com/OJ/gobuster
echo "done"

echo "installing ffuf"
go get -u github.com/ffuf/ffuf
echo "done"

echo "installing hakrawler"
go get github.com/hakluke/hakrawler
echo "done"

echo "installing hakrevdns"
go get github.com/hakluke/hakrevdns
echo "done"

echo "downloading Seclists"
cd ~/tools/
git clone https://github.com/danielmiessler/SecLists.git
cd ~/tools/SecLists/Discovery/DNS/
##THIS FILE BREAKS MASSDNS AND NEEDS TO BE CLEANED
cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt
cd ~/tools/

echo "installing linPEAS & winPEAS"
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
echo "done"

echo "installing enum4linux-ng"
git clone https://github.com/cddmp/enum4linux-ng
echo "done"

echo "installing plumhound"
git clone https://github.com/PlumHound/PlumHound.git
echo "done"

echo "installing bloodhound"git@github.com:bmt626/linux_workstation_setup.git
git clone https://github.com/BloodHoundAD/BloodHound.git
echo "done"

echo "installing responder"
git clone https://github.com/lgandx/Responder.git
echo "done"

echo "installing OneRuleToRuleThemAll"
git clone https://github.com/NotSoSecure/password_cracking_rules.git
echo "done"

echo "installing hcxdumptool"
git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
make
sudo make install
cd ~/tools
echo "done"

echo "installing hcxtools"
git clone https://github.com/ZerBea/hcxtools.git
cd hcxtools
make
sudo make install
cd ~/tools
"echo done"

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

echo "installing speedtest-cli python"
git clone https://github.com/sivel/speedtest-cli.git
cd ~/tools
"echo done"

echo "installing speedtest-cli"
mkdir speedtest
cd speedtest
wget https://install.speedtest.net/app/cli/ookla-speedtest-1.1.1-linux-x86_64.tgz
tar -xvf ookla-speedtest-1.1.1-linux-x86_64.tgz
sudo cp speedtest /usr/bin
echo "done"

echo -e "\n\n\n\n\n\n\n\n\n\n\nDone! All tools are set up in ~/tools"
ls -la
echo "Don't forget to add your api key for wpscan to ~/.wpscan/scan.json"
