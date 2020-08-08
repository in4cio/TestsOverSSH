#!/bin/bash

sudo clear
echo
echo -e "  # Tests over SSH Platform"
echo -e "
  The Tests over SSH © platform is  a  custom made system composed mainly of a
  series of shell scripts (this is just  one  of  those scripts). It was build 
  with the purpose  of proving  a  reasonably self-contained environment where 
  tasks involving computer commands can be  performed, and to correct multiple
  choice or direct questions. It works as a replacement to the printed version
  of the analogous practical and knowledge  avaluation tests that inspired the 
  platform. 

  It can be used  to  automatically  create  personalized  tests  per  student 
  sourcing from reasonably human friendly templates."
echo 
echo -e "  ##  Copyright Notice"
echo 
echo -e "  Developed by Pedro R. M. Inácio (copyright)"
echo -e "  Department of Computer Science"
echo -e "  Universidade da Beira Interior"
echo
echo -e "  2020"
echo 
echo -e "  ##  The Script"
echo 
echo -e "  1. Sets up the base path for future usage."
echo 
BPATH=`pwd`
sleep 0.5

echo -e "  2. Sets up some permissions."
echo
chmod -R g-rw *
chmod -R o-rw *
sleep 0.5

echo -e "  3. Starts the preparation of a final cleanup script."
echo
echo "#!/bin/bash" > 5-final-cleanup-and-backup.sh
echo  >> 5-final-cleanup-and-backup.sh
chmod +x 5-final-cleanup-and-backup.sh
sleep 0.5


echo -e "  4. Starts the preparation of login apparatus script called \033[4mrun-me-aux.sh\033[00m."
echo
mkdir Guest/ &> /dev/null
cp Misc/run-me.sh Guest/run-me-aux.sh
sed -i -e "s|REPLACEWITHPATH|BPATH=$BPATH|g" Guest/run-me-aux.sh
shc -f Guest/run-me-aux.sh -o Guest/run-me.sh
rm Guest/run-me-aux.sh
rm Guest/run-me.sh
sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" Guest/run-me-aux.sh.x.c
cc Guest/run-me-aux.sh.x.c -o Guest/run-me.sh 
rm Guest/run-me-aux.sh.x.c

echo "./run-me.sh" > Guest/.profile
. Misc/config.sh
NQUESTIONS=`ls Staging | wc -l`
RSTART_TIME=`date +"%H:%M"`
END_TIME=$(date -d "$START_TIME today + $DURATION minutes" +'%H:%M')
printf 'export SCORE="%2s"\n' $SCORE                > Staging/.profile
printf "export START_TIME=$START_TIME\n"           >> Staging/.profile
printf "export DURATION=$DURATION\n"               >> Staging/.profile
printf 'export NQUESTIONS="%2s"\n' $NQUESTIONS     >> Staging/.profile
printf "export RSTART_TIME=$RSTART_TIME\n"         >> Staging/.profile
printf "export END_TIME=$END_TIME\n"               >> Staging/.profile
echo   "trap './XX-FIN.sh \"trying-to-escape\"' 0" >> Staging/.profile
echo   "alias su=\"echo 'Command NOT allowed!'\""      >> Staging/.profile
echo   "alias sudo=\"echo 'Command NOT allowed!'\""    >> Staging/.profile
echo   "alias ssh=\"echo 'Command NOT allowed!'\""     >> Staging/.profile
echo   "alias wget=\"echo 'Command NOT allowed!'\""    >> Staging/.profile
echo   "alias curl=\"echo 'Command NOT allowed!'\""    >> Staging/.profile
echo   "alias unalias=\"echo 'Command NOT allowed!'\"" >> Staging/.profile
echo   "alias alias=\"echo 'Command NOT allowed!'\""   >> Staging/.profile
printf "./00-SYN.sh\n"                                 >> Staging/.profile
sleep 0.5

echo -e "  5. Creates \033[1mguest\033[00m user with very basis rights"
echo -e "  (for inital login to system)."
echo 
#echo -n "  Please enter a simple password for this user: "
#read PASS
#echo 
PASS="guest"
/usr/bin/sudo /usr/bin/useradd -m -k "$BPATH/Guest" guest 2> /dev/null
echo guest:$PASS | /usr/bin/sudo chpasswd
/usr/bin/sudo cp Guest/run-me.sh /home/guest/run-me.sh
/usr/bin/sudo chown root:root /home/guest/run-me.sh
/usr/bin/sudo chmod 4511 /home/guest/run-me.sh
sleep 0.5

echo -e "  6. Creates the log file \e[4mlog.md\e[0m in the root folder."
echo
DATE=`date +%d%b%Y-%H:%M`
echo "  # Log format is:"                            |  tee log.md > /dev/null
echo "  * [TAG4] DayMonthYear HH:MM : Entry"         |  tee -a log.md > /dev/null
echo                                                 |  tee -a log.md > /dev/null
echo "    ---"                                       |  tee -a log.md > /dev/null
echo                                                 |  tee -a log.md > /dev/null
echo "  * [INFO] $DATE : System setup. Log Created." |  tee -a log.md > /dev/null
sleep 0.5

echo -e "  Done. User can now login with \033[4mssh guest@ip-address\033[00m, then $PASS,"
echo -e "  although there may still be work that needs to be done (see below)."
echo 
echo -e "  ---"
echo

echo -e "  To \033[1mundo\033[00m the effects of this script, run \033[4mclean-up.sh\033[00m."
echo
echo -e "  From here, you can (\033[1msuggested workflow\033[00m):"
echo -e "  1. go into \033[4mAdmin\033[00m and run \033[4m1-create-database.sh\033[00m;"
echo -e "  2. go into \033[4mAdmin\033[00m and run \033[4minsert-students.sh\033[00m;"
echo -e "  3. go into \033[4mAdmin\033[00m and run \033[4m1-show-codes.sh\033[00m."
echo -e "  \033[1mNote that\033[00m this might have been done prior to this step also."
echo
echo -e "  \033[1mBefore\033[00m running the tests, you may:"
echo -e "  4. run \033[4m2-create-access-point.sh\033[00m."
echo
echo -e "  \033[1mDuring\033[00m the tests, you might need to:"
echo -e "  5. go into \033[4mAdmin\033[00m and run \033[4minsert-student.sh\033[00m."
echo
echo -e "  \033[1mImmediately after\033[00m running the tests, you may:"
echo -e "  6. run \033[4m4-destroy-access-point.sh\033[00m."
echo
echo -e "  \033[1mAfter\033[0m the tests, you may:"
echo -e "  7. go into \033[4mAdmin\033[00m and run \033[4msee-results.sh\033[00m;"
echo -e "  8. run \033[4m5-cleanup.sh\033[00m."
echo 

echo -e "  Exiting."
echo 


# echo ":: Setting up important variables."
# # 0 - Normal Style
# # 1 - Bold
# # 2 - Dim
# # 4 - Underlined
# # 5 - Blinking
# # 7 - Reverse
# # 8 - Invisible
# echo  "NONE='\033[00m'" >> Guest/.variables.sh
# echo  "BOLD='\033[1m'" >> Guest/.variables.sh
# echo  "UNDERLINE='\033[4m'" >> Guest/.variables.sh
# echo   >> Guest/.variables.sh

