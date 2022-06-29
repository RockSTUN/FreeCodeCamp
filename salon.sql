/*
TRUNCATE TABLE customers,appointments,services;
DROP TABLE customers,appointments,services;
\c postgres
DROP DATABASE salon;*/


CREATE DATABASE salon;
\c salon;
-- CUSTOMERS
CREATE TABLE customers();
ALTER TABLE customers ADD COLUMN customer_id SERIAL PRIMARY KEY;
ALTER TABLE customers ADD COLUMN phone VARCHAR(30) UNIQUE;
ALTER TABLE customers ADD COLUMN name VARCHAR(30);

--\d customers;

-- SERVICES
CREATE TABLE services();
ALTER TABLE services ADD COLUMN service_id SERIAL PRIMARY KEY;
ALTER TABLE services ADD COLUMN name VARCHAR(30);
INSERT INTO services(name) VALUES ('cut'),('color'),('perm'),('style'),('trim');

--\d services;

-- APPOINTMENTS
CREATE TABLE appointments();
ALTER TABLE appointments ADD COLUMN appointment_id SERIAL PRIMARY KEY;
ALTER TABLE appointments ADD COLUMN customer_id INT, ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);
ALTER TABLE appointments ADD COLUMN service_id INT, ADD FOREIGN KEY (service_id) REFERENCES services(service_id);
ALTER TABLE appointments ADD COLUMN time VARCHAR(30);






