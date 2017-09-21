# Author   : Shubham Hibare
# Website  : www.hibare.in
# Linkedin : www.linkedin.com/in/hibare
# Github   : hibare.github.io

#Initialization
clear

#Declaring color variables
CYAN='\033[0;36m'       #CYAN COLOUR
NC='\033[0m'            #NO COLOUR
GREEN='\033[0;32m'      #GREEN COLOUR
RED='\033[0;31m'        #RED COLOUR
YELLOW='\033[1;33m'


#Start up script
tput cup 1 0

#Read greeting name
read GreetingName < WelcomeScriptName

#Banner
toilet -f smblock --filter metal "Welcome  $GreetingName"

tput cup 5 0

echo "=================================================="
echo "+                 System stats                   +"
echo "=================================================="
#Storage statistics
#Constants
LIMIT=80
EXCLUDE_LIST="Filesystem|tmpfs|udev|cdrom"
ALERT=0

#get df result
df_result=$(df -H|grep -vE "^${EXCLUDE_LIST}" | awk '{print $5" "$1}')

#Get usage
Usage=$(echo $df_result | awk '{print $1}'|cut -d '%' -f1)

#Get partition
Partition=$(echo $df_result | awk '{print $2}')

#Battery/Power statistics
#Get current power level
PowerLevel=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "percentage"| awk '{print($2)-O}')

#Get battery capacity
BatteryCapacity=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "capacity"| awk '{print($2)-O}')

#Get time to empty battery
BatteryTimeToEmpty=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "time to empty" | awk '{print $4" "$5}')

#Get battery warning level
BatteryWarningLevel=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "warning-level" | awk '{print $2}')

#Get current power state
CurrentPowerState=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "state"| awk '{print($2)}')

if [ "$CurrentPowerState" != "charging" ]; then
	#Get time to empty battery
	BatteryTimeToEmpty=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "time to empty" | awk '{print $4" "$5}')
else
	#Get time to full battery
	BatteryTimeToFull=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep -E "time to full" | awk '{print $4" "$5}')
fi

#Volume statistics
#Get current volume sink
CurrentVolumeSink=$(pacmd list-sinks | grep -E "index" | awk '{print $3}')

#Get current volume level
CurrentVolume=$(pactl list sinks | grep -E "Volume: front-left" | awk '{print $5}')


#Print stats
echo "[*] STORAGE"
echo "Storage               : $Usage% full ($Partition)"

echo ""
echo "[*] Battery/Power Level"
echo "Power level           : $PowerLevel% ($CurrentPowerState)"
if [ "$CurrentPowerState" != "charging" ]; then
	echo "Time to empty battery : $BatteryTimeToEmpty (Remaining)"
else
	echo "Time to full battery  : $BatteryTimeToFull (Remaining)"
fi
echo "Battery capacity      : $BatteryCapacity%"
echo "Battery warning level : $BatteryWarningLevel"

echo ""
echo "[*] Volume"
echo "Current volume sink   : $CurrentVolumeSink"
echo "Current volume level  : $CurrentVolume"

echo ""
echo "[*] KERNEL"
echo "Kernel varsion        : `uname -r`"

#Play alert tone
#if [ $ALERT -eq 1 ]; then
	#paplay alert.wav
#	echo ""
#else
	#echo "Everything is alright..."
	#espeak -ven-us+f4 -s170 "Everything is fine"
#	echo ""
#fi
#echo ""
