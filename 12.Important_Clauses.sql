-- There are many important clauses that can be used to fetch data based on different scenarios,
-- we will look at some of those in action now. These are the following important clauses in MySQL : 

## WHERE clause ##
-- The WHERE clause works like an if condition in any programming language. This clause is used to compare 
-- the given value with the field value available in a MySQL table. If the given value from outside is equal 
-- to the available field value in the MySQL table, then it returns that row.
select * from employee_data where age > 40;

## LIMIT clause ##
-- The LIMIT clause in MySQL can be used to specify the number of records to return. This clause is mostly used
-- when dealing with tables that have thousands of records. It accepts one or two arguments (offset or count). 
-- The values of both arguments should be either be positive integers or zero.
-- The offset of the first row starts from 0, not from 1 and the count of the first row starts from 1. 
-- Syntax : select ....... limit [offset], count;		Lets look at example for better understanding
select * from employee_data limit 3; -- no-offset means offset = 0
select * from employee_data limit 1,3;	-- offset = 1

## DISTINCT clause ##
-- The DISTINCT clause in MySQL is used with a SELECT statement to return the distinct values (unique values) 
-- from a single or multiple of columns in a table. It ignores all the duplicates values present in the particular
-- column(s) and returns only the distinct values.
select distinct department from employee_data;
select distinct department, salary from employee_data;

## ORDER BY clause ##
-- The MySQL ORDER BY clause is used to sort one or more columns of a table in provided order that can be either 
-- ascending or descending order. By default, it sorts the column(s) in ascending order if the sort order is not specified.
-- The sort is specified with two keywords; ASC for ascending order and DESC for descending order.
-- Using the ORDER BY clause, we can sort multiple columns of a table and provide different sort orders for each 
-- column. For instance, we can sort the result set first by one column, and then by another column to the first 
-- column, and so on.
# syntax : SELECT column-list FROM table_name [ORDER BY column1, column2, ..., columnN] [ASC|DESC]
select * from employee_data order by salary desc;
select * from employee_data order by age, salary asc;

-- NOTE: we can use several pre-built functions too with the clauses like LENGTH(), COUNT(), etc. which we will see later on.

## GROUP BY clause ##
-- The GROUP BY clause in MySQL is used to arrange identical data in a table into groups. This GROUP BY clause
-- follows the WHERE clause in an SQL statement and precedes the ORDER BY or HAVING clause (if they exist). 
-- You can use GROUP BY to group values from a column, and, if you wish, perform calculations on that column. 
-- You can use COUNT, SUM, AVG, etc., functions on the grouped column as aggregate functions as required.
# syntax : SELECT col1...coln, [aggregate_function (expression)] FROM tables [WHERE conditions] GROUP BY expression1, expression2, ... expression_n;  
-- Lets see some actions of groupby
select  department, avg(salary) from employee_data group by department;		-- avg is an aggregated function which we will also see later on.
select department, count(*) as active_employee_count from employee_data where active = true group by department order by active_employee_count desc ;
select age, avg(salary) from employee_data group by salary, age;			-- group by using multiple columns

## HAVING clause ##
-- The MySQL HAVING Clause is used to filter grouped rows in a table based on conditions.
-- This clause is used with the GROUP BY clause to group the rows based on one or more columns and then filter 
-- them based on the conditions specified in the HAVING clause. So, the HAVING clause must always be followed by
-- the GROUP BY clause.
-- The HAVING clause was added to MySQL because the WHERE keyword cannot be used with aggregate functions such
-- as COUNT(), SUM(), AVG(), etc.
-- This clause is similar to the MySQL WHERE clause. The difference between both of them is that the WHERE clause
-- filters individual rows in a table, whereas the HAVING clause filters grouped rows based on conditions.
# syntax : SELECT expression1, expression2, ... expression_n, aggregate_function (expression) FROM tables [WHERE conditions] GROUP BY expression1, expression2, ... expression_n HAVING condition;  

-- Lets try to write having without group by
select * from employee_data having age > 30;  -- acts as normal WHERE clause
select department from employee_data where max(salary) > 70000 group by department;   -- error [where cannot be used as filtering clause in case of group by statement]
select department from employee_data group by department having max(salary) > 70000 ;   -- having if perfect match for group by statements for filtering
-- So why the error happens with where and and not having as both are filtering clauses ?
-- We will see this in the next section while studying order of execution of the clauses 

-- Lets write a crazy statement ....
select department, max(age) as maximum_age_active_employee
from employee_data
where active = True
group by department
having max(age) > 30 
order by max(age) desc
limit 2;

-- Its too COMPLEX ....