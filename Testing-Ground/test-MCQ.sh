NONE='\033[00m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
QNUMBER=XX

while true; do

# CLEARING
clear
echo
echo -e "#   Testing ground to try out the look and feel of questions"
echo -e "    (TODO: it still needs some work!)"
echo 
echo -e "  Place \e[1monly one\e[0m question at a time in the same directory of this script!"
echo -e "  End this \e[1mendless script\e[0m script with CTRL+C."
echo 

FILE=""
for f in *.sh; do
  if [[ "${f:0:4}" != "test" ]]; then
    FILE="./${f}"
  fi
done

source $FILE 

OPTION_NUMBER=0
NR_OF_OPTIONS=${#OPTIONS[@]}
NR_OF_CORRECT=${#CORRECT[@]}


if [[ $SHUFFLE -eq 1 ]]; then
  IFS=$'\n' ; SHUFFLED_OPTIONS=( $(shuf -e "${OPTIONS[@]}") ); unset IFS
else
  SHUFFLED_OPTIONS=("${OPTIONS[@]}")
fi

# FORMATING
echo -e "\e[1m#   $QNUMBER - Questão\e[0m                                                    (78 chars)"
echo    "  .                                                                          v"

# PRINTING QUESTION AND OPTIONS
if [[ ! $PRE_QUESTION == ""  ]]; then
  echo -e "  $PRE_QUESTION"
  echo
fi

echo    "  .                                                               (78 chars) ."
echo -e "  ${BOLD}Q.:${NONE} $QUESTION"
echo

if [[ ! $POS_QUESTION == ""  ]]; then
  echo -e "  $POS_QUESTION"
  echo
fi

echo    "  .                                                               (78 chars) ."
while [[  $OPTION_NUMBER -lt $NR_OF_OPTIONS ]]; do
  AUX=$OPTION_NUMBER
  OPTION_NUMBER=$((OPTION_NUMBER+1))
  echo -e "    $OPTION_NUMBER - ${SHUFFLED_OPTIONS[$AUX]}"
done
echo

sleep 5
done
