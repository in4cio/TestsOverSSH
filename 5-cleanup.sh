#!/bin/bash

sudo clear
echo
echo     "  # This script will create a backup and clear everything to bare bones."
echo
echo     "  ## Before Proceeding"
echo
echo -e  "  This script should only be run \033[1mAFTER\033[00m all submissions have finished and"
echo -e  "  \033[1mgrades have been assigned!\033[00m"
echo
echo -ne "  Are you \033[1mSURE\033[00m you wish to proceed (yes/no)? "
    read ANSWER
echo

if [[ $ANSWER == 'yes' ]]; then

	echo    "  ## The Script"
	echo

	echo -e "  1. Makes a backup by calling \033[4m5-final-cleanup-and-backup.sh\033[00m."
	echo
	./5-final-cleanup-and-backup.sh
	sleep 0.5


	echo -e "  2. Deletes guest account."
	echo
	/usr/bin/sudo /usr/bin/userdel -r -f guest 2> /dev/null
	sleep 0.5

	echo -e "  3. Adds log entry."
	echo
    DATE=`date +%d%b%Y-%H:%M`
    echo "  * [INFO] $DATE : Cleaning and wrapping up." | tee -a log.md > /dev/null
    zip backup.zip log.md &> /dev/null

	echo -e "  4. Makes miscellaneous cleaning (\033[4mGuest/run-me.sh\033[00m, \033[4mAdmin/scores.csv\033[00m, etc)."
	echo
	rm Guest/run-me.sh &> /dev/null
	rm Guest/.profile &> /dev/null
	rm -r Guest &> /dev/null
	rm Staging/.profile &> /dev/null
	zip backup.zip Admin/scores.csv &> /dev/null
	zip backup.zip Admin/db.sqlite3 &> /dev/null
	rm Admin/scores.csv &> /dev/null
	rm 5-final-cleanup-and-backup.sh &> /dev/null
	rm log.md &> /dev/null
    FILENAME="$DATE-backup.zip"
	mv backup.zip $FILENAME 2> /dev/null
	sleep 0.5

	echo     "  5. Sets up some permissions."
	echo
	chmod 700 Staging/
	chmod 700 *.sh

	echo     "  Exiting."
	echo

else

	echo    "  Wise choise. Come back when you are ready!"
	echo

fi
