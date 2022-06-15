-- psql -U freecodecamp -d postgres

CREATE DATABASE universe;
--database named universe
\c universe;
-- 4 tables Com colunas NAME
CREATE TABLE galaxy(name VARCHAR(30) NOT NULL UNIQUE);
CREATE TABLE star(name VARCHAR(30) NOT NULL UNIQUE);
CREATE TABLE planet(name VARCHAR(30) NOT NULL UNIQUE);
CREATE TABLE moon(name VARCHAR(30) NOT NULL UNIQUE);
-- Each table should have a primary key that increment
ALTER TABLE galaxy ADD COLUMN galaxy_id SERIAL;
ALTER TABLE star ADD COLUMN star_id SERIAL;
ALTER TABLE planet ADD COLUMN planet_id SERIAL;
ALTER TABLE moon ADD COLUMN moon_id SERIAL;

ALTER TABLE galaxy ADD PRIMARY KEY (galaxy_id);
ALTER TABLE star ADD PRIMARY KEY (star_id);
ALTER TABLE planet ADD PRIMARY KEY (planet_id);
ALTER TABLE moon ADD PRIMARY KEY (moon_id);



-- Each foreign key column should have the same name as the column it is referencing

-- Each "star" should have a foreign key that references one of the rows in galaxy
ALTER TABLE star ADD COLUMN galaxy_id INT;
ALTER TABLE star ADD FOREIGN KEY(galaxy_id) REFERENCES galaxy(galaxy_id);
-- Each "planet" should have a foreign key that references one of the rows in star
ALTER TABLE planet ADD COLUMN star_id INT;
ALTER TABLE planet ADD FOREIGN KEY(star_id) REFERENCES star(star_id);
-- Each "moon" should have a foreign key that references one of the rows in planet
ALTER TABLE moon ADD COLUMN planet_id INT;
ALTER TABLE moon ADD FOREIGN KEY(planet_id) REFERENCES planet(planet_id);



ALTER TABLE galaxy ADD COLUMN distance NUMERIC(4,1);
ALTER TABLE galaxy ADD COLUMN is_spherical BOOLEAN NOT NULL;
    -- star
ALTER TABLE star ADD COLUMN distance NUMERIC(4,1);
ALTER TABLE star ADD COLUMN has_planets BOOLEAN NOT NULL;
    -- planet
ALTER TABLE planet ADD COLUMN has_life BOOLEAN;
ALTER TABLE planet ADD COLUMN is_spherical BOOLEAN NOT NULL;
    -- moon
ALTER TABLE moon ADD COLUMN a VARCHAR(10) NOT NULL;
ALTER TABLE moon ADD COLUMN b VARCHAR(10) NOT NULL;
    -- mixTable
-- Galaxy, Star, Planet, Moon should have at least 5 columns 
    -- galaxy
ALTER TABLE galaxy ADD COLUMN size INT NOT NULL;
ALTER TABLE galaxy ADD COLUMN apparent_magnitude NUMERIC(3,1);
    -- star
ALTER TABLE star ADD COLUMN hipparcus INT NOT NULL UNIQUE;
ALTER TABLE star ADD COLUMN absolute_magnitude NUMERIC(3,1);
    -- planet
ALTER TABLE planet ADD COLUMN mass INT;
ALTER TABLE planet ADD COLUMN temperature INT;
    -- moon
ALTER TABLE moon ADD COLUMN c TEXT;
ALTER TABLE moon ADD COLUMN d VARCHAR(10);

-- Each table should have at least 3 rows
    -- galaxy
INSERT INTO galaxy(name, distance, is_spherical, size, apparent_magnitude) VALUES 
('Andromeda',2, TRUE ,220 ,3), ('Antennae',65,TRUE,500,11), ('NGC 4622',200,FALSE,2,12);
INSERT INTO galaxy(name, distance, is_spherical, size, apparent_magnitude) VALUES
('Black Eye Galaxy', 17.1, FALSE, 5,18.2),('Messier 81', 18.3, FALSE, 27, 16.2),('NGC 4568', 59.6, TRUE, 5,10.7);
    -- star
