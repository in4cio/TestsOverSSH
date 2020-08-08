#!/bin/bash

# PATHS
REPLACEWITHPATH
SQLITEDB=`echo "$BPATH/Admin/db.sqlite3"`

function PrepareMC(){

  # PREPARE -----------------
  . $f 

  echo "#!/bin/bash" > Aux.sh
  echo   >> Aux.sh
  echo "# VARIABLES"  >> Aux.sh
  echo "BPATH=$BPATH"  >> Aux.sh
  echo "SQLITEDB=$SQLITEDB"  >> Aux.sh
  echo "NUMBER=$STUDENTNUMBER"  >> Aux.sh
  echo "QNUMBER=$QNUMBER"  >> Aux.sh
  echo  >> Aux.sh
  echo  "NONE='\033[00m'" >> Aux.sh
  echo  "BOLD='\033[1m'" >> Aux.sh
  echo  "UNDERLINE='\033[4m'" >> Aux.sh
  echo   >> Aux.sh
  cat $f >> Aux.sh
  echo   >> Aux.sh

  mkdir $WFILE
  cd $WFILE

  for i in "${COMMANDS[@]}"; do
    eval "${i}"
  done

  printf "\n"  >> ../Aux.sh
  printf "%b\n" "# PRE_QUESTION" >> ../Aux.sh
  printf "%b"   'PRE_QUESTION="'  >> ../Aux.sh             
  for i in "${PRE_QUESTION_TEXT_COMMANDS[@]}"; do            
    eval "${i}" >> ../Aux.sh
  done
  printf '"\n\n' >> ../Aux.sh

  printf "%b\n" "# QUESTION" >> ../Aux.sh
  printf "%b"   'QUESTION="' >> ../Aux.sh             
  for i in "${QUESTION_TEXT_COMMANDS[@]}"; do            
    eval "${i}" >> ../Aux.sh 
  done
  printf '"\n\n' >> ../Aux.sh

  printf "%b\n" "# POS_QUESTION" >> ../Aux.sh
  printf "%b"   'POS_QUESTION="' >> ../Aux.sh             
  for i in "${POS_QUESTION_TEXT_COMMANDS[@]}"; do            
    eval "${i}" >> ../Aux.sh
  done
  printf '"\n\n' >> ../Aux.sh

  printf "%b\n" "# OPTIONS"  >> ../Aux.sh
  printf "%b\n"   'OPTIONS=(' >> ../Aux.sh             
  for i in "${OPTIONS_COMMANDS[@]}"; do
    printf '"'  >> ../Aux.sh
    eval "${i}" >> ../Aux.sh 
    printf '" \n'  >> ../Aux.sh 
  done
  printf ')\n\n' >> ../Aux.sh

  printf "%b\n" "# CORRECT OPTION(s)"  >> ../Aux.sh
  printf "%b\n"   'CORRECT=(' >> ../Aux.sh             
  for i in "${CORRECT_COMMANDS[@]}"; do
    eval "${i}"  >> ../Aux.sh 
    printf ' \n' >> ../Aux.sh 
  done
  printf ')' >> ../Aux.sh

  for i in "${CLEAN_COMMANDS[@]}"; do
    eval "${i}"
  done

  cd ..

  chown -R $USERNAME "$WFILE"
  if [[ ! "$(ls -A $WFILE)" ]]; then
    rm -r $WFILE 
  else
    HWFILE="."$WFILE 
    cp -r $WFILE $HWFILE
  fi

  # END PREPARE -------------

  WFILE="$QNUMBER-MC.sh"
  cat $BPATH/Questions-and-Tasks/Templates/MC.sh >> Aux.sh

  # BEGIN COMPILE -----------
  shc -f Aux.sh -o $WFILE
  rm $WFILE
  rm Aux.sh
  sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" Aux.sh.x.c
  cc Aux.sh.x.c -o $WFILE
  rm Aux.sh.x.c          
  chown root:root $WFILE
  chmod 4511 $WFILE
  # END COMPILE --------------
}

