# Hey how its going , soon we will come to an end of our worksheet and tutorials , if you come this far , then I bet you are amazing !!

-- Now that we have covered what are window functions and how to use the OVER clause , we  will see some predefined window functions
-- that are very useful in solving highly complex problems in SQL. So lets begin by looking at the types of window functions.

-- 1. Ranking Window Functions: These provide a rank for each row in the result set.
-- ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE(n)

-- 2. Aggregate Window Functions: These perform calculations across a set of rows and return a single value for each row.
-- SUM(), AVG(), MIN(), MAX(), COUNT()

-- 3. Value Window Functions: These return values based on the position of the row within the window.
-- LEAD(), LAG(), FIRST_VALUE(), LAST_VALUE(), NTH_VALUE(expression, offset)

-- 4. Cumulative Window Functions: These return cumulative values.
-- CUME_DIST(), PERCENT_RANK()

# Now lets see each of them one by one :
## Ranking Functions ##
-- 1. ROW_NUMBER function : The ROW_NUMBER() function in MySQL is used to returns the sequential number for each row within its partition / window. 
-- The row number starts from 1 to the number of rows present in the partition / window.

-- print the row numbers along with all data
select *, 
row_number() over() as rn 
from employees;

-- print the row numbers along with all data partitioned by department 
select *, 
row_number() over(partition by department) as rn 
from employees;

-- Find the first 2 employees of each department (Assume the hire_date column as a reference to thier joining)
select * from (
		select *, 
		row_number() over(partition by department order by hire_date asc) as rn
		from employees
) as x
where x.rn < 3;
# As we can see we have the first two employees of each department , this was almost complex to do in any other means except window functions

-- 2. RANK function : RANK() provides a rank for each row within the partition of a result set. 
-- The rank of a row is one plus the number of ranks that come before it. If there are ties, they receive the same rank, and the next rank(s) are skipped.

-- see what rank does , it assigns the same rank to the whole window if we donot have an order by clause in over
select *,
rank() over() as rn
from employees;

-- with the partition and order
select *, 
rank() over(partition by department order by salary desc) as salary_ranked 
from employees;
# This query assigns a rank to each employee within each department based on their salary. 
# Employees with the same salary receive the same rank, and gaps appear in the ranking sequence if there are ties.

-- 3. DENSE RANK function : DENSE_RANK() is similar to RANK(), but it does not skip ranks. 
-- If there are ties, they receive the same rank, and the next rank is the immediate subsequent integer.
-- Personally, i feel its better to use DENSE_RANK than RANK if a question allows both 
select *, 
dense_rank() over(partition by department order by salary desc) as salary_ranked 
from employees;

-- See the differences clearly
select *, 
rank() over(partition by department order by salary desc) as ranked,
dense_rank() over(partition by department order by salary desc) as dense_ranked 
from employees;

-- Fetch the top 3 employees of each department according to thier salary , if there are duplicates ranks , allow them too
select * from(	
    select *, 
	dense_rank() over(partition by department order by salary desc) as salary_ranked 
	from employees
) as x
where x.salary_ranked <= 3;

-- 4. NTILE function : NTILE(n) divides the rows within a partition into n approximately equal groups and assigns a number to each row indicating which group it belongs to.
-- Now this is actually used for subgroup in a group kind of questions
select *,
ntile(2) over() as n
from employees;       
# This query divides the whole data / single window into two subgroups 

-- Divide the respective department employees into 3 groups
select *,
ntile(3) over(partition by department) as n
from employees; 

-- Assign 3 tags of the employees according to salary in each department also divide them as "High Salary", "Moderate Salary", "Less Salary"
select *,
case 
	when x.n = 1 then "High Salary"
    when x.n = 2 then "Moderate Salary"
    when x.n = 3 then "Less Salary"
end as employee_designation
from (
	select *,
	ntile(3) over(partition by department order by salary desc) as n
	from employees
) as x

# Phew !! So these are some of the examples that I hope helped you to understand better about the window functions 
# Dnot worry we will also see some cool questions that are extremely complex yet simple to tackle with window functions
# Up next we will see about some other kinds of windows and doors.
# Untill then , stay motivated and Happy Coding .