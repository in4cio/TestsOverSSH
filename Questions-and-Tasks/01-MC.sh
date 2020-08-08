# COMMANDS for preparing the TASK or QUESTION
# THESE ARE THE FIRST TO BE RUN!
COMMANDS=(
  ''
)

# COMMANDS for preparing the text appearing before the question.
# SHOULD OUTPUT Strings
PRE_QUESTION_TEXT_COMMANDS=(
   # 'command'
)

# COMMANDS for preparing the text appearing as the question.
# SHOULD OUTPUT ONE String (THIS IS MANDATORY)
QUESTION_TEXT_COMMANDS=(
   # 'command'
)

# COMMANDS for preparing the text appearing after the question.
# SHOULD OUTPUT Strings
POS_QUESTION_TEXT_COMMANDS=(   
   # e.g., '${BOLD}Nota:${NONE} a opção errada nesta tarefa desconta pontuação."'
)

# COMMANDS for preparing the options for this question.
# SHOULD OUTPUT AN ARRAY OF Strings
OPTIONS_COMMANDS=(
  # e.g., "O modo de cifra utilizado foi ECB."
)

# COMMANDS for indicating the correct options for this question.
# SHOULD OUTPUT AN ARRAY OF Strings
CORRECT_COMMANDS=(
  # e.g., "cat OPTIONS"
)

# COMMANDS for CLEANING UP THE AUX FILES
# THESE ARE RUN IN LAST
CLEAN_COMMANDS=(
  ''  
)

#  MISCELANEOUS OPTIONS 
## Can options be randomly shuffled? 0 - NO; 1 - YES
SHUFFLE=0

#  Next variable sets the option of having a stupid answer,
#  which should then be set to the number of that option.
#  Leave AS IS for NO stupid option.
STUPID=-1