-- This is a one-liner comment  
# This is one-liner comment too 
/*
This is a multiliner comment.
Helpful in describing statements
*/

## DDL stands for Data Definition Lnaguage and has the following comnands namely :- CREATE, DROP, ALTER (ADD, MODIFY, RENAME, DROP), TRUNCATE . 
## Since we already have seen this while creating the tables , we will move to DML directly 
## DML stands for Data Manipulation Language which has the following commands under it :-  INSERT, UPDATE, DELETE, MERGE, INSERT IGNORE, INSERT .. ON DUPLCATE KEY, INSERT INTO SELECT

## INSERT STATEMENT ##
-- MySQL INSERT statement is used to store or add data in MySQL table within the database. 
-- We can perform insertion of records in two ways using a single query in MySQL:
-- 1. Insert record in a single row
-- 2. Insert record in multiple rows

-- Syntax of the insert command is as follows :
-- insert into table_name(col1, col2, col3, ..) values(val1, val2, val3, ..), (val1, val2, val3, ..), ..;
-- Note: the col names are optional to use but its better to use , we can also do insert into table_name values(val1, val2, val3, ..), (val1, val2, val3, ..), ..;
-- Without using the col names tuple , we have to give the input for all the cols rather than those that are mentioned if we donot use col names. 

select * from students;

-- 1. insert 1 row at a time
insert into students(Student_Name, Student_grade, Student_age) values("Tim", "B", 20);
insert into students(Student_Name, Student_grade, Student_age) values("Rim", "A", 19);
insert into students(Student_Name, Student_grade) values("Jim", "C"); -- there will be a NULL in the Student_age col
insert into students values (11, "Jerry", "C", 19);					 -- if not specifying col names then provide the data for each col
insert into students values (12, "Halan", "A", null);					-- specify null if you donot have anything to enter the data

-- 2. insert multiple row at a time
insert into students(Student_Name, Student_grade, Student_age) values 
("John", "A", 19),
("Emily", "E", 18),
("Clark", "E", 19);

-- NOTES :
-- There is a special way to insert DATE,DATETIME, etc in date specific columns which we will discuss later on .
-- insert is used with many other statements such as : 
-- INSERT AND SET : INSERT INTO table_name SET column_name1 = value1, column_name2=value2s...;
-- INSERT AND SELEECT : INSERT INTO table_to (column1, column2,....) SELECT Column1, column2 ..... FROM Table_from WHERE condition
-- INSERT AND TABLE : INSERT INTO table1 TABLE table2;
-- and many more are there ...


## UPDATE STATEMENT ##
-- MySQL UPDATE query is a DML statement used to modify the data of the MySQL table within the database. 
-- In a real-life scenario, records are changed over a period of time. So, we need to make changes in the values of the tables also. 
-- The UPDATE statement is used with the SET and WHERE clauses. The SET clause is used to change the values of the specified column.
-- And the WHERE clause is used to query over a particular portion of a table using condition. Note that if where is not specified then 
-- it will update the entire column and not a single record.
-- We can update single or multiple columns at a time.

-- syntax of using the update statement is 
-- UPDATE table_name SET column_name1 = new-value1,column_name2=new-value2, ... [WHERE Clause];

select * from students;
-- query to update the grades of shyam and gopal to E
update students
set Student_grade = "E"
where Id = 2 or Id = 3;

-- query to update the grade and age of id=15
update students
set Student_grade = "A", Student_age = 20
where Id=15;

-- query to update and replace string columns (same as first query just a variant)
update students
set Student_grade = replace(Student_grade, "E", "A")
where Id = 2 or Id = 3;

