#!/bin/bash

clear
echo
echo "  # This script can be used to _safely_ insert a new student to the database."
echo 

echo -n "  Please type in the student number: "
read NUMBER 
echo

CHECK=`sqlite3 db.sqlite3 "SELECT COUNT(*) FROM Student WHERE number='$NUMBER'"`

if [[ $CHECK -eq 0 ]]; then

  echo -n "  Please type in the student name: "
  read NAME 	
  echo	
  sqlite3 db.sqlite3 "INSERT INTO Student(number, name, pass, done) VALUES ('$NUMBER', '$NAME', hex(randomblob(5)), 0);"

  CODE=`sqlite3 db.sqlite3 "SELECT pass FROM Student WHERE number='$NUMBER'"`
  echo "  Student $NUMBER inserted. The code for this student is: $CODE"
  echo

else

  echo "  Student found! Exiting..."
  echo 

fi