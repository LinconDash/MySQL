-- Yes you saw it right, recursive cte, I mean common man we have recursion even in SQL too !!

## RECURSIVE CTEs ##
-- Unlike a derived table, a CTE is a subquery that can be self-referencing using its own name. 
-- It is also known as recursive CTE and can also be referenced multiple times in the same query.
-- Some of the essential points related to the recursive CTE are:
-- 1. It is defined by using the WITH RECURSIVE clause.
-- 2. A recursive CTE must contain a terminating condition (which we call as base condition in recursion of any programming language).
-- 3. We will use the recursive CTE for series generation and traversal of hierarchical or tree-structured data.

/* syntax : WITH RECURSIVE cte_name (column_names) AS ( subquery )
			SELECT * FROM cte_name;  
*/

-- A simple example of a recursive CTE 
-- Generate exactly 5 even numbers starting from 0
with recursive even_numbers as
(
	select 1 as id, 0 as num
    union all
    select id + 1, num + 2 from even_numbers where id < 5
)
select * from even_numbers;

-- You might think that it is a recursive function , if yes then " you are dumbo !! "
-- Just kidding , this is not a recusive function rather a expression that generates itself, functions/procedures are different from CTEs 
-- which we will see later on to get a better understanding.

-- The above statement consists of two parts one is non-recursive, and another is recursive.
-- Non-recursive: SELECT 1 as id, 0 as num . This part will produce the initial rows with two columns as "id" and "num" and a single row.
-- Recursive: SELECT id + 1, num + 2 from even_numbers where id < 5
-- This part is responsible for adding rows to the previous output until the terminating condition (id < 5) will not be satisfied. When the id reached 5, the condition becomes false, and the recursion process is terminated.

-- Questions time :   
-- (I thought that CTE are most common in SQL interview so why not practise some recursive CTE, feel free to ignore these questions if you think you are "pro" in SQL)


-- Find the employee_hierarchy of employees table
with recursive employee_hierarchy as (
    select  employee_id, employee_name, manager_id
    from employees
    where manager_id is null  -- Top-level manager
    
    union all

    select e.employee_id, e.employee_name, e.manager_id
    from employees e
    inner join employee_hierarchy eh 
    on e.manager_id = eh.employee_id
)
select * from employee_hierarchy;
-- The output seems so simple but its according to the hierarchy of the employees

-- Find the rank of managers and thier names ( Its definitely a Moderate/Medium question )
with recursive ranks as 
(
	select employee_id, employee_name, 1 as emp_rank
    from employees
    where manager_id is null   -- Top-level manager
    
    union all
    
    select e.employee_id, e.employee_name, r.emp_rank + 1
    from employees as e
    inner join ranks as r
    where e.manager_id = r.employee_id
)
select emp_rank, group_concat(employee_name separator " , ") as ranked_employees
from ranks
group by emp_rank;

-- Find the no. of subordinates of each manager along with thier names and ids
with recursive subordinates as 
(
	select employee_id, manager_id
    from employees
    where manager_id is null   -- Top-level manager
    
    union all
    
    select e.employee_id, e.manager_id
    from employees as e
    inner join subordinates as s
    on e.manager_id = s.employee_id
)
select s.manager_id, e.employee_name, count(*) as no_of_subordinates
from subordinates as s
inner join employees as e
on s.manager_id = e.employee_id
group by s.manager_id;

-- Find a path from specific employee (for example lets say employee with id=9) to the top-level manager
with recursive employee_path as 
(
    select employee_id, employee_name, manager_id
    from employees
    where employee_id = 9

    union all
    
    select e.employee_id, e.employee_name, e.manager_id
    from employees e
    inner join employee_path ep 
    on e.employee_id = ep.manager_id
)
select * from employee_path;

# This one was easy though , don't you think ? 

## Bonus question : (to be honest , I found this on hackerrank) ##
-- Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, 
-- and use the ampersand (&) character as your separator (instead of a space).
with recursive numbers as 
(
	select 2 as num
    union all 
    select num + 1 from numbers where num < 1000
),
prime_numbers as 
(
	select n1.num as prime
    from numbers as n1
    left join numbers as n2
    on n2.num < n1.num and n1.num % n2.num = 0
    where n2.num is null
)
select group_concat(prime order by prime separator '&') from prime_numbers


## EXTRA : MySQL provides many contexts to use the WITH clause for creating CTE.
/*
1. 	WITH ... SELECT ...  
	WITH ... UPDATE ...  
	WITH ... DELETE ...  
    
2. 	SELECT ... WHERE id IN (WITH ... SELECT ...);  
	SELECT * FROM (WITH ... SELECT ...) AS derived_table;  
    
3. 	CREATE TABLE ... WITH ... SELECT ...  
	CREATE VIEW ... WITH ... SELECT ...  
	INSERT ... WITH ... SELECT ...  
	REPLACE ... WITH ... SELECT ...  
	DECLARE CURSOR ... WITH ... SELECT ...  
	EXPLAIN ... WITH ... SELECT ...  
*/

# I could have shown you with examples but , you know I am kinda lazy !!
# Anyways , I think this is it for the CTEs and by this worksheet we have also practised different kinds of CTE questions.
# Also , come to think about the questions, we are kinda ready to tackle about any intermediate-advanced SQL problems.
# But still we have more topics on the go , so be ready for the next topic "Methods to eat a large pizza in 1 minute" 
# Just kidding , after this have "some video games to play" , Untill then , Happy Coding !!