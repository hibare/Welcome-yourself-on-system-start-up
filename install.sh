#!/bin/sh

#Installation script
#Declaring color variables
CYAN='\033[0;36m'       #CYAN COLOUR
NC='\033[0m'            #NO COLOUR
GREEN='\033[0;32m'      #GREEN COLOUR
RED='\033[0;31m'        #RED COLOUR
YELLOW='\033[1;33m'

#Clear terminal screen
clear

#Banner
echo "======================================================"
echo "+             Install welcome script                 +"
echo "======================================================"                                                  
echo "    [0;1;34;94m▄▄▄▄[0m   [0;34m▄▄▄▄▄▄[0m               [0;37m▄▄▄▄▄[0m   [0;1;30;90m▄▄▄[0m    [0;1;30;90m▄▄▄[0m"
echo "  [0;34m██▀▀▀▀█[0m  [0;34m██▀▀▀[0;37m▀██[0m   [0;37m▄████▄[0m   [0;37m█[0;1;30;90m▀▀▀▀██▄[0m  [0;1;30;90m██▄[0m  [0;1;30;90m▄█[0;1;34;94m█[0m" 
echo " [0;34m██▀[0m       [0;37m██[0m    [0;37m██[0m [0;37m▄██▀[0m  [0;1;30;90m▀██[0m        [0;1;30;90m██[0m   [0;1;34;94m██▄▄██[0m " 
echo " [0;37m██[0m        [0;37m█████[0;1;30;90m██[0m  [0;1;30;90m██[0m [0;1;30;90m▄█████[0m      [0;1;34;94m▄█▀[0m     [0;1;34;94m▀██▀[0m"   
echo " [0;37m██▄[0m       [0;1;30;90m██[0m  [0;1;30;90m▀██▄[0m [0;1;30;90m██[0m [0;1;30;90m█[0;1;34;94m█▄▄██[0m    [0;1;34;94m▄█▀[0m        [0;34m██[0m"    
echo "  [0;1;30;90m██▄▄▄▄█[0m  [0;1;30;90m██[0m    [0;1;34;94m██[0m [0;1;34;94m▀█▄[0m [0;1;34;94m▀▀▀▀▀[0m  [0;1;34;94m▄[0;34m██▄▄▄▄▄[0m     [0;34m██[0m"    
echo "    [0;1;30;90m▀▀▀▀[0m   [0;1;34;94m▀▀[0m    [0;1;34;94m▀▀▀[0m [0;1;34;94m▀██[0;34m▄▄▄█▄[0m  [0;34m▀▀▀▀▀▀▀▀[0m     [0;37m▀▀[0m"    
echo "                       [0;34m▀▀▀▀▀[0m"                      
                                                
echo "======================================================"
echo "  Developed by : Shubham Hibare (CR@2Y)"
echo "  Website      : http://hibare.in"  
echo "  Github       : https://hibare.github.io/"
echo "  Linkedin     : https://linkedin.com/in/hibare"
echo "  License      : Apache License 2.0"
echo "======================================================"
echo "${RED}Disclaimer:${NC} Author of this script is not responsible 
for any damage caused to your system from using this 
script. Use this script at your own risk. You have ${RED}15 
seconds${NC} to abort the process."
echo "======================================================"
sleep 15

#Check for dependencies
echo "${CYAN}Checking for dependencies${NC}..."

#Check package upower
echo -n "[*] Checking for package UPower ... "
which upower >>/dev/null
if [ $? -eq 0 ]; then
	echo "${GREEN}[Present]${NC}"
else
	echo "${RED}[Absent]${NC}"
fi

#Check package toiler
echo -n "[*] Checking for package toilet ... "
which toilet >> /dev/null
if [ $? -eq 0 ]; then
	echo "${GREEN}[Present]${NC}"
else
	echo "${RED}[Absent]${NC}"
	echo "${YELLOW}Please install it using command apt-get install toilet${NC}"
	echo "${CYAN}ABORT${NC}"
	exit
fi

#Remember present working directory
pwd=`pwd`

#Create filesystem
echo "${CYAN}Creating file structure ... ${NC}"

#Make a directory to hold the script
echo -n "[*] Creating script directory ... "
mkdir -p  ~/.crazyScripts/WelcomeScript >> /dev/null
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#Make autostart directory
echo -n "[*] Creating autostart directory ... "
mkdir -p ~/.config/autostart >> /dev/null
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#Begin installation
echo "${CYAN}Installing program ... ${NC}"

#Copy script to the location
echo -n "[*] Installing script ... "
cp src/main.sh ~/.crazyScripts/WelcomeScript/ >> /dev/null
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
fi

#Change permissions
echo -n "[*] Adjusting permissions ... "
chmod 755 ~/.crazyScripts/WelcomeScript/main.sh
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
fi

#Creat a file to hold greeting name
echo -n "[*] Creating name holder ... "
touch ~/.crazyScripts/WelcomeScript/WelcomeScriptName
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#Read name
echo -n "[*] Enter name: "
read name
if [ $? -eq 0 ]; then
	echo $name >> ~/.crazyScripts/WelcomeScript/WelcomeScriptName
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#Change to autostart directory
cd ~/.config/autostart

#create a start up file
echo -n "[*] Creating start-up file ... "
touch gnome-terminal.desktop
if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi

#Write start-up file
echo -n "[*] Writing start up file ... "
echo "[Desktop Entry]" >> gnome-terminal.desktop
echo "Type=Application" >> gnome-terminal.desktop
echo "Exec=gnome-terminal -e \"bash -c $HOME/.crazyScripts/WelcomeScript/main.sh;bash\"" >> gnome-terminal.desktop
echo "Hidden=false" >> gnome-terminal.desktop
echo "NoDisplay=false" >> gnome-terminal.desktop
echo "X-GNOME-Autostart-enabled=true" >> gnome-terminal.desktop
echo "Name[en_NG]=Terminal" >> gnome-terminal.desktop
echo "Name=Terminal" >> gnome-terminal.desktop
echo "Comment[en_NG]=Start terminal" >> gnome-terminal.desktop
echo "Comment=Start terminal" >> gnome-terminal.desktop

if [ $? -eq 0 ]; then
	echo "${GREEN}[Done]${NC}"
else
	echo "${RED}[Failed]${NC}"
	exit
fi
echo "${GREEN} Completed."
echo "${GREEN} Reboot to see the effect ${NC}"
