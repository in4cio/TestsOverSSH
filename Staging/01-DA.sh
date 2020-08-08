# COMMANDS for preparing the TASK or QUESTION
# THESE ARE THE FIRST TO BE RUN!
COMMANDS=(
  # e.g., 'command'
)

# COMMANDS for preparing the text appearing before the question.
# SHOULD OUTPUT Strings (preferably one string only)
PRE_QUESTION_TEXT_COMMANDS=(
  # 'echo -n "TEXT"'
)

# COMMANDS for preparing the text appearing as the question.
# SHOULD OUTPUT ONE String (THIS IS MANDATORY)
QUESTION_TEXT_COMMANDS=(
  # 'echo -n "TEXT"'
  'OPTION=$((RANDOM%6))'
  'case "$OPTION" in
    0) echo -n "Qual o significado da letra E no acrónimo ECB?" 2> /dev/null
       echo "electronic" > solution.txt 2> /dev/null
    ;;
    1) echo -n "Qual o significado da letra C no acrónimo ECB?" 2> /dev/null
       echo "code" > solution.txt 2> /dev/null
    ;;
    2) echo -n "Qual o significado da letra B no acrónimo ECB?" 2> /dev/null
       echo "book" > solution.txt 2> /dev/null
    ;;
    3) echo -n "Qual o significado da \e[1mprimeira\e[0m letra C no acrónimo CBC?" 2> /dev/null
       echo "cipher" > solution.txt 2> /dev/null
    ;;
    4) echo -n "Qual o significado da letra B no acrónimo CBC?" 2> /dev/null
       echo "block" > solution.txt 2> /dev/null
    ;;
    *) echo -n "Qual o significado da \e[1msegunda\e[0m letra C no acrónimo CBC?" 2> /dev/null
       echo "chaining" > solution.txt 2> /dev/null
    ;;
    esac'
)


# COMMANDS for preparing the text appearing after the question.
# SHOULD OUTPUT Strings (preferably one string only)
POS_QUESTION_TEXT_COMMANDS=(  
  # 'echo -n "TEXT"' 
  'echo -n "\e[1mNota:\e[0m a resposta é \e[4muma só\e[0m palavra!"'
)

# COMMANDS for preparing possible answers to this question.
# SHOULD OUTPUT A SERIES OF Strings
POSSIBILITIES_COMMANDS=(
  # e.g., 'echo -n "O modo de cifra utilizado foi ECB."'
  'cat solution.txt'
)

# COMMANDS for preparing the labels to queries
# SHOULD OUTPUT A SERIES OF (one or more) Strings
LABELS_COMMANDS=(
  'echo -n "Palavra: "'
)

# COMMANDS for CLEANING UP THE AUX FILES
# THESE ARE RUN IN LAST
CLEAN_COMMANDS=(
  'rm solution.txt'
)

# How many words should be matched in total for the answer to be correct.
NR_OF_MATCHES=1

# Case sensitive
CASE_SENSITIVE=0

# Check each word
CHECK_WORDS=1

# Relaxed approach to score
RELAX=1