-- NOTE : we can use various clauses like IGNORE, LIMIT, etc. while using update statement, we will see them later in details 
-- The UPDATE command supports these modifiers in MySQL:
-- LOW_PRIORITY: This modifier instructs the statement to delay the UPDATE command's execution until no other clients reading from the table. It takes effects only for the storage engines that use only table-level locking.
-- IGNORE: This modifier allows the statement to do not abort the execution even if errors occurred. If it finds duplicate-key conflicts, the rows are not updated.
-- LIMIT: Only updates limited no. of rows as specified in the number

## DELETE STATEMENT ##
-- This query in MySQL deletes a full row from the table and produces the count of deleted rows. 
-- It also allows us to delete more than one record from the table within a single query, which is beneficial 
-- while removing large numbers of records from a table. By using the delete statement, we can also remove data based on conditions.
-- Once we delete the records using this query, we cannot recover it.  

-- syntax : DELETE FROM table_name WHERE condition;  
delete from students where Id = 15;
select * from students;

-- NOTE : other clauses can also be used in the delete statement such as order by and limit clause, joins , etc.
-- Without where clause delete statement will delete all records of the table 
-- Multitable delete can be done from joins using inner, outer , etc.

## MERGE STATEMENT ## (NOT FOR BEGINNERS) 
-- SQL MERGE Statement combines INSERT, DELETE, and UPDATE statements into one single query.
-- MERGE statement in SQL is used to perform insert, update, and delete operations on a target table based on the results of JOIN with a source table. 
-- The MERGE statement compares data between a source table and a target table based on specified key fields.
-- It performs appropriate actions like inserting new records, updating existing ones, and deleting or flagging records no longer present in the source.

-- syntax : 
-- MERGE INTO target_table
-- USING source_table
-- ON merge_condition
-- WHEN MATCHED THEN
--    UPDATE SET column1 = value1 [, column2 = value2 …]
-- WHEN NOT MATCHED THEN
--    INSERT (column1 [, column2 …])
--    VALUES (value1 [, value2 …]);

# CASE STUDY for undersatnding the MERGE STATEMENT clearly: 
-- Lets say we have 2 tables which are product list and updated list of the products , we will merge
-- both the tables since both have the same schema but may have both same and different data using the merge statement 

# First lets create the product_list table and insert some values to it.
create table product_list
(
	p_id int,
    p_name varchar(20),
    p_price float
);
insert into product_list values (101, "TEA", 10.00), (102, "COFFEE", 15.00), (103, "BISCUIT", 20.00);
create table updated_list
(
	p_id int,
    p_name varchar(20),
    p_price float
);
insert into updated_list values (101, "TEA", 10.00), (102, "COFFEE", 25.00), (104, "CHIPS", 22.00);

-- see the date of both tables
select * from product_list;
select * from updated_list;

-- Now merge them using the MERGE statement in such a way that price gets updated and if p_name not present then insert into it in the products_list.
# DONOT RUN THIS QUERY AS MERGE IS NOT SUPPORTED IN MYSQL #
/* 
merge product_list as target 
	using updated_list as source
	on (target.p_id = source.p_id)
    
	when matched 
		and target.p_name <> source.p_name
        or target.p_price <> source.p_price 
	then update
		set target.p_name = source.p_name,
        target.p_price = source.p_price
	
    when not matched by target
		then insert (p_id, p_name, p_price) 
        values (source.p_id, source.p_name, source.p_price)
*/

-- NOTE : Unfortunately we donot have merge statement supported in the MYSQL , but we have 2 more options here:
-- 1. REPLACE statement 
-- 2. INSERT ... ON DUPLICATE KEY UPDATE 

## REPLACE STATEMENT (DELETE + INSERT) ##
-- This statement is required when we want to update the existing records into the table to keep them updated. 
-- If we use the standard insert query for this purpose, it will give a Duplicate entry for PRIMARY KEY or a UNIQUE key error. 
-- In this case, we will use the REPLACE statement to perform our task. 
-- The REPLACE command requires one of the two possible actions take place: 
-- 1. If no matching value is found with the existing data row, then a standard INSERT statement is performed.
-- 2. If the duplicate record found, the replace command will delete the existing row and then inserts the new record in the table.
--  we can say that the REPLACE statement performs two standard functions, DELETE and INSERT.

