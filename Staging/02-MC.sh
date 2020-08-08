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
  'OPTION=$((RANDOM%3))'
  'case "$OPTION" in
    0) echo -n "Qual a situação para que é particularmente adequado o uso do modo CBC?" 2> /dev/null
       echo "0" > OPTIONS 2> /dev/null
    ;;
    1) echo -n "Qual a situação para que é particularmente adequado o uso do modo CTR?" 2> /dev/null
       echo "1" > OPTIONS 2> /dev/null
    ;;
    *) echo -n "Qual a situação para que é particularmente adequado o uso do modo ECB?" 2> /dev/null
       echo "2" > OPTIONS 2> /dev/null
    ;;
    esac'
)

# COMMANDS for preparing the text appearing after the question.
# SHOULD OUTPUT Strings (preferably one string only)
POS_QUESTION_TEXT_COMMANDS=(   
   # e.g., '${BOLD}Nota:${NONE} a opção errada nesta tarefa desconta pontuação."'
)

# COMMANDS for preparing the options for this question.
# SHOULD OUTPUT A SERIES OF Strings
OPTIONS_COMMANDS=(
  # e.g., 'echo -n "O modo de cifra utilizado foi ECB."'
  'echo -n "Para a cifra de um ficheiro grande que raramente é modificado."'
  'echo -n "Para cifrar a stream de conversação de uma chamada em curso."'
  'echo -n "Em nenhuma das situações apontadas nas outras opções."'
)

# COMMANDS for indicating the correct options for this question.
# SHOULD OUTPUT AN ARRAY OF Numbers
CORRECT_COMMANDS=(
  # e.g., 'cat OPTIONS'
  'cat OPTIONS'
)

# COMMANDS for CLEANING UP THE AUX FILES
# THESE ARE RUN IN LAST
CLEAN_COMMANDS=(
  # e.g., 'rm OPTIONS'
  'rm OPTIONS'  
)

#  MISCELANEOUS OPTIONS 
## Can options be randomly shuffled? 0 - NO; 1 - YES
SHUFFLE=1

#  Next variable sets the option of having a stupid answer,
#  which should then be set to the number of that option.
#  Leave AS IS for NO stupid option.
STUPID=-1