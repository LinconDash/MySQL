## Aggregated window functions ##
-- We already know what all these aggregated functions do so we will only see some quetions based on aggregated window functions 

-- Calculate the running total of the employees salary for each department.
select *, 
sum(salary) over(partition by department order by salary) as running_total
from employees;

-- Other runnings 
select *, 
sum(salary) over(partition by department order by salary) as running_total,
avg(salary) over(partition by department order by salary) as running_average,
count(*) over(partition by department order by salary) as running_count  
from employees; 

# I think this is it for the aggregated window functions , next we will see value-window functions
# We will see them later while understanding the importance of specifying a frame definition

## Value window functions ##
-- Value window functions are used to retrieve specific values from a set of rows defined by a window 
-- These are the types of value window functions we have in MySQL :
-- LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE(), NTH_VALUE(expression, offset)

-- 1. LAG() : Provides access to a row at a specified physical offset that comes before the current row.
-- syntax : LAG(expression, offset, [default_value_for_null])   # default offset is 1

-- Fetch the salary of each employee's previous employee salary without any department patition
select *, 
lag(salary) over() as prev_sal
from employees;

-- Compare each employee's salary with the previous employee's salary within their department.
select *, 
lag(salary, 1) over(partition by department) as prev_sal
from employees;

-- default value is 0 (i.e instead of null we will show zero) and offset as 2
select *, 
lag(salary, 2, 0) over(partition by department) as prev_sal_2
from employees;

-- 2. LEAD() : Provides access to a row at a specified physical offset that comes after the current row.
-- Compare each employee's salary with the next employee's salary within their department with default value of 0 instead of null.
select *, 
lead(salary, 1, 0) over(partition by department) as next_sal
from employees;

-- 3. FIRST_VALUE() :  Returns the first value in an ordered set of values.
-- Find the lowest salary within each department without using MIN.
select *, 
first_value(salary) over(partition by department order by salary asc) as min_sal
from employees;

-- 4. LAST_VALUE() : Returns the last value in an ordered set of values.
-- Find the highest salary within each department without MAX and using LAST_VALUE function.

-- we cannot use directly this query , however it seems correct but the window functions always calculates upto current row 
-- i.e the default frame_definition : RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW 
select *, 
last_value(salary) over(partition by department order by salary asc) as max_sal
from employees;

-- So, for that reason we have to extend the calculations from start of the partitioned group or maybe current row to its end
-- i.e ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING /or/ ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING /or/ using RANGE inplace of ROWS is also correct.
select *, 
last_value(salary) over(partition by department order by salary asc rows between current row and unbounded following) as max_sal
from employees;

-- Now , lets see the answer of the same query using FIRST_VALUE , this is correct because the default frame_definition is enough for calculation
select *,
first_value(salary) over(partition by department order by salary desc) as max_sal
from employees;

-- 5. NTH_VALUE() :  Returns the value of the expression at the specified row in the window frame.
--  Get the 3rd highest salary within each department. ( Again here we have to change the frame_definition )
select *, 
nth_value(salary, 3) over(partition by department order by salary rows between unbounded preceding and unbounded following) as third_highest_salary
from employees;

-- Now we can also use a group by with CTE for a better format 
with third_highest as (
		select *, 
		nth_value(salary, 3) over(partition by department order by salary  rows between unbounded preceding and unbounded following) as third_highest_salary
		from employees
)
select department, third_highest_salary
from third_highest
group by department, third_highest_salary;

# This topic is longer than expected, so I hope you have understood about the aggregaeted and value window functions.
# Also with this worksheet we understood the difference of frame units and its importance in any analytical window calculation.
# If it didn't make sense to you , then donot worry , it will make sense later on. 
# Untill then lets go to a movie theatre for popcorns and movies, Also Happ........... , I hope you got it what it means