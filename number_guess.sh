#!/bin/bash



GUESS () {
    read GUESS_NUMBER
    if  [[ ! "$GUESS_NUMBER" =~ ^[0-9]+$ ]]
    then
        echo -e "That is not an integer, guess again:"
        GUESS
        
    else
        TRIES=$(( $TRIES+1 ))
        #is lower
        if [[ $GUESS_NUMBER -lt $NUMBER ]]
        then 
            echo "It's higher than that, guess again:"
        #is higher
        elif [[ $GUESS_NUMBER -gt $NUMBER ]]
        then
            echo "It's lower than that, guess again:"
        else
            TRIES=$(( $TRIES+1 ))
            #get best try
        BEST_TRY=$($PSQL "SELECT best_game FROM guesses WHERE username='$USERNAME'")
        if [[ -z $BEST_TRY ]]
        then
            $PSQL "UPDATE guesses SET games_played = 1,best_game = $TRIES WHERE username = '$USERNAME'"
        else
            if [[ $BEST_TRY -gt $TRIES ]]
            then
                $PSQL "UPDATE guesses SET games_played = (SELECT games_played FROM guesses WHERE username='$USERNAME')+1, best_game=$TRIES WHERE username = '$USERNAME'"
            else
                $PSQL "UPDATE guesses SET games_played = (SELECT games_played FROM guesses WHERE username='$USERNAME')+1 WHERE username = '$USERNAME'"
            fi
        fi
            echo -e "You guessed it in $TRIES tries. The secret number was $(( $NUMBER+1 )). Nice job!"

        fi
    fi
}

PSQL="psql -U freecodecamp -d number_guess -t --no-align -c"


# #CREATE THE DATABASE
# psql -U freecodecamp -d postgres --no-align --tuples-only -c "CREATE DATABASE number_guess"
# $PSQL "CREATE TABLE guesses()"
# #USERNAME
# $PSQL "ALTER TABLE guesses ADD COLUMN username VARCHAR(25)"
# #GAMES_PLAYED
# $PSQL "ALTER TABLE guesses ADD COLUMN games_played INT"
# #BEST_GAME
# $PSQL "ALTER TABLE guesses ADD COLUMN best_game INT"


#random number

NUMBER=$(( $RANDOM%1000 ))
echo $NUMBER



echo "Enter your username:"
read USERNAME 

CHECKNAME=$($PSQL "SELECT username FROM guesses WHERE username='$USERNAME'")



if [[ -z $CHECKNAME ]]
then
    shopt -s lastpipe
    $PSQL "INSERT INTO guesses(username) VALUES ('$USERNAME')"
    echo $($PSQL "SELECT username FROM guesses WHERE username='$USERNAME'") | read CHECKNAME
    echo -e "Welcome, $CHECKNAME! It looks like this is your first time here."
    else
    shopt -s lastpipe
    echo $($PSQL "SELECT * FROM guesses WHERE username='$CHECKNAME'") | IFS='|' read USERNAME GAMES_PLAYED BEST_GAME
    echo -e "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi
echo -e "Guess the secret number between 1 and 1000:"
TRIES=0
while [[ $NUMBER -ne $GUESS_NUMBER ]]
do
    GUESS
done














