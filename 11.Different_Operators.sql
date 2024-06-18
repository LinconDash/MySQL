# Before going to other clauses in sql , lets see the types and working of operators
-- First create a table and then add some data for using operators in it 
/* 
Different Operators are : 
Arithmetic Operators : +, -, *, %, /
Comparision Operators : =, <> or !=, >=, <=, >, <
Logical Operators : AND, OR, NOT
Special Operators : ALL, ANY, BETWEEN, IN, IS, EXISTS, SOME, LIKE, etc.
There are bitwise and compound operators also in SQL.
*/

-- Lets see each of them one by one
CREATE TABLE employee_data (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2),
    hire_date DATE,
    department VARCHAR(50),
    active BOOLEAN
);

INSERT INTO employee_data (first_name, last_name, age, salary, hire_date, department, active) VALUES
('John', 'Doe', 28, 60000.00, '2020-01-15', 'Engineering', TRUE),
('Jane', 'Smith', 34, 75000.50, '2018-03-22', 'Finance', TRUE),
('Robert', 'Brown', 45, 50000.75, '2015-11-30', 'Human Resources', FALSE),
('Emily', 'Davis', 30, 82000.00, '2019-07-19', 'Engineering', TRUE),
('Michael', 'Johnson', 50, 92000.00, '2010-05-10', 'Management', TRUE),
('Sarah', 'Miller', 26, 48000.25, '2021-09-01', 'Marketing', TRUE);

# We will see every operator in action using the select command 
select * from employee_data;								-- Fetch all columns from the table 
select first_name, last_name, salary from employee_data;	-- Fetch specific columns from the table 
-- Comparision Operator
select first_name from employee_data where salary > 70000;  
select first_name, last_name from employee_data where active = True;
select first_name, last_name from employee_data where department = "Engineering";
select first_name, last_name from employee_data where department <> "Engineering";
-- Arithmetic operator 
select first_name, (salary * 2) as double_salary from employee_data; 	
select (5 + 2) as sum;										
-- Logical operators
select * from employee_data where department = "Engineering" or department = "Marketing";	
select * from employee_data where salary > 50000 and age < 30;
select * from employee_data where (salary > 60000 and active = TRUE) or age > 30;
select * from employee_data where age > 25 and age < 40;
-- Special operators
select * from employee_data where salary between 50000 and 80000;
SELECT * FROM employee_data WHERE first_name LIKE 'J%';
select distinct department from employee_data;
select * from employee_data where department in ("Engineering", "Finance");
-- top 2 salary holders of the company !! 
-- (order by in a clause used for sorting based on a specific column we will see it later also)
select * from employee_data order by salary desc limit 2;  
select * from employee_data where active is not True;
select * from employee_data where active is True;
select * from employee_data where salary is null;
select * from employee_data where salary is not null;

-- Some special operators like ANY, ALL, EXISTS requires subqueries which we will see later in details.
# syntax of ANY : SELECT column_name1, column_name2, ... FROM table_name WHERE column_name operator ANY (subquery);
 -- lets see whose salary is greater than the salary of Emily Davis
select * from employee_data 
where salary > any (
select salary from employee_data where first_name = "Emily" and last_name = "Davis"  -- This is a subquery (query inside a query)
); 
-- Similarly we can use all operator also.
select * from employee_data 
where salary > all (
select salary from employee_data where age < 30  
); 
-- SOME operator is also the same as ANY operator and can be used interchangeably
select * from employee_data 
where salary > some (
select salary from employee_data where first_name = "Emily" and last_name = "Davis"  -- This is a subquery (query inside a query)
); 

-- The EXISTS operator in MySQL checks for the existence of a record in a table. It's used in the WHERE clause of a SELECT statement 
-- to verify if a subquery returns any rows. It returns TRUE if the subquery returns at least one record, else false. We can also use NOT EXISTS
select * from employee_data where exists (select * from employee_data where first_name = "John" and age > 30);
select * from employee_data where not exists (select * from employee_data where first_name = "John" and age > 30);		-- The opposite of previous statement

-- UNION and UNION ALL operator
-- The UNION operator in MySQL combines the data (without duplicate records) from multiple tables.
-- We can use UNION if we want to select rows one after the other from several tables or several sets of rows from a single table all as a single result set.
-- To use the UNION operator on multiple tables, all these tables must be union compatible. And they are said to be union compatible if and only if they meet the following criteria −
-- 1. The same number of columns selected with the same datatype.
-- 2. These columns must also be in the same order.
-- 3. They may or may not have same number of rows.
-- We can use various clauses like order by, where, etc. after union of 2 tables

-- Lets create another table for managers_data
CREATE TABLE manager_data (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    salary DECIMAL(10, 2),
    department VARCHAR(50)
);

INSERT INTO manager_data (first_name, last_name, age, salary, department) VALUES
('Alice', 'Johnson', 45, 95000.00, 'Engineering'),
('Bob', 'Smith', 50, 105000.50, 'Engineering'),
('Carol', 'Williams', 39, 87000.75, 'Marketing'),
('David', 'Brown', 52, 110000.00, 'Finance'),
('Eva', 'Davis', 43, 98000.25, 'Human Resources');

-- Union within the same table with conditions
select first_name, last_name, department from employee_data where department = "Engineering"
union 
select first_name, last_name, department from employee_data where department = "Finance";

-- Union of 2 tables without condition
select first_name, last_name, department from employee_data
union 
select first_name, last_name, department from manager_data;
-- You can  do the same using JOINS but we will see them later on

-- Union of 2 tables with conditions
select first_name, last_name, department from employee_data where department = "Engineering"
union 
select first_name, last_name, department from manager_data where department = "Marketing";

-- We can use UNION ALL as well but there is a different that UNION . The only difference between these two operators is that UNION only returns distinct rows while 
-- UNION ALL returns all the rows present in both tables.
select first_name, last_name, department from employee_data where department = "Engineering"
union all
select first_name, last_name, department from manager_data where department = "Marketing";    -- No difference in outputs as no rows are same in both tables

-- INTERSECT operator. In mathematical set theory, the intersection of two sets is a set that contains only those elements that are common to both sets. 
-- In other words, the intersection of two tables is a set of records or rows that exist in both sets.
-- However, the INTERSECT operator works only if both the SELECT statements have an equal number of columns with same data types and names.
-- We cannot use intersect in MySQL so we can use INNER JOIN for this 
-- Similarly MINUS operator is also not present in MySQL and for that we have technique to use LEFT JOIN likewise

-- The INTERVAL operator in MySQL is used to create an interval between two different events or times. This interval can be in seconds, minutes, hours, days, etc. 
-- Thus, MySQL mainly uses this operator to perform date and time calculations, such as adding or subtracting a specified time interval from date and time values.
-- INTERVAL operator is used with various date and time functions, and helps in real-time scenarios for calculating the deadlines, scheduling events, etc.
# syntax : INTERVAL expression unit
-- units like : DAY, HOUR, MICROSECOND, MONTH, MINUTE, QUARTER, SECOND, WEEK, YEAR , DAY_HOUR, DAY_MINUTE, etc.

SELECT '2024-05-30' + INTERVAL 5 DAY;
SELECT '2024-05-30' - INTERVAL 5 DAY;

-- we can use several date-time functions with them also
SELECT DATE_ADD('2023-04-14', INTERVAL 1 MONTH) ADD_ONE_MONTH, DATE_SUB('2023-04-14',INTERVAL 1 MONTH) SUB_ONE_MONTH;
SELECT TIMESTAMPADD (HOUR, 2, '2020-01-01 03:30:43.000') 2_HOURS_LATER;