-- MySQL's aggregate function is used to perform calculations on multiple values and return the result in a single value like 
-- the average of all values, the sum of all values, and maximum & minimum value among certain groups of values. We mostly use
-- the aggregate functions with SELECT ... GROUP BY statements. 
# syntax : function_name (DISTINCT | ALL expression)  -- by-default it is ALL if we donot specify anything

-- These are the types of aggregate functions we have :
-- count()	 -> It returns the number of rows, including rows with NULL values in a group.
-- sum()	 -> It returns the total summed values (Non-NULL) in a set.
-- average() -> It returns the average value of an expression.
-- min()	 -> It returns the minimum (lowest) value in a set.
-- max()	 -> It returns the maximum (highest) value in a set.
-- groutp_concat()	->It returns a concatenated string.
-- first()	 -> It returns the first value of an expression.
-- last()	 -> It returns the last value of an expression.

-- Lets see each of them one by one
 ## Count() Function ##
-- MySQL count() function returns the total number of values in the expression. It returns zero if it does not find any matching rows. It can work with both numeric and non-numeric data types.
select count(*) as no_of_rows from employee_data;
select count(distinct age) as unique_age_count from employee_data;
select count(age) as age_above_30 from employee_data where age > 30;

## Sum() Function ##
-- The MySQL sum() function returns the total summed (non-NULL) value of an expression. It returns NULL if the result set 
-- does not have any rows. It works with numeric data type only.
select sum(salary) as total_ctc from employee_data;
select sum(distinct age) from employee_data where age > 30;
 
## Avg() Function ##
-- MySQL AVG() function calculates the average of the values specified in the column. Similar to the SUM() function, it also works with numeric data type only.
select avg(age) as average_age from employee_data;
select department, avg(salary) as average_salary from employee_data group by department order by average_salary desc;

## MIN() and MAX() Function ##
-- MySQL MIN() function returns the minimum (lowest) value of the specified column. 
-- MySQL MAX() function returns the maximum (highest) value of the specified column.
-- They both work only on numeric datatypes only.

-- I am doing max(), you can do min()
 
select max(salary) as max_salary from employee_data;
-- Show the employee having max-salary
select first_name, last_name, department from employee_data where salary = (select max(salary) from employee_data);
-- Show the employee having second max salary   PS : I am sure its a girl :)   Just Kidding , we can check by query 
select first_name, last_name, department 
from employee_data where salary = (select max(salary) from employee_data where salary < (select max(salary) from employee_data));
-- Remember I said it would be a girl  :|


-- The same thing can be done using offset and count of LIMIT clause alongwith ORDER BY clause
select first_name, last_name, department from employee_data order by salary desc limit 0,1; 	-- (max_salary)
select first_name, last_name, department from employee_data order by salary desc limit 1,1; 	-- (second_max_salary)
-- Isn't this amazing !!

## FIRST() Function ##
-- This function returns the first value of the specified column. To get the first value of the column, we must have to use the LIMIT clause. 
-- It is because FIRST() function only supports in MS Access.
select first_name from employee_data limit 1;

## LAST() Function ##
-- This function returns the last value of the specified column. To get the last value of the column, we must have to use the ORDER BY and LIMIT clause.
-- It is because the LAST() function only supports in MS Access. Use the order by with primary key otherwise it sorts the column and return the row 
select first_name from employee_data order by employee_id desc limit 1;

## GROUP_CONCAT() Function ##
-- The GROUP_CONCAT() function returns the concatenated string from multiple rows into a single string. If the group contains
-- at least one non-null value, it always returns a string value. Otherwise, we will get a null value.
select active, group_concat(first_name) as empl_name from employee_data group by active;
select active, group_concat(concat(first_name , " ", last_name) separator " , ") as emp_name from employee_data group by active;
select department, group_concat(first_name separator " / ") as employees from employee_data group by department;
