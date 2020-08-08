#!/bin/bash

sudo clear
echo
echo -e "  # The Tests-over-SSH Monitor"
echo 
echo -e "  This script continuously reads and prints the contents of the \e[4mlog.md\e[0m of this"
echo -e "  system. Thus, it should preferrably be used while the tests are running."
echo -e "  \e[1mCaution:\e[0m it is assumed that the user has root priviledges via sudo and"
echo -e "  that the \e[4mlog.md\e[0m file is in the root directory. The existence of the"
echo -e "  file is verified!"
echo 

if [[ -f log.md ]]
then
  DATE=`date +%d%b%Y-%H:%M`
  echo "  * [INFO] $DATE : Started The Tests-over-SSH Monitor (this program)." | tee -a log.md > /dev/null
  tail -f log.md
else
  echo -e "  The file \e[4mlog.md\e[0m does not exist!"
  echo -e "  Exiting for now."
  echo
fi
