# A table is used to organize data in the form of rows and columns and used for both storing and displaying records in the structure format. 
# It is similar to worksheets in the spreadsheet application . SQL CREATE TABLE Statement is used to create a new table in a database. 
# Users can define the table structure by specifying the column’s name and data type in the CREATE TABLE command.
# This statement also allows to create table with constraints, that define the rules for the table. Users can create tables in SQL and insert data at the time of table creation.

## CREATE A NEW TABLE ##
-- You can create a table with the CREATE TABLE command and it requires 3 things : table_name, coumn_definition, constarints with the following syntax :
-- CREATE TABLE table_name ( column_name1 datatype(size) constraint, column_name2 datatype(size) constraint, ...., column_nameN datatype(size) constraint, table_constraints ;
-- Remember to make a table name unique otherwise use IF NOT EXISTS to avoid error and there are many constriants but we will discuss them later.

-- query to create a simple table name stiudents inside a practice database withot any constraints
SHOW databases;
CREATE DATABASE IF NOT EXISTS practice;
USE practice;

CREATE TABLE students 
(
	ID INT,
    NAME VARCHAR(20)
);

-- Eaxmple query to create a table customers with some constraint
CREATE TABLE IF NOT EXISTS customers
(
	CustomerID INT AUTO_INCREMENT,
    CustomerName VARCHAR(50) NOT NULL,
    Country VARCHAR(20) NOT NULL,
    Age INT CHECK (Age >= 0 and Age <= 99),
    Phone INT UNIQUE,
    -- Table constraints 
    PRIMARY KEY (CustomerID)
);

-- query to insert data to the table and view data, but we will see it in details later
INSERT INTO customers(CustomerName, Country, Age, Phone) VALUES("Lincon", "India", 22, 1234567890);
INSERT INTO customers(CustomerName, Country, Age, Phone) VALUES("Dibya", "India", 50, 0121389111);
select * from customers;

## Show the tables ##
-- query to see all the tables in a current database
show tables;
show table status;

-- query to see all tables in existing database
show tables in sakila;

-- query to see the info. about base table or view in current database
show full tables in sakila;

-- query to see the tables following a pattern usiung LIKE or WHERE clauses
show tables like "c%";

## DESCRIBE THE TABLES ##
-- DESCRIBE means to show the information in detail. Since we have tables in MySQL, so we will use the DESCRIBE command to 
-- show the structure of our table, such as column names, constraints on column names, etc. 

-- query to describe the table in current database
desc customers;
describe customers;

-- query to describe the table in a particular database using the syntax desc db_name.table_name;
desc sakila.actor;

-- query to get some info. about the table structure like desc is by using the show columns command
show columns from sakila.actor;
show full columns from sakila.actor;

-- explain command to see the details of an operation
explain select * from sakila.actor;

## DROPPING AN EXISTING TABLE ##
-- This statement removes the complete data of a table along with the whole structure or definition permanently from the database. 
-- So, you must be very careful while removing the table because we cannot recover the lost data after deleting it.
-- We have to create a table and its entire structure from scratch if its dropped permanently.
drop table if exists students;

-- The full synatx of drop table is drop [temporary] table [if exists] db.table [restrict | cascade]

## TRUNCATE THE TABLE ##
-- Generally, we use this command when we want to delete an entire data from a table without removing the table structure.
-- You can also use the DROP TABLE command to delete the complete table, but it will remove complete table data and structure both.
-- You need to re-create the table again if you have to store some data. But in the case of TRUNCATE TABLE,
-- it removes only table data, not structure. You don't need to re-create the table again because the table structure already exists.
truncate customers;
select * from customers;

## ALTER THE STRUCTURE OF TABLE ##
-- MySQL ALTER statement is used when you want to change the name of your table or any table field. 
-- It is also used to add or delete an existing column in a table.
-- The ALTER statement is always used with "ADD", "DROP" and "MODIFY" commands according to the situation.

-- query to add a new column in the table
alter table customers add Hobby varchar(100), add Gender varchar(1) check(Gender= "M" or Gender="F");
select * from customers;

-- query to modify the column in a table
alter table customers modify Hobby varchar(50);
desc customers;

-- query to drop a column in a table
alter table customers drop column Hobby;
select * from customers;

-- query to rename a column in the table
alter table customers change column CustomerID CustomerId int auto_increment;
select * from customers;

-- query to rename a table
alter table customers rename to customers_table;
select * from customers_table;

    