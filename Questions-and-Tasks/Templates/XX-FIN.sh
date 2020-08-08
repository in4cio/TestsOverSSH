clear
# The following is just a quick means to handle the case where someone is 
# trying to leave the environment to the guest account!
if [[ $1 == 'trying-to-escape' ]]; then
    echo 
    echo -e "  Modo de saida \e[1mnão permitida!\e[0m A ligação será terminada. 
  Se necessário, volte a entrar com o código fornecido."
    echo

    # Adding entry to the log
    DATE=`date +%d%b%Y-%H:%M`
    echo "  * [WARN] $DATE : Non permitted attempt to escape the environment from $USERNAME!" | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null

    TTY=`tty`
    /usr/bin/sudo pkill -9 -t "${TTY: -5}"
fi

# |                                                                         |          with 0   formatting
# |                                                                             |      with 0.5 formatting
# |                                                                                 |  with 1   formatting

echo 
echo -e "  # Finalização

  Quando  terminar,  \e[1mtem  de  submeter a prova\e[0m.  Depois  de submeter, novas 
  submissões ficam vedadas. Para  terminar a  prova, escreva \e[1msim\e[0m a seguir e
  carregue em \e[4m[Enter]\e[0m.
  "

echo -n "  Tem a certeza que quer submeter o teste (sim/não)? "
read ANSWER 
echo 

if [[ $ANSWER == 'sim' ]]; then

    # pkill -KILL -u s$NUMBER &> /dev/null
    sqlite3 $SQLITEDB "UPDATE Student SET presence=2 WHERE number='$NUMBER'"

    echo 
    echo -e "  \e[1mProva submetida com sucesso!\e[0m."
    echo -e "  Sairá automaticamente em \e[1m3\e[0m segundos."
    echo 
    sleep 3

    # Adding entry to the log
    NAMESTUDENT=`sqlite3 $SQLITEDB "SELECT name FROM Student WHERE number='$NUMBER'"`
    NQUESTIONSAUX=`sqlite3 $SQLITEDB "SELECT COUNT(name) FROM Student, Score WHERE Student.number='$NUMBER' AND Student.number=Score.number GROUP BY Student.number"`
    SCOREAUX=`sqlite3 $SQLITEDB "SELECT SUM(Score.score) FROM Student, Score WHERE Student.number='$NUMBER' AND Student.number=Score.number GROUP BY Student.number"`
    PENALTYAUX=`sqlite3 $SQLITEDB "SELECT SUM(Score.penalty) FROM Student, Score WHERE Student.number='$NUMBER' AND Student.number=Score.number GROUP BY Student.number"`
    DATE=`date +%d%b%Y-%H:%M`
    echo "  ---" | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null
    echo "  * [INFO] $DATE : Submission from $USERNAME ($NAMESTUDENT)!"            | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null
    echo "  * [INFO] $DATE : #Questions: $NQUESTIONSAUX; Score: $SCOREAUX; Penalty: $PENALTYAUX." | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null
    echo "  ---" | /usr/bin/sudo tee -a $BPATH/log.md > /dev/null

    TTY=`tty`
    /usr/bin/sudo pkill -9 -t "${TTY: -5}"

else

	echo "  Muito bem. Volte quando quiser submeter!"
	echo

fi
