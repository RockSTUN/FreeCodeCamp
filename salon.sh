#!/bin/bash
psql -U freecodecamp -d postgres < salon.sql
PSQL="psql -U freecodecamp -d salon --no-align --tuples-only -c"

################################################################### FUNCTIONS
MAIN_MENU(){
    echo "$($PSQL "SELECT * FROM services")" | while IFS='|' read SERVICE_ID SERVICE
    do
        echo "$SERVICE_ID) $SERVICE"
    done
}


GET_SERVICE(){
    read SERVICE_ID_SELECTED
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id = '$SERVICE_ID_SELECTED';")
    SERVICE=$($PSQL "SELECT name FROM services WHERE service_id = '$SERVICE_ID_SELECTED'")
    if [[ -z $SERVICE_ID ]]
    then 
        echo -e "\nI could not find that service. What would you like today?"
        MAIN_MENU 
        GET_SERVICE
    else
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        CUSTOMER_PHONE_SELECTED=$($PSQL "SELECT phone FROM customers WHERE phone = '$CUSTOMER_PHONE'")
        if [[ -z $CUSTOMER_PHONE_SELECTED ]]
        then
            echo -e "\nI don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
            read SERVICE_TIME
            echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
            
            CUSTOMER_INSERT=$($PSQL "INSERT INTO customers(phone,name) VALUES ('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
            APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id,service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID','$SERVICE_TIME');")
        else
            CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE_SELECTED';")
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE_SELECTED';")
            echo -e "\nWhat time would you like your $SERVICE, $CUSTOMER_NAME?"
            read SERVICE_TIME
            echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
            APPOINTMENT_INSERT=$($PSQL "INSERT INTO appointments(customer_id,service_id, time) VALUES('$CUSTOMER_ID','$SERVICE_ID','$SERVICE_TIME');")
        
        fi
        
    fi
}

################################################################### MAIN SCRIPT
echo -e "\n~~~~~ MY SALON ~~~~~\n\nWelcome to My Salon, how can I help you?\n"

MAIN_MENU

GET_SERVICE