INSERT INTO star(name, galaxy_id,distance, has_planets, hipparcus, absolute_magnitude) VALUES
('Kappa',1,17.0 ,TRUE ,116805 ,00.2 ),('Alpha',1,97.1 , FALSE ,677 , 10.9),('Beta',1,19.2 , FALSE ,5447 ,01.2);
INSERT INTO star(name, galaxy_id, distance, has_planets, hipparcus, absolute_magnitude) VALUES
('Upsilon', 1,44.2, TRUE, 7513,03.4),('14',1, 24.9, TRUE,116076, 19.8),('Gamma',1, 35.5, FALSE, 9640, -3.42);
    -- planet
INSERT INTO planet(name, star_id, has_life,is_spherical,mass,temperature) VALUES
('Upsilon d', 4, FALSE,TRUE,10,218),('Upsilon e', 4, FALSE,TRUE,NULL,NULL),('14 b', 5, FALSE,TRUE, NULL,NULL),
('HD 8673 b', 2,FALSE,TRUE, 1, 3520),('HD 5608', 3,FALSE,TRUE,2,4897),('HD 16175 b', 5,FALSE,TRUE, NULL, NULL),
('HD 13931 b', 6, TRUE,FALSE,NULL,NULL),('FODASE',1,FALSE,TRUE,200,1000),('FODASEMAIS',3,FALSE,TRUE,NULL,NULL);
INSERT INTO planet(name, star_id, has_life, is_spherical, mass, temperature) VALUES
('Kappa b',1, FALSE, TRUE,13,2000),('Upsilon b',3, FALSE, TRUE,2,1650 ),('Upsilon c', 4,FALSE,TRUE,14, NULL);
-- Moon should have at least 20 rows
    -- moon
INSERT INTO moon(name, planet_id, a,b,c,d) VALUES
('a',1,'ab','bc','cd','ef'),('b',2,'ab','bc','cd','ef'),('c',3,'ab','bc','cd','ef'),('d',4,'ab','bc','cd','ef'),('e',5,'ab','bc','cd','ef'),
('f',7,'ab','bc','cd','ef'),('g',5,'ab','bc','cd','ef'),('h',10,'ab','bc','cd','ef'),('i',2,'ab','bc','cd','ef'),('j',12,'ab','bc','cd','ef'),
('k',1,'ab','bc','cd','ef'),('l',6,'ab','bc','cd','ef'),('m',1,'ab','bc','cd','ef'),('n',10,'ab','bc','cd','ef'),('o',1,'ab','bc','cd','ef'),
('p',9,'ab','bc','cd','ef'),('q',4,'ab','bc','cd','ef'),('r',5,'ab','bc','cd','ef'),('s',11,'ab','bc','cd','ef'),('t',12,'ab','bc','cd','ef');

-- Your database should have at least five tables

CREATE TABLE mix_table(name VARCHAR(30) NOT NULL);
ALTER TABLE mix_table ADD COLUMN mix_table_id SERIAL UNIQUE;
ALTER TABLE mix_table ADD PRIMARY KEY(mix_table_id); 
ALTER TABLE mix_table ADD COLUMN galaxy_id INT REFERENCES galaxy(galaxy_id);
ALTER TABLE mix_table ADD COLUMN star_id INT REFERENCES star(star_id);
ALTER TABLE mix_table ADD COLUMN planet_id INT REFERENCES planet(planet_id);
ALTER TABLE mix_table ADD COLUMN pass_test INT;
ALTER TABLE mix_table ADD COLUMN pass_finally INT;

INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('1',1,1,8);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('2',1,2,4);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('3',1,3,5);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('4',1,3,9);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('5',1,3,11);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('6',1,4,1);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('7',1,5,3);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('8',1,4,2);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('9',1,4,12);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('10',1,5,6);
INSERT INTO mix_table(name,galaxy_id,star_id,planet_id) VALUES ('11',1,6,7);