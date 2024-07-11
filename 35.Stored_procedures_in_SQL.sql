## PROCEDURES AND FUNCTIONS IN SQL ##
# This topic covers important things such as :
-- What is a procedure ?
-- Why we use a procedure ?
-- How to create a procedure ?
-- How to call a procedure ?
-- Procedure without parameters 
-- Procedure with parameters
-- Procedure with different parameter modes (IN, OUT, INOUT)
-- Procedure with variable declaration and other statements

# Same things are to be covered while studying functions 
# Note : Procedures are not same as functions and we will see the differennces.

# What is a procedure ?
-- A procedure (also called as stored procedure) in SQL is a group of SQL queries that can be saved and reused multiple times. 
-- Users can also pass parameters to stored procedures so that the stored procedure can act on the passed parameter values.
-- It is nothing but a group of SQL statements that accepts some input in the form of parameters, performs some task, and may or may not return a value.  

# Why we use a procedure ?
-- Stored Procedures are created to perform one or more DML operations on the Database. 
-- It is very useful as it reduces the need for rewriting SQL queries. It enhances efficiency, reusability, and security in database management.
-- We can use procedure for building complex logics such as Data preprocessing, Data cleaning, Data manipulation etc. and this is the reason they are more powerful
-- It is used to do things that are not possible using a normal SQL query.

# Extras :
-- A procedure is called a recursive stored procedure when it calls itself. 
-- Most database systems support recursive stored procedures. But unfortunately, it is not supported well in MySQL.

/*
PROCEDURE can include all of these statements such as :
1. SQL queries
2. DML, DDL, DCL and TCL statements
3. Collection types
4. Cursors
5. Loop and if-else statement
6. Variables
7. Exception Handling and etc.
*/

# How to create a procedure ?
-- The basic syntax of creating a procedure in MySQL is by using this statements as follows:
# syntax  :

/*
DELIMITER $$							
CREATE PROCEDURE procedure_name([IN, OUT, INOUT] param_1 data type, [IN, OUT, INOUT]param_2 data type)  
BEGIN    
    Declaration_section      -- variable declaration 
    Executable_section    	 -- Executable SQL scripts
END &&  
DELIMITER ;  
*/

# Notes :
-- Change the delimiter because the default one is ; which is used again inside the procedure so changing it and then resetting it to avoid end of statement confusion in a procedure 
-- [IN, OUT, INOUT] : There are three modes of procedure parameter and are described as follows :
-- 1. IN : It is the default mode. It takes a parameter as input, such as an attribute. When we define it, the calling program has to pass an argument to the stored procedure. 
-- This parameter's value is always protected.
-- 2. OUT : It is used to pass a parameter as output. Its value can be changed inside the stored procedure, and the changed (new) value is passed back to the calling program.
-- It is noted that a procedure cannot access the OUT parameter's initial value when it starts
-- 3. INOUT : It is a combination of IN and OUT parameters. It means the calling program can pass the argument, and the procedure can modify the INOUT parameter, and then passes 
-- the new value back to the calling program.
-- If parameters are not passed then we donot have to define the parameter modes.
-- Declaration_section : It represents the declarations of all variables.
-- Executable_section : It represents the code for the function execution.

# How to call a procedure ?
-- We can use the CALL statement to call a stored procedure. This statement returns the values to its caller through its parameters (IN, OUT, or INOUT). 
-- The following syntax is used to call the stored procedure in MySQL:
# syntax : CALL procedure_name (parameter(s))  

# Procedure without parameters #
-- Ex : Get the information of all the employees from the employee table 
DELIMITER $$
CREATE PROCEDURE get_employees()
BEGIN 
	select * from employees;
END $$
DELIMITER ;

-- call the procedure 
CALL get_employees(); 

# Procedure with parameters #
-- With Input Parameter
-- Ex : Get the specified departement information of all the employees from the employee table
DELIMITER $$
CREATE PROCEDURE get_employees_with_dept(IN dept_type VARCHAR(50))     -- Using the IN mode because the user will give the input
BEGIN
	select * from employees where department = dept_type;
END $$
DELIMITER ;

CALL get_employees_with_dept("Sales");
CALL get_employees_with_dept("HR");

-- With Output Parameter
-- Ex: Get the maximum salary from the table and store it in a variable 
DELIMITER $$
CREATE PROCEDURE get_maxSalary(OUT result FLOAT)     -- Using the OUT mode because the user will recieve the result
BEGIN
	select max(salary) into result from employees;
END $$
DELIMITER ;

SET @max_sal = 0;                -- You may / maynot use this 
CALL get_maxSalary(@max_sal);       -- pass a variable (A variable starts with @ symbol in SQL)
SELECT @max_sal as maximum_salary;

-- With input-output parameters (INOUT)  -- This is generally not used much as a standard mode 
-- Ex : Get the salary of the employee by ID
DELIMITER //
CREATE PROCEDURE get_sal_by_ID(INOUT var1 INT)
BEGIN 
	select salary into var1 
    from employees
    where employee_id = var1;
END //
DELIMITER ;

SET @id = 5;
select @id;
CALL get_sal_by_ID(@id);
select @id;

# Procedure with variable declarations #
-- We can declare variables inside the function also using the DECLARE clause
-- Ex : Calculate the total salary and average salary for a specified department.
DELIMITER //
CREATE PROCEDURE calculate_salaries(dept varchar(50))
BEGIN 
	DECLARE avg_sal FLOAT;
    DECLARE total_sal FLOAT;
    
    SET avg_sal = 0;
    SET total_sal = 0;
    
    SELECT SUM(salary), AVG(salary)
    INTO total_sal, avg_sal
    FROM employees
    WHERE department = dept;
	
    -- Display the results 
    select avg_sal as Average_salary, total_sal as Total_salary;
    
END //
DELIMITER ;

-- call the procedure
CALL calculate_salaries("IT");
CALL calculate_salaries("Sales");

-- To see all procedures of a database we can use this :
show procedure status where db = 'practice';    # I named my db as practice , you can write your own db name.

# Phew !! so much theory to note down, I am tired now.
# These were some of the very simplest procedure examples, next we will try something advanced stuff.
# Thats it for now, and we will meet next time, Untill then just focus on your career, Happ...... ! you know the rest :)