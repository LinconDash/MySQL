-- In MySQL, every statement or query produces a temporary result or relation. A common table expression or CTE is used to name those 
-- temporary results set that exist within the execution scope of that particular statement, such as CREATE, INSERT, SELECT, UPDATE, DELETE, etc.

/* 
Some of the key point related to CTE are:
1. It is defined by using the WITH clause.
2. The WITH clause allows us to specify more than one CTEs in a single query.
3. A CTE can reference other CTEs that are part of the same WITH clause, but those CTEs should be defined earlier.
4. The execution scope of CTE exists within the particular statement in which it is used.
*/

-- The following is the basic syntax of CTE in MySQL:
-- WITH cte_name (column_names) AS (query)   
-- SELECT * FROM cte_name;  

-- It is to ensure that the number of columns in the CTE arguments must be the same as the number of columns in the query. 
-- If we have not defined the columns in the CTE arguments, it will use the query columns that define the CTE.
-- Similar to the derived table, it cannot be stored as an object and will be lost as soon as the execution of a query completed.
-- A CTE provides better readability and also increases the performance as compared to the derived table.

-- Before moving onto CTE , let me tell you WHY CTE ?
/*
1. Improved Readability and Maintainability
2. You can define intermediate results with CTEs and then build on these results in subsequent queries.
3. CTEs support recursive queries, which are essential for querying hierarchical data 
4. This can be more convenient and sometimes more efficient than creating temporary tables.
5. Enhanced SQL Server Optimization with better query performance
6. The CTE allows us to use it as an alternative to the VIEW concept
7. It can also be used as chaining of CTE for simplifying the query.
*/

-- Lets create a table for learning CTEs so that we can call ourselves pro in SQL
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(50),
    manager_id INT,
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (employee_name, manager_id, department, salary) VALUES
('Alice', NULL, 'HR', 60000.00),
('Bob', 1, 'HR', 50000.00),
('Carol', 1, 'HR', 55000.00),
('Dave', 2, 'Finance', 65000.00),
('Eve', 2, 'Finance', 70000.00),
('Frank', 3, 'IT', 72000.00),
('Grace', 3, 'IT', 75000.00),
('Heidi', 4, 'Finance', 68000.00),
('Ivan', 5, 'Finance', 71000.00),
('Judy', 6, 'IT', 73000.00);

select * from employees;

-- Lets create some CTEs for these queries :
-- Find all the employees whose salary is greater than the average salary of all the employees
with average_salary as   		
(
	select cast(avg(salary) as float) as av_sal from employees
)
select *
from employees as e, average_salary as av
where e.salary > av.av_sal;

# It only looks complex but trust me its becomes more better and better 
# Notice here that we didn't passed any columns so it will take all the columns in its select statement
# I personally prefer it this way , cuz you all know , I am Lazy !!

-- Find the employees whose salary is greater than its own department's average salary
with dept_avg_sal as 
(
	select department, cast(avg(salary) as float) as avg_sal
    from employees
    group by department 
)
select e.employee_id , e.employee_name, e.department, e.salary , d.avg_sal
from employees as e
inner join dept_avg_sal as d
on e.department = d.department
where e.salary > d.avg_sal;
# As you can see we can also use joins

-- Find managers names and the no. of employees each manager has
with employee_and_managers as 
(
	select e1.employee_name, e2.employee_name as manager_name
    from employees e1
    left join employees e2
    on e1.manager_id = e2.employee_id
)
select manager_name, count(*) as no_of_employees
from employee_and_managers
where manager_name is not null
group by manager_name;

## MULTIPLE CTEs ##
-- Find the HR and Finance employees who have salary more than avg. salary of thier respective departments
with hr_employees as 
(
	select employee_name, salary
    from employees
    where department = "HR" and salary > (select avg(salary) from employees where department = "HR")
    
),
finance_employees as 
(
	select employee_name, salary
    from employees
    where department = "Finance" and salary > (select avg(salary) from employees where department = "Finance")
) 
select employee_name, salary, "Finance" as dept
from finance_employees
union 
select employee_name, salary, "HR" as dept
from hr_employees;
# Did you noticed how i made a constant value column known as dept ? 

# Note : Even though I have written all CTE with SELECT statement , but donot forget that CTE can even be created and written with CREATE, INSERT, UPDATE, DELETE, etc.
# Donot panic by looking at this , at some point of time , you will enjoy creating CTEs
# Untill then , Happy Coding !!