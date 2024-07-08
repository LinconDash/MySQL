## Cumulative window functions ##
-- Cumulative window functions are a type of window function that operate on a set of rows and return a cumulative result. 
-- They are often used in analytics to provide cumulative distribution values, rankings, and percentages. 
-- Now there are functions like CUME_DIST and PERCENT_RANK.
-- But we can also perform cumulative calculations using the SUM, COUNT, AVG, etc. by changing the frame definition of a window

-- 1.CUME_DIST() : This function calculates the cumulative distribution of a value in a set of values. 
-- It returns the relative position of a value among a set of values, as a number between 0 and 1.
-- Formula : current_row no. (or row no. with value same as current_row) / total no. of rows

-- Calculate the cumulative distribution of salaries within each department.
select *,
cume_dist() over(partition by department order by salary) as distribution,
round(cast(cume_dist() over(partition by department order by salary) as float) * 100, 2) as distribution_percent
from employees;

-- 2. PERCENT_RANK() :  The PERCENT_RANK() function calculates the relative rank of a value in a set of values as a percentage. 
-- It returns the percentage rank of each value within a partition, ranging from 0 to 1.
-- Formula : current_row - 1 / Total rows - 1

-- Calculate the percentage rank of salaries within each department.
select *,
percent_rank() over(partition by department order by salary) as percent_ranks,
round(cast(percent_rank() over(partition by department order by salary) as float) * 100 , 2) as percent_ranks_percentage
from employees;


# Now lets see some agg functions in action
-- This section can make you understand why the frame definition is important

-- Calculate the running total and running average but this time donot partition anything 
select *,
sum(salary) over(rows between unbounded preceding and current row) as cumulative_sum, 
avg(salary) over(rows between unbounded preceding and current row) as cumulative_avg
from employees; 

-- see how they are totaled now just by changing the frame definition
-- Therefore its important to know these window analytical functions as well as about the frame definition you are using 

-- An alternate way to write a SQL query having window functions 
-- Suppose you have a query that have multiple window functions but they follow the same partition , order and frame definition
-- In that case we can use a window clause for those definitions 
-- Example : Find the highest , avgerage and lowest salary of each department 
select *,
max(salary) over(partition by department order by salary range between unbounded preceding and unbounded following) as highest_salary,
avg(salary) over(partition by department order by salary range between unbounded preceding and unbounded following) as average_salary,
min(salary) over(partition by department order by salary range between unbounded preceding and unbounded following) as lowest_salary
from employees;

-- So you see I have mentioned the same over clause for each of the columns separately even tough they are same
-- Better we should use this alternative way :
select *,
max(salary) over w as highest_salary,
avg(salary) over w as average_salary,
min(salary) over w as lowest_salary
from employees
window w as (partition by department order by salary range between unbounded preceding and unbounded following);

-- we can also create multiple windows with different definitions as :
select *,
max(salary) over w as highest_salary,
avg(salary) over w as average_salary,
first_value(salary) over w2 as lowest_salary
from employees
window w as (partition by department order by salary range between unbounded preceding and unbounded following) ,
	   w2 as (partition by department order by salary asc rows between unbounded preceding and unbounded following);
	

# Questions time : Feel free to skip this if you are already confident about the use cases of window functions !!
# Note : Donot think that these are the only possible solution for each question , you may have different answers

-- Find the top 3 employees of each departemnt based on thier salary , salary duplicates are allowed
select *
from 
	(
		select *, 
		dense_rank() over(partition by department order by salary desc , employee_id asc) as rnk
		from employees
	) as x
where x.rnk <= 3;

-- Find the median value of salary in the entire table 
# FYI : Median is the middle value when a sequence is in sorted order (doesnn't matter in ascending or descending but must be sorted)
with cte as 
(
	select *,
    row_number() over(order by salary) as rn,
    count(*) over() as counts
    from employees
)
select *
from cte 
where rn in ((counts + 1) / 2, (counts + 2) / 2); -- I did this because of even and odd number of records

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
) as x;

-- Find employees with above average salary from thier department
select concat(x.first_name," ",x.last_name) as employee_name, department
from 
(
	select *,
    avg(salary) over(partition by department rows between unbounded preceding and unbounded following) as avg_sal
    from employees
) as x
where x.salary > x.avg_sal;

-- Identify the Employees Who Have the Longest Tenure in Each Department
with cte as 
(
	select *,
    row_number() over(partition by department order by hire_date asc) as rn
    from employees
)
select * 
from cte
where rn = 1;

-- Calculate the Difference in Salary Between Each Employee and the Highest Paid Employee in Their Department
with cte as 
(
	select *,
    max(salary) over(partition by department) as max_sal
    from employees
)
select *, (max_sal - salary) as salary_diff
from cte;

-- Find the Median Salary for each Department 
with cte as 
(
    select *,
	row_number() over (partition by department order by salary) as row_num,
	count(*) over (partition by department) as dept_count
    from employees
)
select department, salary as median_salary
from cte
where row_num in ((dept_count + 1) / 2, (dept_count + 2) / 2);   -- I did this because of even and odd number of records

# There are many more questions like this but I feel that this is enough to build some logic about window functions 
# That's it for the window functions , we have come a long way in Advanced SQL 
# Untill then, find some awesome movies to chill, also don't forget Happy coding !!