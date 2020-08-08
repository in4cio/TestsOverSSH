#!/bin/bash

clear
echo
echo    "  # This script prints scores for each question per Student."
echo 
echo    "  Additionally:"
echo    "  1. Saves the scores per question (csv format) in"
echo -e "  \033[4mscores-per-question-student.csv\033[00m;"
echo 
echo    "  2. Saves the penalties per question (csv format) in"
echo -e "  \033[4mpenalties-per-question-student.csv\033[00m."
echo 

STUDENTS=`sqlite3 db.sqlite3 "SELECT DISTINCT Student.number FROM Student, Score WHERE Student.number = Score.number"`
STUDENTSA=(${STUDENTS//$'\n'/ })
echo > scores-per-question-student.csv
echo > penalties-per-question-student.csv

NRQ=`sqlite3 db.sqlite3 "SELECT MAX(qnumber) FROM Score"` &> /dev/null	
printf "%11s" "NRQ ->"

for j in `seq 1 $NRQ`;
do
    printf "%3s" $j
done 
echo
echo    "  ---------"

for i in "${STUDENTSA[@]}"
do
	printf "%11s" $i
	# echo -n "  $i | "
	echo -n "$i, " >> scores-per-question-student.csv
	echo -n "$i, " >> penalties-per-question-student.csv
	NRQ=`sqlite3 db.sqlite3 "SELECT MAX(qnumber) FROM Score WHERE number = '$i'"` &> /dev/null	

	for j in `seq 1 $NRQ`;
	do
		SCORE=`sqlite3 db.sqlite3 "SELECT score FROM Score WHERE number = '$i' AND qnumber = $j"` &> /dev/null	
		PENALTY=`sqlite3 db.sqlite3 "SELECT penalty FROM Score WHERE number = '$i' AND qnumber = $j"` &> /dev/null	

		if [[ $SCORE == '' ]]; then
            printf "%3s" "   "

			if [ $j -lt $NRQ ]; then
				echo -n " , " >> scores-per-question-student.csv
				echo -n " , " >> penalties-per-question-student.csv
			fi

		else
			printf "%3s" $SCORE

			if [ $j -lt $NRQ ]; then
				echo -n "$SCORE, " >> scores-per-question-student.csv
				echo -n "$PENALTY, " >> penalties-per-question-student.csv
			else
				echo -n "$SCORE" >> scores-per-question-student.csv
				echo -n "$PENALTY" >> penalties-per-question-student.csv
			fi
		fi



	done      
	echo 
	echo >> scores-per-question-student.csv
	echo >> penalties-per-question-student.csv
done

echo
echo "  We are done here. Moving on."
echo


