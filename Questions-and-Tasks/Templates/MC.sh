




OPTION_NUMBER=0
NR_OF_OPTIONS=${#OPTIONS[@]}
NR_OF_CORRECT=${#CORRECT[@]}

if [[ $SHUFFLE -eq 1 ]]; then
  IFS=$'\n' ; SHUFFLED_OPTIONS=( $(shuf -e "${OPTIONS[@]}") ); unset IFS
else
  SHUFFLED_OPTIONS=("${OPTIONS[@]}")
fi

# FORMATING
clear
printf "\e[2m  +------------------------------------------------------.-------------------+\n\e[0m"
printf "\e[1m  # $QNUMBER - Tarefa/Questão\e[0m"
printf "\e[2m                                  |         São %s |\n\e[0m" `date +"%H:%M"`
printf "\e[2m  |                                                      |  Termina às \e[5m%s\e[25m |\n\e[0m" $END_TIME
printf "\e[2m  +------------------------------------------------------^-------------------+\n\e[0m"

# PRINTING QUESTION AND OPTIONS
if [[ ! $PRE_QUESTION == ""  ]]; then
  printf "%b\n\n" "  $PRE_QUESTION"
fi

printf "%b\n\n" "  ${BOLD}Q.: ${NONE}${QUESTION}"

if [[ ! $POS_QUESTION == ""  ]]; then
  printf "%b\n\n" "  ${POS_QUESTION}"
fi

while [[  $OPTION_NUMBER -lt $NR_OF_OPTIONS ]]; do
  AUX=$OPTION_NUMBER
  OPTION_NUMBER=$((OPTION_NUMBER+1))
  echo -e "    $OPTION_NUMBER - ${SHUFFLED_OPTIONS[$AUX]}"
done
echo

# COLLECTING AND SANITIZING ANSWER(S)
ANSWER=-1
SANSWER=""
declare -a ANSWERS

while [[ $ANSWER -ne 0 ]]; do
  if [[ ${#ANSWERS[@]} -eq 0 ]]; then
    echo -e  "  Insira uma resposta (um \e[1mnúmero\e[0m) seguida de \e[4m[ENTER]\e[0m."
    echo -e  "  Caso haja várias opções certas, insira uma resposta \e[1mde cada vez\e[0m."
    echo -ne "  (coloque um 0 para não responder e sair): "
  else
    echo -e  "  Insira \e[1moutra\e[0m resposta, seguida de \e[4m[ENTER]\e[0m "
    echo -ne "  OU prima \e[4m[ENTER]\e[0m para finalizar a resposta: "
  fi
  read ANSWER
  echo

  while [[ $ANSWER -lt 0 ]] || [[ $ANSWER -gt $OPTION_NUMBER ]]; do
    echo -ne "  \e[1mATENÇÃO:\e[0m Deve ser um número entre 0 (inclusive) e $OPTION_NUMBER (inclusive): "
    read ANSWER
    echo 
  done

  if [[ $ANSWER -gt 0 ]] && [[ $ANSWER -lt $((OPTION_NUMBER+1)) ]]; then
    NPREVANS=1
    for PREVANS in "${ANSWERS[@]}"; do
      if [[ $((ANSWER-1)) -eq $PREVANS ]]; then
        NPREVANS=0
      fi
    done
    
    if [[ $NPREVANS -eq 1 ]]; then
      ANSWERS[${#ANSWERS[@]}]=$((ANSWER-1))
      SANSWER="$SANSWER ${SHUFFLED_OPTIONS[$((ANSWER-1))]};"      
    fi
  fi
done


# CALCULATING SCORE
SCORE=0
PENALTY=0
NR_OF_ANSWERS=${#ANSWERS[@]}

if [[ $NR_OF_ANSWERS -gt 0 ]]; then

  for i in "${ANSWERS[@]}"; do
    ASSESS=0
    for j in "${CORRECT[@]}"; do
      if [[ "${OPTIONS[$j]}" ==  "${SHUFFLED_OPTIONS[$i]}" ]]; then
        ASSESS=1
      fi
    done
    if [[ $ASSESS -eq 1 ]]; then
      SCORE=$((SCORE+1))
    else
      SCORE=-100
      if [[ $NR_OF_OPTIONS -eq 2 ]]; then
        PENALTY=-1
      elif [ $STUPID -ne -1 ] && [  "${OPTIONS[$STUPID]}" ==  "${SHUFFLED_OPTIONS[$i]}" ]; then
          PENALTY=-1
      fi
    fi
  done
  
  
  if [[ $SCORE -eq $NR_OF_CORRECT ]]; then
    SCORE=2
  elif [[ $SCORE -ge $((NR_OF_OPTIONS/2)) ]]; then
    SCORE=1
  else
    SCORE=0
  fi
  
  if [[ $PENALTY -eq -1 ]]; then
    SCORE=0
  fi
  
  # UPDATING DATABASE
  P_ANSWERED=`sqlite3 $SQLITEDB "SELECT COUNT(*) FROM Score WHERE number='$NUMBER' AND qnumber=$QNUMBER"`
  if [[ $P_ANSWERED -eq 0 ]]
  then
    sqlite3 $SQLITEDB "INSERT INTO Score VALUES('$NUMBER', $QNUMBER, '$QUESTION', '$SANSWER', $SCORE, $PENALTY, 1)"
  
  else
    sqlite3 $SQLITEDB "UPDATE Score SET answer='$SANSWER', score=$SCORE, penalty=$PENALTY WHERE number='$NUMBER' AND qnumber=$QNUMBER"
  fi
  
  sqlite3 $SQLITEDB "UPDATE Student SET presence=1 WHERE number='$NUMBER'"
  
  # CHANGING NAME OF FILE TO REFLECT PREVIOUS ANSWER
  if [[ ! $0 = *"DONE"* ]]; then
    NAME_OF_FILE="$0.DONE"
    mv $0 $NAME_OF_FILE 
  fi
  
  # FEEDBACK
  echo 
  echo "  Resposta registada. Pode continuar."
  echo 
else 
  echo 
  echo "  Nenhuma resposta registada."
  echo 
fi
