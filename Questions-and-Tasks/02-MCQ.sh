# Text appearing before the question.
PRE_QUESTION=""

# MD5(question or task)= 723d72b0b7f2956f653c62582947b9ed
QUESTION="Quando usa o CHAP,  qual das duas  entidades precisa conhecer o segredo
de autenticação?"

# Text appearing after the question.
POS_QUESTION=""

# Options.
OPTIONS=(
  "Só o requerente."
  "Só o autenticador/validador."
  "Ambas." 
  "Nenhuma."
)

# Can options be randomly shuffled? 0 - NO; 1 - YES
SHUFFLE=1

# Correct option(s).
CORRECT=(
	2
	)

# Next variable sets the option of having a stupid answer,
# which should then be set to the number of that option.
# Leave AS IS for NO stupid option.
STUPID=-1