-- syntax : REPLACE [INTO] table_name(column_list) VALUES(value_list);  
REPLACE INTO students(Id, Student_Name,Student_grade,Student_age) VALUES(10, "Jim", "C", 19), (12, "Halan", "A", 19);
select * from students;

-- If we had used default constraint in table creation then we didn't have to provide all columns details 
-- Replace with set
replace into students set Id = 1, Student_Name = "Rama", Student_grade = "A", Student_age = 19;
select * from students;

-- replace with select query : REPLACE INTO table1(column_list) SELECT column_list FROM table2 WHERE condition; (can be used as merge statement )

## INSERT IGNORE ##
-- In MySQL, the INSERT INTO statement can be used to insert one or more records into a table.
-- In some scenarios, if a particular column has a UNIQUE constraint and if we are trying to add duplicates records into 
-- that particular column using the INSERT INTO statement, MySQL will terminate the statement and returns an error. 
-- As the result, no rows are inserted into the table.

-- These are the scenario where using INSERT IGNORE avoids the errors :
-- 1. When we insert a duplicate value in the column of a table that has UNIQUE key or PRIMARY key constraints.
-- 2. When we try to add NULL values to a column where it has NOT NULL constraint on it.

CREATE TABLE CUSTOMERS (
   ID int NOT NULL,
   NAME varchar(20) NOT NULL UNIQUE,
   PRIMARY KEY (ID)
);
INSERT INTO CUSTOMERS (ID, NAME) VALUES (1, "Ajay"), (2, "Vinay"), (3, "Arjun");

INSERT INTO CUSTOMERS (ID, NAME) VALUES (2, "Arjun"); -- This will give us error and donot change data on table
INSERT IGNORE INTO CUSTOMERS (ID, NAME) VALUES (2, "Arjun"); -- This will only give us warnings and donot change data on table
select * from customers;

## INSERT .. ON DUPLCATE KEY UPDATE ##
-- When we are trying to insert a new row into a MySQL table column with a UNIQUE INDEX or PRIMARY KEY, MySQL will issue an 
-- error, if the value being inserted already exists in the column. This will happen because these constraints require unique values,
-- and duplicate values are not allowed.
-- However, if we use the MySQL ON DUPLICATE KEY UPDATE clause with the INSERT INTO statement, MySQL will update the 
-- existing rows with the new values instead of showing an error.

-- syntax : INSERT INTO my_table (col1, col2, ...) VALUES (val1, val2), (val3, val4), ...ON DUPLICATE KEY UPDATE <col1>=<val1>, <col2>=<val2>,...;

INSERT INTO CUSTOMERS (ID, NAME) VALUES (2, "Ganesh") ON DUPLICATE KEY UPDATE NAME = "Ganesh";
select * from customers;
INSERT INTO CUSTOMERS (ID, NAME) VALUES (4, "Chatur") ON DUPLICATE KEY UPDATE NAME = "Chatur";

## INSERT INTO SELECT ##
-- Sometimes we want to insert data of one table into the other table in the same or different database. 
-- It is not very easy to enter these data using the INSERT query manually. We can optimize this process with the use of MySQL INSERT INTO SELECT query.
-- We must consider the following point before using this statement:
-- 1. The data types in source and target tables must be the same.
-- 2. The existing records in the target table should be unaffected.

-- syntax : INSERT INTO table_name2(column_list) SELECT column_list FROM table_name1 WHERE condition;  

-- query to insert data into a newly created table from the table students
create table students_and_grades
(
	Student_Name varchar(200),
    Student_grade varchar(1)
);
-- insert into select usage
INSERT INTO students_and_grades 
select Student_Name, Student_grade 
from students;

-- see the results
select * from students_and_grades;