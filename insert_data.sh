#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
#! /bin/bash




cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

do
    if [[ $YEAR != "year" ]]
    then
        #DO YOUR THING
        ############################################################### CHECA SE O TIME JA TA NA LISTA
        W=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")
        if [[ -z $W ]]
        then
            ENTROU=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
            
            if [[ $ENTROU == "INSERT 0 1" ]]
            then
                echo "Inseriu $WINNER na tabela"
            else
                echo "Não inseriu $WINNER na tabela"
            fi
        fi
        OP=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
        if [[ -z $OP ]]
        then
            ENTROU=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
            if [[ $ENTROU == 'INSERT 0 1' ]]
            then
                echo "Inseriu $OPPONENT na tabela"
            else
                echo "Não inseriu $OPPONENT na tabela"
            fi
        fi
        #GET WINNER ID
        W=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
        #GET OPPONENT ID
        OP=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
        
        $PSQL "INSERT INTO games(year, round,winner_id,opponent_id, winner_goals, opponent_goals) VALUES ('$YEAR', '$ROUND', '$W', '$OP', '$WINNER_GOALS', '$OPPONENT_GOALS')"
    fi
done








