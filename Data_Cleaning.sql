create database if  not exists Pizzas;
Create database if not exists Movies;

-- Create superstore table																		
Create table movies.superstore
(RowID INT,
 OrderID VARCHAR(250),
 OrderDate VARCHAR(250),
 ShipDate VARCHAR(250),
 ShipMode VARCHAR(250),
 CustomerID VARCHAR(250),
 CustomerName VARCHAR(250),
 Segment VARCHAR(250),
 Country_Region VARCHAR(250),
 City VARCHAR(250),
 State VARCHAR(250),
 PostalCode VARCHAR(250),
 Region VARCHAR(250),
 ProductID VARCHAR(250),
 Category VARCHAR(250),
 SubCategory VARCHAR(250),
 ProductName VARCHAR(250),
 Sales DOUBLE,
 Quantity DOUBLE,
 Discount DOUBLE,
 Profit DOUBLE );

-- Load the Superstore data through the data infile method	
LOAD DATA INFILE '\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Superstore.csv'
INTO TABLE movies.superstore
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
 
 -- Rename columns in the pizzas databases
ALTER TABLE customer_orders RENAME COLUMN ï»¿order_id TO order_id;
ALTER TABLE pizza_names RENAME COLUMN ï»¿pizza_id TO pizza_id;
ALTER TABLE pizza_recipe RENAME COLUMN ï»¿pizza_id TO pizza_id;
ALTER TABLE pizza_toppings RENAME COLUMN ï»¿topping_id TO topping_id;
ALTER TABLE pizza_toppings RENAME COLUMN ï»¿topping_id TO topping_id;
ALTER TABLE runners RENAME COLUMN ï»¿runner_id TO runner_id;

-- Convert columns to appropriate data types (Pizza Database)
SELECT * FROM customer_orders;
UPDATE pizzas.customer_orders SET order_time = REPLACE(order_time, '/', '-');
UPDATE pizzas.customer_orders SET order_time = STR_TO_DATE(order_time, '%d-%m-%Y %H:%i');
ALTER TABLE customer_orders MODIFY order_time DATETIME;

-- runner_orders table
-- Replace the empty rows in the pickup_time column with nulls
SELECT * FROM runner_orders
WHERE pickup_time = '';
UPDATE pizzas.runner_orders SET pickup_time = REPLACE (pickup_time, '', null)
WHERE pickup_time = '';

-- Change the data type of the pickup_time column to date
UPDATE pizzas.runner_orders SET pickup_time = REPLACE (pickup_time, '/', '-');
UPDATE pizzas.runner_orders SET pickup_time = STR_TO_DATE (pickup_time, '%d-%m-%Y %H:%i');
ALTER TABLE runner_orders MODIFY pickup_time DATETIME NULL;
ALTER TABLE runner_orders MODIFY cancellation VARCHAR(100);

-- Replace the empty rows in the distance column with null
UPDATE pizzas.runner_orders SET distance = REPLACE (distance, '', null)
WHERE distance = '';
-- Change the distance data type to Double
ALTER TABLE runner_orders MODIFY distance DOUBLE NULL;
-- Replace the empty rows in the duration column with null
UPDATE pizzas.runner_orders SET duration = REPLACE (duration, '', null)
WHERE duration = '';
-- Change the duration data type to Integer
ALTER TABLE runner_orders MODIFY duration INT NULL;

-- runners table
-- Change the registration date column to Date data type
SELECT * FROM runners;
UPDATE runners SET registration_date = REPLACE(registration_date, '/', '-');
UPDATE runners SET registration_date = STR_TO_DATE(registration_date, '%d-%m-%Y');
ALTER TABLE runners MODIFY registration_date DATE;

-- Rename columns in the movies database
SELECT * FROM movie_data;
SELECT * FROM people;
ALTER TABLE people RENAME COLUMN ï»¿Person TO Person;
SELECT * FROM returns;
ALTER TABLE returns RENAME COLUMN ï»¿Returned TO Returned;

-- Superstore table
-- Change the data type of the orderdate and shipdate columns to Date 
SELECT * FROM superstore;
UPDATE superstore SET orderdate = REPLACE(orderdate, '/', '-');
UPDATE superstore SET orderdate = STR_TO_DATE(orderdate, '%d-%m-%Y');
UPDATE superstore SET shipdate = REPLACE(shipdate, '/', '-');
UPDATE superstore SET shipdate = STR_TO_DATE(shipdate, '%d-%m-%Y');
ALTER TABLE superstore MODIFY OrderDate DATE;
ALTER TABLE superstore MODIFY ShipDate DATE;

-- Movie Table
SELECT * FROM movie_data
WHERE release_date is null; -- 4 rows are empty
UPDATE movie_data SET release_date = REPLACE(release_date, '', null)
WHERE release_date = '';
-- Replace some wrong date format in release_date column
UPDATE movie_data SET release_date = REPLACE(release_date, '/', '-');
SELECT * FROM movie_data
WHERE LEFT(release_date,4)  BETWEEN 1500 AND 1899 ; -- 5 rows;
UPDATE movie_data SET release_date = REPLACE(release_date, '1898-01-01', '01-01-1898'); -- 2 rows
UPDATE movie_data SET release_date = REPLACE(release_date, '1899-01-01', '01-01-1899'); -- 2 rows
UPDATE movie_data SET release_date = REPLACE(release_date, '1895-12-28', '28-12-1895'); -- 1 row
UPDATE movie_data SET release_date = STR_TO_DATE(release_date, '%d-%m-%Y');
ALTER TABLE movie_data MODIFY release_date DATE NULL;

-- Marketing table
SELECT * FROM marketingdata;
ALTER TABLE marketingdata RENAME COLUMN ï»¿age TO age;

-- Bonus table
SELECT * FROM bonus_table;
ALTER TABLE bonus_table RENAME COLUMN ï»¿Id TO Id;

-- Shareprice Table
SELECT * FROM shareprice;
ALTER TABLE shareprice RENAME COLUMN ï»¿date TO date;
ALTER TABLE shareprice MODIFY date DATE;

-- Employee Table
SELECT * FROM employee_table;
-- Rename the employee_id column
ALTER TABLE employee_table RENAME COLUMN ï»¿employee_id TO employee_id;
-- change the date_of_birth data type to Date
ALTER TABLE employee_table MODIFY date_of_birth DATE;
-- change the hire_date data type to Date
ALTER TABLE employee_table MODIFY hire_date DATE;
