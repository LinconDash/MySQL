### Function ###
-- Functions in MySQL are stored routines that return a single value. They are useful for encapsulating logic that needs to be reused in SQL queries. 
-- Functions can be used in the SELECT statement, WHERE clause, or any place where expressions are allowed.
-- They enhance code reusability, modularity, and maintainability, but should be used with consideration for their limitations and performance implications.
-- Proper error handling and documentation are crucial for creating robust and maintainable functions.

-- Note : Functions and Procedures are both stored routines, however both are much different from each other. We will see their differences later on.

# CREATE A FUNCTION 
-- we can create a user-defined function using the following syntax :
# syntax :
/*
CREATE FUNCTION function_name(parameters)
RETURNS data_type
[DETERMINISTIC | NO SQL | READS SQL DATA]
BEGIN
    -- Function logic here
    RETURN value;
END;
*/

# Some important points to consider while creating a function 
-- 1. Parameter Modes : Parameters in MySQL functions are always IN parameters, meaning that the function can only read the values passed to it.
-- 2. Returning Values : A function must return a value using the RETURN statement. The data type of the returned value must match the data type specified in the RETURNS clause.
-- 3. Functions must return a single value. They use the RETURN statement to send a value back to the caller.
-- 4. There are certain function behaviour such as :
-- 		a.DETERMINISTIC: Indicates that the function always produces the same result for the same input parameters.
--        Ex : calculating the area of a rectangle from its length and breadth passed as parameter
-- 		b.NO SQL: Indicates that the function does not read or write data.
--        Ex : calculating the square of a number passed as parameter
-- 		c.READS SQL DATA: Indicates that the function reads data but does not write data.
-- 		  Ex : calculating the full_name of a employee using the parameters as first_name and last_name

-- Same as stored procedure we can create a function with parameter and without parameters , but generally we create it with parameters

-- Deterministic function example
delimiter //
create function calculate_area(length float, breadth float)
returns float
deterministic
begin
	declare area float;
    set area = length * breadth;
    return area;
end //
delimiter ;

-- Unlike stored procedure , we can use functions in other statments 
select calculate_area(10, 5) as Area;

-- No sql function example
delimiter //
create function square(n int)
returns int
no sql
begin
	return n * n;
end //
delimiter ;

select square(5) as result;

-- Reads sql data function example
delimiter //
create function get_fullname(first_name varchar(50), last_name varchar(50))
returns varchar(100)
reads sql data
begin
	return concat(first_name, " ", last_name);
end //
delimiter ;

select employee_id, get_fullname(first_name, last_name) as Full_name
from employees;

-- Also this function can be used in other clauses , but I am a bit lazy now so please cooperate.

# Handling Null values : we can use is null or = 0 for a case in handling the null values in a function
-- Ex : Implement a safe division function that returns null when we provide 0 as denominator
delimiter //
create function safe_division(numerator float, denominator float)
returns float
deterministic
begin
    if denominator is null or denominator = 0 then
        return null;
    else
        return numerator / denominator;
    end if;
end //
delimiter ;

select safe_division(10, 5) as result;
select safe_division(10, 0) as result;

# SEE ALL FUNCTIONS
show function status where db = "practice";     # I named my db as practice, you can use your own db name

# DROP A FUNCTION
drop function if exists safe_division;

## THEORY TIME ##

# LIMITATIONS OF FUNCTIONS IN SQL 
-- 1. Performance: Functions can be slower than equivalent inline code due to the overhead of the function call.
-- 2. Restrictions: Functions have certain restrictions, such as not being able to perform DML operations (INSERT, UPDATE, DELETE) or commit/rollback transactions.

# Differences between the functions and the stored procedures
-- 1. Return values :
-- Functions must return a single value. They use the RETURN statement to send a value back to the caller.
-- Procedures do not return a value. However, they can return multiple values using OUT parameters.

-- 2. Usage :
-- Functions can be used in SQL statements like SELECT, WHERE, and JOIN.
-- Procedures are called using the CALL statement. They cannot be used directly in SQL statements.

-- 3. Restrictions :
-- Functions cannot perform database modifications like INSERT, UPDATE, or DELETE.They cannot commit or roll back transactions. 
-- Procedures can perform database modifications like INSERT, UPDATE, or DELETE.They can commit or roll back transactions.

-- 4. Parameter Modes : 
-- Only IN parameters are allowed.Functions generally donot specify any parameter mode
-- Procedures can have IN, OUT, and INOUT parameters.


-- Extra tip :
-- If you need to compute and return a single value based on some input parameters, use a function.
-- If you need to perform multiple operations or steps, especially if they involve modifying the database, you can use procedure. 
-- Functions are best for simple, reusable computations that return a single value and can be used in SQL queries.
-- Procedures are best for complex operations, especially those involving database modifications or multiple steps, and are called explicitly using CALL.

# My Message :
# That's it guys for SQL, we donot have any more topic to study for SQL.
# Those who made it this far are absolute legends in this world. 
# If you have learnt everything upto this much then I can guarantee you will never fail an SQL round of interview.
# If you loved this journey make sure to give this repo a star to motivate me and I will see you next time with a whole new tech.
# Untill them Good Bye, and dont forget Happy Coding !!