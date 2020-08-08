#!/bin/bash


sudo clear
echo
echo "  # This script deactivates the access point and stops the apache webserver."
echo 
echo  "  **Notice that this script only works in systems with netctl as network manager.**"
echo 

echo "  1. Disabling wlan0 (requires root credentials)."
echo
sudo ip link set wlan0 down &> /dev/null
sleep 1

echo "  2. Killing all **create_ap** scripts."
echo
sudo killall create_ap &> /dev/null
sleep 1


echo "  3. Restoring previously active netctl profiles."
echo
sudo netctl restore &> /dev/null
sleep 1

echo "  4. Enabling wlan0."
echo 
sudo ip link set wlan0 up &> /dev/null
sleep 1
echo "  Done. Restoring might require reboot..."
echo 