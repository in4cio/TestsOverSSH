#!/bin/bash

clear
echo
echo -e "  # This script creates a SQLite3 database out of a \e[4mstudents.csv\e[0m file."
echo 
echo -e "  \e[1mNotice\e[0m that this script presumes  that a file called \e[4mstudents.cvs\e[0m, contaning"
echo -e "  the numbers and names of the students,  is  available  at the folder of this"
echo -e "  script. The presence of the file is tested, \e[1mbut the format is not!\e[0m"
echo -e "  Please make sure that data in the file is structured as follows:"
echo
echo -e "  Number of Student 1\e[1m(comma)\e[0mName Student 1\e[1m(newline)\e[0m"
echo -e "  Number of Student 2\e[1m(comma)\e[0mName Student 2\e[1m(newline)\e[0m"
echo -e "  ..."
echo 
echo -e "  E.g.,"
echo -e "    12589,Pedro Inácio"
echo -e "    12590,Rui Torrão"
echo -e "    ..."
echo -e "  etc."
echo

if [[ -f students.csv ]]; then

  if [[ -f db.sqlite3 ]]
  then
    rm db.sqlite3
  fi

  sqlite3 db.sqlite3 "CREATE TABLE Student(number VARCHAR(6) PRIMARY KEY NOT NULL, name VARCHAR(100), pass CHAR(10), presence INT)"
  sqlite3 db.sqlite3 "CREATE TABLE Score(number VARCHAR(6), qnumber INT, qtext VARCHAR(300), answer VARCHAR(300), score INT, penalty INT, control INT, FOREIGN KEY(number) REFERENCES Student(number) PRIMARY KEY (number,qnumber))"

  sqlite3 db.sqlite3 "CREATE TABLE StudentAux(number VARCHAR(6) PRIMARY KEY, name VARCHAR(100))"
  sqlite3 db.sqlite3 ".separator ," ".import students.csv StudentAux"
  sqlite3 db.sqlite3 "INSERT INTO Student SELECT number, name, hex(randomblob(4)), 0 FROM StudentAux"
  sqlite3 db.sqlite3 "DROP TABLE StudentAux"

  sqlite3 db.sqlite3 "INSERT INTO Student VALUES('12589','Pedro','letmein',0)"

  echo -e "  \e[1mDatabase created successfully!\e[0m"
  echo 
  echo -e "  \e[1mNEXT:\e[0m check template with questions and  tasks in \e[4mTests\e[0m, adapt and place the"
  echo -e "  files in the \e[4mStaging\e[0m directory."
  echo
  echo    "  We are done here. Moving on."
  echo
  
else

  echo -e "  File \e[4mstudents.csv\e[0m not available."
  echo -e "  Come back after fixing this. Exiting for now."
  echo

fi


