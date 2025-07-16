# Linux Workstation Setup
Install tools I typically use on a Debian system.
Not my complete setup with GUI apps but a great starting point.

### dot files
bash_aliases: to store some of my commonly used aliases
tools_profile: Used to store bash functions and aliases for tools
    - ipinfo: get IP info for a provided ip or your own IP info if no IP provided.
    - aliases to tools such as python apps to launch the venv then call the apps .py file
bashrc:
    - add sbin to path (Hate having to sudo for a reboot)
    - add go to path
    - add rust to path
    - add pipx to path
    - add if tools profile exists code (just like bash_aliases)

### Tools

#### APT installed
- android-sdk-platform-tools
- binwalk
- curl
- git
- golang
- hackrf
- hashcat
- hcxdumptool
- hcxtools
- htop
- john john-data
- jq
- libimage-exiftool-perl
- libpcap-dev
- libssl-dev
- openjdk-21-jdk
- python3-pip
- python-is-python3
- python3-ldap3
- python3-yamlsou
- python3-impacket
- pipx
- qrencode
- smbclient
- tmux
- tshark
- wireguard
- xclip

#### Non APT Tools
- cvemap
- enum4linux-ng (edit enum4linux-ng.py to call the venv when running)
- ffuf
- feroxbuster
- ghidra
  - Downloads ghidra.svg to use as icon due to bug with the include ico on Debian
  - Creates a menu entry (.desktop file)
- gobuster
- hakcheckurl
- hakoriginfinder
- hakrawler
- hakrevdns
- httpx
- metasploit
- naabu
- name-that-hash
- nuclei
- nuclei templates repo
- peass-ng repo
- peass-ng scripts and ex
  - Saves the following to the tools/PEASS-ng-releases
  - linpeas.sh
  - linpeas_fat.sh
  - winPEAS.bat
  - winPEASx64.exe
  - winPEASx64_ofs.exe
  - winPEAS.ps1
- pywhat
- RustScan
- search-that-hash
- seclists
- sqlmap
- subfinder

### TODO
- Fix wireshark install to auto answer yes to the setuid question to further automate the script
- Make script to get the latest peass-ng releases (sh,bat,exe files) and place it in the peass-ng-releases dir
- Mak script to get the latest version of ghidra.
- Possibly combine the previous two into a script that will get the latest versions of all the tools installed by this script
