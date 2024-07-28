# If you are planning to get a job in data analysis / data science / data engineering , then you cannot skip this topic of SQL.
# Think about an window before moving onto this topic , Just kidding :) 

## Window Functions ##
-- Sometimes , we have some queries that are almost impossible to do without window functions, one example of such query is that : find the top 3 employees
-- from each department that have highest salary in their department , by looking at this question, its pretty sure that its going to be a complex one
-- Some of the most complex queries can be easily solved using the window functions thatswhy we use them. 
-- Did you noticed anything in that above example query , I mean it can be solved by finding out the highest salary on a department and based on 
-- that highest we can find second highest and then the third highest salary of each department. So kind of interrelated rows ? "Yup" 

-- Definition : A window function in MySQL used to do a calculation across a set of rows that are related to the current row. 
-- The current row is that row for which function evaluation occurs. Window functions perform a calculation similar to a calculation done 
-- by using the aggregate functions. But, unlike aggregate functions that perform operations on an entire table, window functions do not 
-- produce a result to be grouped into one row. It means window functions perform operations on a set of rows and produces an aggregated 
-- value for each row. Therefore each row maintains the unique identities
-- These functions allow us to solve the query related problem more efficiently.

-- We need some complex and huge data though for practicing these functions so lets create a table employee 
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    manager_id INT
);
-- With this huge data insertion (30 records)
INSERT INTO employees (first_name, last_name, department, salary, hire_date, manager_id) VALUES
('Alice', 'Johnson', 'Sales', 60000, '2020-01-15', NULL),
('Bob', 'Smith', 'HR', 65000, '2019-03-23', NULL),
('Charlie', 'Brown', 'IT', 75000, '2018-07-11', NULL),
('David', 'Williams', 'Sales', 50000, '2021-06-20', 1),
('Eve', 'Jones', 'HR', 62000, '2020-09-17', 2),
('Frank', 'Davis', 'IT', 70000, '2019-12-05', 3),
('Grace', 'Wilson', 'Finance', 80000, '2018-05-30', NULL),
('Hank', 'Garcia', 'Finance', 78000, '2019-08-25', 7),
('Ivy', 'Martinez', 'IT', 72000, '2020-11-10', 3),
('Jack', 'Hernandez', 'Sales', 54000, '2019-04-21', 1),
('Kathy', 'Lopez', 'HR', 68000, '2018-02-14', 2),
('Leo', 'Gonzalez', 'Finance', 82000, '2020-03-13', 7),
('Mia', 'Anderson', 'IT', 69000, '2018-09-17', 3),
('Nick', 'Thomas', 'Sales', 56000, '2019-12-11', 1),
('Olivia', 'Taylor', 'HR', 63000, '2020-05-25', 2),
('Paul', 'Moore', 'IT', 74000, '2018-11-01', 3),
('Quinn', 'Jackson', 'Finance', 79000, '2019-06-29', 7),
('Rachel', 'White', 'Sales', 61000, '2020-01-05', 1),
('Sam', 'Harris', 'HR', 64000, '2019-02-15', 2),
('Tina', 'Clark', 'IT', 76000, '2018-08-20', 3),
('Uma', 'Lewis', 'Finance', 81000, '2018-04-17', 7),
('Victor', 'Walker', 'Sales', 53000, '2021-05-15', 1),
('Wendy', 'Hall', 'HR', 67000, '2019-07-12', 2),
('Xavier', 'Allen', 'IT', 71000, '2020-10-08', 3),
('Yara', 'Young', 'Finance', 83000, '2020-02-28', 7),
('Zack', 'King', 'Sales', 52000, '2021-03-19', 1),
('Anna', 'Wright', 'HR', 66000, '2019-09-21', 2),
('Brian', 'Green', 'IT', 73000, '2018-12-02', 3),
('Cindy', 'Adams', 'Finance', 80000, '2020-04-13', 7),
('Daniel', 'Nelson', 'Sales', 55000, '2021-01-25', 1);

-- see the data
select * from employees;

