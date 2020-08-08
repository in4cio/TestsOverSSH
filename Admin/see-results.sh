#!/bin/bash

clear
echo
echo "  # This script calculates and shows final scores and penalties per Student."
echo 

sqlite3 db.sqlite3 ".headers on" ".mode column" ".width 7 20 4 5 4 6" "SELECT Student.number, name, COUNT(name) AS 'NrQs', SUM(Score.score) AS 'Total', SUM(Score.penalty) AS 'Pen.', Student.presence AS 'STATUS' FROM Student, Score WHERE Student.number = Score.number GROUP BY Student.number"
if [[ -f scores.csv ]]
then
  rm scores.csv
fi
sqlite3 -header -csv db.sqlite3 "SELECT Student.number, name, COUNT(name) AS 'NrQs', SUM(Score.score) AS 'Total', SUM(Score.penalty) AS 'Pen.', Student.presence AS "FINISHED" FROM Student, Score WHERE Student.number = Score.number  GROUP BY Student.number" >> scores.csv

echo 
