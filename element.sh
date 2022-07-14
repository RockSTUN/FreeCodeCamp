#!/bin/bash
PSQL="psql -U postgres -d periodic_table --tuples-only --no-align -c "
GETELEMENT () {
shopt -s nocasematch
shopt -s lastpipe
if [[ $1 =~ ^[0-9]+$ ]]
then
    TEST=$($PSQL "SELECT elements.atomic_number,symbol,name,atomic_mass,melting_point_celcius,boiling_point_celcius FROM elements FULL JOIN properties ON properties.atomic_number = elements.atomic_number WHERE elements.atomic_number = '$1'")
elif [[ $1 =~ ^[a-z]+$ ]]
then
    TEST=$($PSQL "SELECT elements.atomic_number,symbol,name,atomic_mass,melting_point_celcius,boiling_point_celcius FROM elements FULL JOIN properties ON properties.atomic_number = elements.atomic_number WHERE name = '$1' OR symbol = '$1'")
else
    echo "Please provide an element as an argument"
fi

if [[ -z "$TEST" ]]
then
    echo "I could not find that element in the database."
else
    echo $TEST |  IFS='|' read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a nonmetal, with a mass of $ATOMIC_MASS amu. Hydrogen has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi

}
if [[ -z "$1" ]] 
then
    echo "Please provide an element as an argument"
else 
    GETELEMENT "$1"
fi