function PrepareDA(){
  # PREPARE -----------------
  . $f 

  echo "#!/bin/bash" > Aux.sh
  echo   >> Aux.sh
  echo "# VARIABLES"  >> Aux.sh
  echo "BPATH=$BPATH"  >> Aux.sh
  echo "SQLITEDB=$SQLITEDB"  >> Aux.sh
  echo "NUMBER=$STUDENTNUMBER"  >> Aux.sh
  echo "QNUMBER=$QNUMBER"  >> Aux.sh
  echo  >> Aux.sh
  echo  "NONE='\033[00m'" >> Aux.sh
  echo  "BOLD='\033[1m'" >> Aux.sh
  echo  "UNDERLINE='\033[4m'" >> Aux.sh
  echo   >> Aux.sh
  cat $f >> Aux.sh
  echo   >> Aux.sh

  mkdir $WFILE
  cd $WFILE

  for i in "${COMMANDS[@]}"; do
    eval "${i}"
  done

  printf "\n"  >> ../Aux.sh
  printf "%b\n" "# PRE_QUESTION" >> ../Aux.sh
  printf "%b"   'PRE_QUESTION="'  >> ../Aux.sh             
  for i in "${PRE_QUESTION_TEXT_COMMANDS[@]}"; do            
    eval "${i}" >> ../Aux.sh 
    done
  printf '"\n\n' >> ../Aux.sh

  printf "%b\n" "# QUESTION" >> ../Aux.sh
  printf "%b"   'QUESTION="' >> ../Aux.sh             
  for i in "${QUESTION_TEXT_COMMANDS[@]}"; do            
    eval "${i}" >> ../Aux.sh
  done
  printf '"\n\n' >> ../Aux.sh

  printf "%b\n" "# POS_QUESTION" >> ../Aux.sh
  printf "%b"   'POS_QUESTION="' >> ../Aux.sh             
  for i in "${POS_QUESTION_TEXT_COMMANDS[@]}"; do            
    eval "${i}" >> ../Aux.sh
  done
  printf '"\n\n' >> ../Aux.sh


  printf "%b\n" "# ANSWERS should match possibilities" >> ../Aux.sh
  printf "%b\n" "POSSIBILITIES=(" >> ../Aux.sh 
  for i in "${POSSIBILITIES_COMMANDS[@]}"; do            
    printf '"'  >> ../Aux.sh
    eval "${i}" >> ../Aux.sh 
    printf '" \n'  >> ../Aux.sh 
  done
  printf ')\n\n' >> ../Aux.sh

  printf "%b\n" "# LABELS presenting entries" >> ../Aux.sh
  printf "%b\n" "LABELS=(" >> ../Aux.sh 
  for i in "${LABELS_COMMANDS[@]}"; do            
    printf '"'  >> ../Aux.sh
    eval "${i}" >> ../Aux.sh 
    printf '" \n'  >> ../Aux.sh 
  done
  printf ')\n\n' >> ../Aux.sh


  for i in "${CLEAN_COMMANDS[@]}"; do
    eval "${i}"
  done              
  
  cd ..

  chown -R $USERNAME "$WFILE"
  if [[ ! "$(ls -A $WFILE)" ]]; then
    rm -r $WFILE 
  else
    HWFILE="."$WFILE 
    cp -r $WFILE $HWFILE
  fi
            
  # END PREPARE -------------

  WFILE="$QNUMBER-DA.sh"
  cat $BPATH/Questions-and-Tasks/Templates/DA.sh >> Aux.sh

  # BEGIN COMPILE -----------
  shc -f Aux.sh -o $WFILE
  rm $WFILE
  rm Aux.sh
  sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" Aux.sh.x.c
  cc Aux.sh.x.c -o $WFILE
  rm Aux.sh.x.c          
  chown root:root $WFILE
  chmod 4511 $WFILE
  # END COMPILE --------------

}


clear
echo 
echo     "  # Welcome."
echo 
echo -e  "  A \e[1mCODE\e[0m provided by the professor is required to proceed."
echo -ne "  Please insert the \e[1mCODE\e[0m that was provided to you: "
read CODE
echo

CHECK=`sqlite3 $SQLITEDB "SELECT COUNT(number) FROM Student WHERE pass='$CODE' AND presence < 2"`

