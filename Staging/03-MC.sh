# Text appearing before the question.
PRE_QUESTION="A diretoria $QNUMBER contém o ficheiro ${UNDERLINE}pk-and-sk.pem${NONE} com um par de chaves pública e privada RSA."

# MD5(question or task)= 723d72b0b7f2956f653c62582947b9ed
QUESTION="Emita o comando ${UNDERLINE}openssl${NONE} que lhe permite descobrir o tamanho do módulo usado nestas chaves."

# Text appearing after the question.
POS_QUESTION="${BOLD}Nota:${NONE} a opção errada nesta tarefa desconta pontuação."

COMMANDS=(
  'OPTION=$((RANDOM%4))'
  'echo $OPTION >> OPTIONS'
  'case "$OPTION" in
     0) openssl genrsa -out pk-and-sk.pem 1024  &> /dev/null
     ;;
     1) openssl genrsa -out pk-and-sk.pem 2048  &> /dev/null
     ;;
     2) openssl genrsa -out pk-and-sk.pem 2020  &> /dev/null
     ;;
     *) openssl genrsa -out pk-and-sk.pem 512   &> /dev/null
     ;;
     esac'
)

NR_OF_COMMANDS=${#COMMANDS[@]}

CLEANCOMMANDS=(
  'rm OPTIONS'  
)

NR_OF_CLEAN_COMMANDS=${#CLEANCOMMANDS[@]}

# Options.
OPTIONS=(
  "1024"
  "2048"
  "2020"
  "512"
)

# openssl rsa -in pk-and-sk.pem -text

# Can options be randomly shuffled? 0 - NO; 1 - YES
SHUFFLE=1

# Correct option(s).
CORRECTCOMMANDS=(
  "cat OPTIONS"
  )

# Next variable sets the option of having a stupid answer,
# which should then be set to the number of that option.
# Leave AS IS for NO stupid option.
STUPID=-1
