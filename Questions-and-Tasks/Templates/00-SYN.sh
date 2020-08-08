#!/bin/bash

INTRO="\n  \e[1m# Prefácio\e[0m
  
  Esta  prova  vale  até  \e[1m$SCORE valores\e[0m  na  nota  final  da unidade curricular.
  Consiste em dar respostas  a várias  perguntas  e/ou  no desenvolvimento de
  várias  tarefas  (num  total  de  $NQUESTIONS)  que   deve  levar  a  cabo  num  dos
  computadores  do  laboratório  da  sala  6.27  ou,  alternativamente \e[1mcom  a\e[0m
  \e[1mconivência  do  docente\e[0m,  num computador pessoal. As respostas às perguntas
  devem ser dadas na própria plataforma.  As  questões  e tarefas têm todas o
  mesmo valor.

  O desenvolvimento das tarefas pressupõe que \e[1mnão\e[0m tem acesso à Internet e \e[1mnão\e[0m
  é permitida a  consulta de  documentação para  além dos manuais disponíveis
  via  linha  de comandos (e.g., \e[4mopenssl\e[0m), pelo  que, durante toda  a  prova,
  \e[1mqualquer ligação secundária à Internet  deve estar desativada e deve apenas
  ter  no ecrã (e em execução)  uma janela  para o  terminal e outra  para um
  editor de texto\e[0m. \e[1mNão\e[0m deve  estar qualquer \e[1mpen\e[0m ligada à máquina utilizada. O
  não  cumprimento  de  qualquer uma  destas  condições  é  \e[1mpenalizada\e[0m  com a
  anulação da prova.

  Leia o enunciado das perguntas e  tarefas  atentamente. Siga  as instruções
  dadas com afinco, já que  algumas \e[1mrespostas e resultados  dependem do rigor\e[0m
  com que são introduzidos comandos no terminal.

  Quaisquer  \e[1mtentativas  de  fraude\e[0m  durante  a  resolução  desta  prova  são
  \e[1mpenalizadas  com  a  sua   anulação\e[0m.   Queira   desligar  todos  os  outros
  dispositivos (e.g., móveis) antes do início da prova.

  \e[1m\e[4mATENÇÃO: no final, é necessário  submeter o teste,\e[0m executando o script

    > \e[4m ./XX-FIN.sh \e[0m
  "

clear
echo -e "$INTRO"
echo -e "  Prima \e[1mEnter\e[0m para continuar..."
read 

clear
echo -e "
\e[1m  # Instruções - Responder a Questões\e[0m

  Para \e[1mresponder\e[0m a uma \e[1mquestão\e[0m, execute o script com o número da questão. Por
  exemplo, digite

    >  \e[4m./01-MC.sh\e[0m

  para responder à questão de Escolha Múltipla (\e[4mM\e[0multiple \e[4mC\e[0mhoice - MC) 01.

  Caso  já  tenha  respondido à  questão  antes  (mas  quiser  submeter  nova
  resposta), digite

   >  \e[4m./01-MC.sh.DONE\e[0m
  "


echo -e "  Prima \e[1mEnter\e[0m para continuar..."
read 

clear
echo -e "
  \e[1m# Instruções - Fazer Tarefas\e[0m

  Para \e[1mfazer\e[0m  uma  \e[1mtarefa\e[0m,  execute primeiro o script com a questão/
  tarefa uma vez. Por exemplo, digite

    >  \e[4m./02-DA.sh\e[0m

  para verificar o que é necessário fazer nesta tarefa. 
  \e[1mSaia sem introduzir uma resposta.\e[0m

  Para  \e[1msubmeter resposta depois  de  executar\e[0m o que é pedido  para a tarefa,
  simplesmente \e[1mexecute o script novamente\e[0m:

    >  \e[4m./02-DA.sh\e[0m

  e introduza uma resposta desta feita.

  Caso  já  tenha  respondido à  questão  antes  (mas  quiser  submeter  nova
  resposta), digite

   >  \e[4m./01-DA.sh.DONE\e[0m
  "

echo -e "  Prima \e[1mEnter\e[0m para continuar..."
read 

clear
echo -e "
\e[1m  # Conteúdo da Diretoria de Trabalho\e[0m
  "

array=( `ls -1` )
for i in "${array[@]}"
do
	echo "  $i"
done

rm .profile

echo -e "
  Esta prova tem a duração de \e[1m$DURATION minutos\e[0m com início previsto às $START_TIME.
  \e[1mDeve terminar a prova até às $END_TIME.\e[0m"

echo -e "
  Considere evoluir para a primeira questão/tarefa, escrevendo:

    >  \e[4m./01-MC.sh\e[0m

  ou 

    >  \e[4m./01-DA.sh\e[0m

  \e[1m# Boa Sorte!\e[0m
  "