if [[ CHECK -eq 0 ]]; then

  echo -e "  \e[1mNot\e[0m possible to continue, which may be due to:"
  echo 
  echo    "  1. The user IS NOT in the database;"
  echo    "  2. (S)he may have already submitted the test;"
  echo    "  3. The code was not correctly typed."
  echo 
  echo    "  You may:"
  echo 
  echo    "  (i)  Try to run the script again and retype the CODE;"
  echo    "  (ii) Ask the professor for help or to provide a CODE."
  echo 
  echo    "  Exiting."
  echo
  # Adding entry to the log
  DATE=`date +%d%b%Y-%H:%M`
  echo "  * [WARN] $DATE : ($SSH_CLIENT) User NOT able to connect with code $CODE." | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null
  
  TTY=`tty`; /usr/bin/sudo pkill -9 -t "${TTY: -5}"

else

  STUDENTNUMBER=`sqlite3 $SQLITEDB "SELECT number FROM Student WHERE pass='$CODE'"`
  USERNAME=$(echo "s$STUDENTNUMBER" | tr "[:upper:]" "[:lower:]")
  id -u $USERNAME &> /dev/null
  CHECK=$?
  
  if [[ CHECK -eq 1 ]]
  then
    echo "  ##  User does not exist in the system yet. Creating this user."
    echo 

    sqlite3 $SQLITEDB "DELETE FROM Score WHERE number='$STUDENTNUMBER'"
    /usr/bin/sudo /usr/bin/useradd -m -k "$BPATH/Staging" $USERNAME
    echo $USERNAME:$CODE | /usr/bin/sudo chpasswd
    cd /home/$USERNAME
    touch INPREPARATION
    echo "##  Cleanup and Backup for $USERNAME" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "/usr/bin/sudo cp /home/$USERNAME/.bash_history $BPATH/$USERNAME.txt 2> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "/usr/bin/sudo zip -r backup.zip /home/$USERNAME &> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "/usr/bin/sudo /usr/bin/userdel -r $USERNAME 2> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "/usr/bin/sudo chmod o+rw $USERNAME.txt 2> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "zip backup.zip $USERNAME.txt &> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "/usr/bin/sudo rm $USERNAME.txt 2> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
    echo "" >> $BPATH/5-final-cleanup-and-backup.sh

    for f in *.sh; do 
      echo "  * Preparing question or task $f..."; 

      WFILE="${f:0:2}"
      QNUMBER="${f:0:2}"
      TYPE="${f:3:2}"


          if [[ "$TYPE" == "MC" ]]; then

            PrepareMC

          elif [[ "$TYPE" == "DA" ]]; then

            PrepareDA

          fi     
      done

      echo "  * Preparing intro and finalization scripts..."; 
      echo

      cp $BPATH/Questions-and-Tasks/Templates/00-SYN.sh 00-SYN.sh
      shc -f 00-SYN.sh -o 00-SYN.aux
      rm 00-SYN.aux
      rm 00-SYN.sh
      sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" 00-SYN.sh.x.c
      cc 00-SYN.sh.x.c -o 00-SYN.sh
      rm 00-SYN.sh.x.c
      chown root:root 00-SYN.sh
      chmod 4511 00-SYN.sh

      echo "#!/bin/bash" > XX-FIN.sh
      echo   >> XX-FIN.sh
      echo "# VARIABLES"           >> XX-FIN.sh
      echo "BPATH=$BPATH"          >> XX-FIN.sh
      echo "SQLITEDB=$SQLITEDB"    >> XX-FIN.sh
      echo "NUMBER=$STUDENTNUMBER" >> XX-FIN.sh
      echo "USERNAME=$USERNAME"    >> XX-FIN.sh
      cat $BPATH/Questions-and-Tasks/Templates/XX-FIN.sh >> XX-FIN.sh
      shc -f XX-FIN.sh -o XX-FIN.aux
      rm XX-FIN.aux
      rm XX-FIN.sh
      sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" XX-FIN.sh.x.c
      cc XX-FIN.sh.x.c -o XX-FIN.sh
      rm XX-FIN.sh.x.c
      chown root:root XX-FIN.sh
      chmod 4511 XX-FIN.sh

      # Adding entry to the log
      DATE=`date +%d%b%Y-%H:%M`
      echo "  * [INFO] $DATE : ($SSH_CLIENT) Generated test and user for $USERNAME." | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null
 

      rm INPREPARATION
      su -l $USERNAME

      # END CREATE USER ---------------

    else

      if [[ -f /home/$USERNAME/INPREPARATION  ]]; then
       exit
      fi

      echo "  ## User exists."
      echo 
      CHECK2=0
      while [[ $CHECK2 -ne 1 ]] && [[ $CHECK2 -ne 2 ]]; do
        echo "  Would you like to:"
        echo "  1 - resume; or"
        echo "  2 - restart (DANGEROUS)?"
        echo -n "  "
        read CHECK2
        echo
      done

      if [ $CHECK2 -eq 2 ]; then
	      /usr/bin/sudo pkill -KILL -u $USERNAME
        /usr/bin/sudo /usr/bin/userdel -r -f $USERNAME 2> /dev/null

        # CREATE USER -------------------
        sqlite3 $SQLITEDB "DELETE FROM Score WHERE number='$STUDENTNUMBER'"
        /usr/bin/sudo /usr/bin/useradd -m -k "$BPATH/Staging" $USERNAME 2> /dev/null
        echo $USERNAME:$CODE | /usr/bin/sudo chpasswd
        cd /home/$USERNAME
        echo "##  Cleanup and Backup for $USERNAME (just to be sure)" >> $BPATH/5-final-cleanup-and-backup.sh
        echo "/usr/bin/sudo /usr/bin/userdel -r $USERNAME 2> /dev/null" >> $BPATH/5-final-cleanup-and-backup.sh
        echo "" >> $BPATH/5-final-cleanup-and-backup.sh

        for f in *.sh; do 
          echo "  * Preparing question or task $f..."; 
          # echo

          WFILE="${f:0:2}"
          QNUMBER="${f:0:2}"
          TYPE="${f:3:2}"


          if [[ "$TYPE" == "MC" ]]; then

            PrepareMC

          elif [[ "$TYPE" == "DA" ]]; then

            PrepareDA

          fi    
        done

        echo "  * Preparing intro and finalization scripts..."; 
        echo

        cp $BPATH/Questions-and-Tasks/Templates/00-SYN.sh 00-SYN.sh
        shc -f 00-SYN.sh -o 00-SYN.aux
        rm 00-SYN.aux
        rm 00-SYN.sh
        sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" 00-SYN.sh.x.c
        cc 00-SYN.sh.x.c -o 00-SYN.sh
        rm 00-SYN.sh.x.c
        chown root:root 00-SYN.sh
        chmod 4511 00-SYN.sh

        echo "#!/bin/bash" > XX-FIN.sh
        echo   >> XX-FIN.sh
        echo "# VARIABLES"            >> XX-FIN.sh
        echo "BPATH=$BPATH"           >> XX-FIN.sh
        echo "SQLITEDB=$SQLITEDB"     >> XX-FIN.sh
        echo "NUMBER=$STUDENTNUMBER"  >> XX-FIN.sh
        echo "USERNAME=$USERNAME"     >> XX-FIN.sh
        cat $BPATH/Questions-and-Tasks/Templates/XX-FIN.sh >> XX-FIN.sh
        shc -f XX-FIN.sh -o XX-FIN.aux
        rm XX-FIN.aux
        rm XX-FIN.sh
        sed -i -e "s|.*xsh(argc, argv);.*|setuid(0); argv[1] = xsh(argc, argv);|g" XX-FIN.sh.x.c
        cc XX-FIN.sh.x.c -o XX-FIN.sh
        rm XX-FIN.sh.x.c
        chown root:root XX-FIN.sh
        chmod 4511 XX-FIN.sh

        # END CREATE USER ---------------
        # Adding entry to the log
        DATE=`date +%d%b%Y-%H:%M`
        echo "  * [INFO] $DATE : ($SSH_CLIENT) Recreated test and user for $USERNAME." | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null
      
        su -l $USERNAME

    else
      # Adding entry to the log
      DATE=`date +%d%b%Y-%H:%M`
      echo "  * [INFO] $DATE : ($SSH_CLIENT) Resumed session for $USERNAME." | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null

      /usr/bin/sudo pkill -KILL -u $USERNAME
      cd /home/$USERNAME
      su -l $USERNAME    
    fi
  fi  
fi
