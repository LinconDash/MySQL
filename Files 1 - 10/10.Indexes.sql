-- An index is a data structure that allows us to add indexes in the existing table.
-- It enables you to improve the faster retrieval of records on a database table.
-- It creates an entry for each value of the indexed columns. 
-- We use it to quickly find the record without searching each row in a database table whenever the table is accessed.
-- We can create an index by using one or more columns of the table for efficient access to the records.

## Why we need indexing ? ##
-- Suppose we have a contact book that contains names and mobile numbers of millions of users.
-- In this contact book, we want to find the mobile number of Lincon Dash. 
-- If the contact book is an unordered format means the name of the contact book is not sorted alphabetically, 
-- we need to go over all pages and read every name until we will not find the desired name that we are looking for. 
-- This type of searching name is known as sequential searching.
-- We will generally use this query below:
-- SELECT mobile_number FROM contactbooks WHERE first_name = 'Lincon' AND last_name = 'Dash';  

-- This query is very simple and easy but it is much slower than you think. The database searches entire rows of 
-- the table until it will not find the rows that you want. Since, the contactbooks table contains millions of rows,
-- then, without an index, the data retrieval takes a lot of time to find the result. 
-- In that case, the database indexing plays an important role in returning the desired result and improves the overall performance of the query.

-- Answer : Speeds up the query retrivals and also query processing 

-- Lets look at all the important concepts of INDEXES

## CREATE AN INDEX ##
-- We can create indexes on a MySQL table in two scenarios: while creating a new table and on an existing table. 
-- 1. creating index on a new table 
CREATE TABLE CUSTOMERS (
   ID INT NOT NULL PRIMARY KEY,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2),       
   INDEX(NAME) -- we may also specify name here
);

-- 2. creating index on an existing table 
CREATE INDEX age_index ON CUSTOMERS(AGE);
-- USING ALTER TABLE COMMAND WE CAN ADD INDEX TOO
ALTER TABLE CUSTOMERS ADD INDEX age_and_salary (AGE, SALARY);
DESC CUSTOMERS;

## DROP AN INDEX ##
-- If we want to delete an index, it requires two things:
-- First, we have to specify the name of the index that we want to remove.
-- Second, name of the table from which your index belongs.

DROP INDEX age_and_salary ON CUSTOMERS;
ALTER TABLE CUSTOMERS DROP INDEX NAME;   -- it will delete the name index and not column

-- In some cases, the table contains a PRIMARY index that was created whenever you create a table with a primary key or unique key. 
-- In that case, we need to execute the following command because the PRIMARY is a reserved word.
ALTER TABLE CUSTOMERS DROP PRIMARY KEY;

## SHOW THE INDEXES ON A TABLE ##
-- It is noted that Index and Keys both are synonyms of Indexes, and IN is the synonyms of FROM keyword.
-- Therefore, we can also write the Show Indexes statement with these synonyms as below
-- SHOW INDEXES IN table_name [FROM database_name];  
-- SHOW KEYS FROM table_name [IN database_name];  

SHOW INDEXES IN CUSTOMERS;
SHOW KEYS IN CUSTOMERS;

## UNIQUE INDEX ##
-- Generally, we use the primary key constraint to enforce the uniqueness value of one or more columns. But, we can use only one primary key for each table.
-- MySQL allows another constraint called the UNIQUE INDEX to enforce the uniqueness of values in one or more columns.
-- We can create more than one UNIQUE index in a single table, which is not possible with the primary key constraint.

-- creating a unique index in a new table
CREATE TABLE Employee_Detail(    
    ID int AUTO_INCREMENT PRIMARY KEY,     
    Name varchar(45),     
    Email varchar(45),    
    Phone varchar(15),     
    City varchar(25),  
    UNIQUE KEY unique_email (Email)  
);  

-- creating a unique index in an existing table
CREATE UNIQUE INDEX unique_phone ON Employee_Detail(Phone);


## TYPES OF INDEXES ##

## CLUSTERED INDEX ##
-- MySQL database does not have separate provisions for Clustered indexes. They are automatically created when PRIMARY KEY is defined on a table.
-- And when the PRIMARY KEY is not defined, the first UNIQUE NOT NULL key is treated as a Clustered index.
-- If a table has no Primary Key or UNIQUE index, MySQL will internally create a hidden clustered index named GEN_CLUST_INDEX on a column that contains the row ID values.

## NON-CLUSTERED INDEX ##
-- Non-Clustered indexes store data in one location and its indexes in another location. These indexes contain pointers to the actual data.
-- However, MySQL does not provide ways to explicitly create clustered and non-clustered indexes.
-- A PRIMARY KEY is treated as a clustered index. And when the PRIMARY KEY is not defined, the first UNIQUE NOT NULL key is a clustered index.
-- All the other indexes on a table are non-clustered indexes.

## SUB-TYPES OF INDEXES ##
-- Simple Index
-- Unique Index
-- Primary Key Index  (Only Clustered rest are Non-clustered)
-- Fulltext Index
-- Descending Index

# NOTE : Indexes are generally used for query optimizations and are generally treated as an advanced level concept in SQL , so we will see it later in advanced level also.