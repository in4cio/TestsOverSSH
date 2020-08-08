




LABEL_NUMBER=0
NR_OF_POSSIBILITIES=${#POSSIBILITIES[@]}
NR_OF_QUERIES=${#LABELS[@]}

if [ -z "$NR_OF_MATCHES" ]
then
  NR_OF_MATCHES=$NR_OF_POSSIBILITIES
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

# COLLECTING AND SANITIZING ANSWER(S)
ANSWER=-1
SANSWER=""
declare -a ANSWERS

while [[ "$ANSWER" != "" ]]; do
  SANSWER=""
  for LABEL in "${LABELS[@]}"; do
    echo -e -n "  ${BOLD}$LABEL${NONE} "
    read ANSWER
    echo    
    ANSWERS[${#ANSWERS[@]}]=$ANSWER
    SANSWER="$SANSWER $ANSWER;"  
  done

  echo -e "  Se satisfeito(a) com a resposta, prima \e[4m[ENTER]\e[0m."
  echo -n "  Qualquer outro input permite submeter nova(s) resposta(s): "
  read ANSWER
  echo

done


# CALCULATING SCORE
SCORE=0
PENALTY=0

declare -a ANSWERS_WORDS
declare -a POSSIBILITIES_WORDS

for i in "${ANSWERS[@]}"; do
  if [[ $CHECK_WORDS -eq 1 ]]; then
    aux=(`echo $i | tr " " "\n"`)
  else
    aux=$i
  fi

  for j in "${aux[@]}"; do
    if [[ $CASE_SENSITIVE == 0 ]]; then
      ANSWERS_WORDS[${#ANSWERS_WORDS[@]}]=`echo -n ${j,,} | tr -d '[:space:]'`
    else
      ANSWERS_WORDS[${#ANSWERS_WORDS[@]}]=$j
    fi

  done
done

for i in "${POSSIBILITIES[@]}"; do
  if [[ $CHECK_WORDS == 1 ]]; then
    aux=(`echo $i | tr " " "\n"`)
  else
    aux=$i
  fi

  for j in "${aux[@]}"; do
    if [[ $CASE_SENSITIVE == 0 ]]; then      
      POSSIBILITIES_WORDS[${#POSSIBILITIES_WORDS[@]}]=`echo -n ${j,,} | tr -d '[:space:]'`
    else
      POSSIBILITIES_WORDS[${#POSSIBILITIES_WORDS[@]}]=$j
    fi

  done
done

NR_OF_ANSWERS=${#ANSWERS_WORDS[@]}
NR_OF_POSSIBILITIES=${#POSSIBILITIES_WORDS[@]}

if [[ $NR_OF_ANSWERS -gt 0 ]]; then

  for i in "${ANSWERS_WORDS[@]}"; do
    ASSESS=0

    for j in "${!POSSIBILITIES_WORDS[@]}"; do
      if [[ "$i" == "${POSSIBILITIES_WORDS[$j]}" ]]; then
        ASSESS=1
        POSSIBILITIES_WORDS[$j]="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      fi
    done

    if [[ $ASSESS -eq 1 ]]; then
      SCORE=$((SCORE+1))
    fi
  done
  
  if [[ $SCORE -eq $NR_OF_MATCHES ]] && [[ $NR_OF_ANSWERS -eq $NR_OF_MATCHES ]]; then
    SCORE=2
  elif [[ $SCORE -eq $NR_OF_MATCHES ]] && [[ $RELAX -eq 1 ]]; then
    SCORE=2
  elif [[ $SCORE -gt 0 ]] && [[ $SCORE -ge $((NR_OF_MATCHES/2)) ]]; then
    SCORE=1
  else
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
