#!/bin/bash

# Since the BurpSuiteCommunity file is in the opt dir you need to 
# run this with sudo permissions
match='# INSTALL4J_ADD_VM_PARAMS='
insert='export _JAVA_OPTIONS="-Dsun.java2d.uiScale=2"'
file='/opt/BurpSuiteCommunity/BurpSuiteCommunity'
# Finds the match line and replaces it with the match line (wantto keep it)
# followed by newline and the text i want to insert to fix scaling
echo "Setting uiScale=2"
sudo sed -i "s/$match/$match\n$insert/" $file
echo "Done!"