/* syntax : 
	window_function_name(expression)   
	OVER (  
			[partition_defintion]  
			[order_definition]  
			[frame_definition]  
		)  
*/

-- In the syntax, it can be seen that we have first specified the name of the window functions, which is followed by an expression.
-- Then, we specify the OVER clause that contains three expressions that are partition_definition, order_definition, and frame_definition.
-- It makes sure that an OVER clause always has an opening and closing parentheses, even it does not have any expression.
-- Let us see the syntax of each expression used in the OVER clause:
/* 
1. PARTITION BY : This clause is used to divide or breaks the rows into partitions, and the partition boundary separates these partitions.
					 The window function operates on each partition, and when it crosses the partition boundary, it will be initialized again.
                     Just try to think that its kind of a group by clause but doesn't groups / merge the rows together.
   
   # syntax : PARTITION BY <expression>, [{<expressions>...}]  

2. ORDER BY : This clause is used to specify the order of the rows within a partition. We can use multiple expressions, columns to have sorted in different orders
			  Although the ORDER BY clause can work with all window functions, it is recommended to use it with order-sensitive window function.
              
   # syntax : ORDER BY <expression> [ASC|DESC], [{<expressions>  [ASC | DESC], ...}]  

3. FRAME CLAUSE : A frame is the subset of the current partition in window functions. So we use frame clause to define a subset of the current partition. 
				  The frame_unit that can be ROWS or RANGE is responsible for defining the type of relationship between the frame row and the current row. 
                  If the frame_unit is ROWS, then the offset of the frame rows and the current row is row number. While if the frame_unit is RANGE, then the offset is row values.
				  - The frame_start and frame_between expressions are used to specify the frame boundary. 
                  - The frame_start expression has three things
					1. UNBOUNDED PRECEDING: Here, the frame starts from the first row of a current partition.
					2. N PRECEDING: Here, N is a literal number or an expression that evaluates in numbers. It is the number of rows before the first current row.
					3. CURRENT ROW: It specifies the row of the recent calculation
				 
                 - The frame_between expression can be written as: BETWEEN frame_boundary_1 AND frame_boundary_2  
				 - The above expression can have one of the following things:
                    1. frame_start: We have already explained it previously.
					2. UNBOUNDED FOLLOWING: It specifies the end of the frame at the final row in the partition.
                    3. N FOLLOWING: It is the physical N of rows after the first current row.

 
	# syntax : frame_unit {<frame_start>|<frame_between>}  
			
    # Note : If the frame_definition is not specified in the OVER clause, then by default MySQL uses the below frame:
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW          
*/

-- Find the department and the max salary of each department
select department, max(salary)
from employees
group by department;			-- Every rows got merged by department and we can't know about exmployees

# Now with a window function : ( aggregated window function max )
select e.*, 
max(salary) over(partition by department) as max_salary
from employees as e;
-- Yes, now we can see all the data as well as max_salary of each department

# Now with also the order by clause - order them as the salary in descending order
select e.*, 
max(salary) over(partition by department order by salary desc) as max_salary
from employees as e;

# Now with also the frame clause - calculate the max_salary between 1 preceeding and 1 following row 
select e.*, 
max(salary) over(partition by department order by salary desc ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) as max_salary
from employees as e;

# Also we can do over() without any clauses - Will take the gloabal maximum salary and not department-wise
select e.*, 
max(salary) over() as max_salary
from employees as e;
# Note about above query : if we donot pass anything on over then its going to treat the  whole data as a single window and apply the window function on whole data

# Note : This was just about the OVER clause and how to use it , we haven't covered any window functions yet.

# Aren't these things complex yet fun to watch the results ? Welcome to the section of "Advanced SQL" where things start to become foggy yet sunny , I mean funny.
# That was a lot of theory , but we are not finished here, we have tons of pre-built window functions in MySQL 
# which help us to become the top 1% of SQL-learners, by solving problems that are on a whole different level
# Untill then , do some meditation to keep yourself relax, and we will meet again with a lot of fun (functions ;-) )
# Also don't forget , Happy ______  you fill the blank !