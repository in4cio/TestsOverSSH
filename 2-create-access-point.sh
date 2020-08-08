#!/bin/bash

sudo clear
echo
echo "  # This script will create an Access Point (AP) without Internet sharing."
echo
echo  "  **Notice that this script only works in systems with netctl as network manager.**"
echo

echo "  1. Disabling wlan0 (requires root credentials)."
echo
sudo ip link set wlan0 down &> /dev/null
sleep 1

echo "  2. Saving current profiles and disabling netctl."
echo
sudo netctl store &> /dev/null
sudo netctl stop-all &> /dev/null
sleep 1

echo "  3. Creating access point (no DNS, no Internet sharing and no connections"
echo "  between clients. AP named (and password) **CLItests**."
echo
sudo create_ap -n --no-dns --no-virt wlan0 CLItests CLItests  &> /dev/null &
sleep 1
echo "  Done. Restoring might require reboot..."
echo 
