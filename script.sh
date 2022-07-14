#!/bin/bash

PSQL="psql -U postgres -d periodic_table -c"
$PSQL "TRUNCATE TABLE elements CASCADE"
$PSQL "TRUNCATE TABLE types CASCADE"
$PSQL "TRUNCATE TABLE properties"

psql -U postgres -d postgres -c "DROP DATABASE periodic_table"
psql -U postgres -d postgres -c "CREATE DATABASE periodic_table"
psql -U postgres -d periodic_table -f periodic_table.sql

git init 
git config user.name "RockSTU"
git config user.email "danielfbonfim@hotmail.com"
git add script.sh element.sh
git commit -m "Initial commit"
git checkout -b 'fix'

#rename columns
$PSQL "ALTER TABLE properties RENAME COLUMN weight TO atomic_mass"
$PSQL "ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celcius"
$PSQL "ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celcius"
$PSQL "ALTER TABLE properties ALTER COLUMN boiling_point_celcius SET NOT NULL"
$PSQL "ALTER TABLE properties ALTER COLUMN melting_point_celcius SET NOT NULL"
$PSQL "ALTER TABLE elements ALTER COLUMN name SET NOT NULL"


#ADD elements
$PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celcius,boiling_point_celcius) VALUES (9,'nonmetal',18.998,-228,-188.1)"
$PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES (9,'F','Fluorine')"
$PSQL "INSERT INTO properties(atomic_number,type,atomic_mass,melting_point_celcius,boiling_point_celcius) VALUES (10,'nonmetal',20.18,-248.6,-246.1)"
$PSQL "INSERT INTO elements(atomic_number,symbol,name) VALUES (10,'Ne','Neon')"


#reference table
$PSQL "ALTER TABLE properties ADD FOREIGN KEY (atomic_number) REFERENCES elements(atomic_number)"
#type table
$PSQL "CREATE TABLE types();"
$PSQL "ALTER TABLE types ADD COLUMN type_id INT PRIMARY KEY"
$PSQL "ALTER TABLE types ADD COLUMN type VARCHAR(30) NOT NULL"
$PSQL "INSERT INTO types(type_id,type) VALUES (1,'metal'),(2,'nonmetal'),(3,'metalloid')"

#add reference column to properties
$PSQL "ALTER TABLE properties ADD COLUMN type_id INT"
#fill type_id from properties with types values
$PSQL "UPDATE properties SET type_id = types.type_id FROM types WHERE properties.type = types.type"
#set type_id to not null
$PSQL "ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL"
$PSQL "ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id) "
#trailing zeros
$PSQL "ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL"
$PSQL "UPDATE properties SET atomic_mass=trim_scale(atomic_mass)"
#First letter upper case
$PSQL "UPDATE elements SET symbol=INITCAP(symbol)"
#drop type column from properties
$PSQL "ALTER TABLE properties DROP COLUMN type"
























