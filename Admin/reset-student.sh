#!/bin/bash

clear
echo
echo "  # This script can be used to _safely_ reset a student during a test."
echo 

echo -n "  Please type in the student number: "
read NUMBER 
echo



CHECK=`sqlite3 db.sqlite3 "SELECT COUNT(*) FROM Student WHERE number='$NUMBER'"` 2> /dev/null

if [[ $CHECK -eq 1 ]]
then
  echo "  Student found! Deleting answers and removing attendance."
  echo 
  sqlite3 db.sqlite3 "UPDATE Student set presence=0 WHERE number = '$NUMBER'" &> /dev/null
  sqlite3 db.sqlite3 "DELETE FROM Score WHERE number = '$NUMBER'" &> /dev/null
  
  CODE=`sqlite3 db.sqlite3 "SELECT pass FROM Student WHERE number='$NUMBER'"` 2> /dev/null
  echo "  Done. The code for this student is: $CODE"
  echo "  We are done here. Exiting."
  echo

else
  echo "  Student not found! Nothing to be done here. Exiting..."
  echo 
fi
