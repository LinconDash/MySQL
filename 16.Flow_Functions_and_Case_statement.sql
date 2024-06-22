-- There are several control flow functions and one statement called CASE statement is used to control the flow of the query execution .
--  In this particular section we will see the use cases of these :
-- 1. IF() function
-- 2. IFNULL() function
-- 3. NULLIF() function
-- 4. CASE Statement 
-- 5. IF Statement 

-- NOTE : IF statement is not the same as IF() function

## IF() function ##
-- The IF function is one of the parts of the MySQL control flow function, which returns a value based on the given conditions. 
-- In other words, the IF function is used for validating a function in MySQL. The IF function returns a value YES when the given 
-- condition evaluates to true and returns a NO value when the condition evaluates to false. It returns values either in a string
--  or numeric form depending upon the context in which this function is used. Sometimes, this function is known as IF-ELSE and 
--  IF THAN ELSE function.
# syntax : IF ( expression 1, true_expression, false_expression)  

SELECT IF(200>350,'YES','NO');  

SELECT * ,  IF(active = True, "Good Employee", "Bad Employee") as Remarks from employee_data;

## IFNULL() function ##
-- The IFNULL function accepts two expressions, and if the first expression is not null, it returns the first arguments.
-- If the first expression is null, it returns the second argument. This function returns either string or numeric value, 
-- depending on the context where it is used
# syntax : IFNULL(expression, result_if_null)

SELECT IFNULL(0,5);
SELECT IFNULL(NULL,5);  
SELECT IFNULL("Hello", "World");  
SELECT first_name, last_name, IFNULL(department, "Not Employee") as designation from employee_data;

# Note: You should avoid the use of the IFNULL() function in the WHERE clause because this function reduces the performance of the query.

## NULLIF() function ##
-- The NULLIF function accepts two expressions, and if the first expression is equal to the second expression, it returns 
-- the NULL. Otherwise, it returns the first expression.

SELECT NULLIF("Hello", "Hello");  # returns null as both are same
SELECT NULLIF("Hello", 5);  	  # returns Hello as its first expression and both are not same
SELECT first_name, last_name, NULLIF(department, "Engineering") as designation from employee_data;

## CASE STATEMENT ##
-- MySQL CASE expression is a part of the control flow function that provides us to write an if-else or if-then-else logic to a
-- query. This expression can be used anywhere that uses a valid program or query, such as SELECT, WHERE, ORDER BY clause, etc.
-- The CASE expression validates various conditions and returns the result when the first condition is true.
-- Once the condition is met, it stops traversing and gives the output. If it will not find any condition true, 
-- it executes the else block. When the else block is not found, it returns a NULL value. 
-- The main goal of MySQL CASE statement is to deal with multiple IF statements in the SELECT clause.
-- NOTE : Its just like a SWITCH statement in any programming language ( If you have knowledge about programming language :) )

-- There are two types of case statement : simple case and searched case
-- 1. Simple case statement
/* syntax of simple CASE statement :
CASE expression
    WHEN value1 THEN result1
    WHEN value2 THEN result2
    ...
    ELSE resultN
END
*/

-- 2. Searched case statement
/* syntax of searched CASE statement :
CASE   
    WHEN [condition] THEN result   
    [WHEN [condition] THEN result ...]   
    [ELSE result]   
END  
*/

# Example of simple case statement
SELECT *,
	CASE active
		WHEN True THEN 'Good Employee'
		WHEN False THEN 'Bad Employee' 
		ELSE 'I dont care' 
	END as remarks
from employee_data;  

# Examples of searched case statement
SELECT *,
	CASE
		WHEN age < 30 THEN "Junior Employee"
		WHEN age >= 30 and age < 40 THEN "Experienced Employee"
		WHEN age between 40 and 50 THEN "Senior Employee"
		ELSE "Boss !!"
	END as employee_ranks
from employee_data;

SELECT *,
	salary + salary * 0.5 as hiked_salary ,
	CASE 
		WHEN salary + salary * 0.5 between 60000 and 70000 THEN "Hike required"
		WHEN salary + salary * 0.5 between 71000 and 90000 THEN "Little Hike required"
		WHEN salary + salary * 0.5 > 91000 THEN "Cut his salary"
	END as salary_ranks
from employee_data;

## IF statement ##
-- The IF statement is used in stored programs that implement the basic conditional construct in MySQL. Based on a certain 
-- condition, it allows us to execute a set of SQL statements. It returns one of the three values True, False, or NULL.
-- We can use this statement in three ways IF-THEN, IF-THEN-ELSE, IF-THEN-ELSEIF-ELSE clauses, and can terminate with END-IF
-- Since we havenot covered yet about stored procedures , we will see the if statement later in the stored procedures section

# Example of if-else only for reference 
DELIMITER // # change the delimiter from ; to // for creating function easily without conflicts of delimeters

# This is a procedure 
CREATE PROCEDURE myResult(original_rate NUMERIC(6,2),OUT discount_rate NUMERIC(6,2))  
     NO SQL  
      BEGIN  
         IF (original_rate>500) THEN  
            SET discount_rate=original_rate*.5;  
        ELSEIF (original_rate<=500 AND original_rate>250) THEN  		# we have an else-if statement also
            SET discount_rate=original_rate*.8;  
        ELSE  
            SET discount_rate=original_rate;  
         END IF;  
         select discount_rate;  
     END // 
     
DELIMITER ;  

# variables
set @price = 150;  
set @discount_price = 120;  

# call the function myResult
call myResult(@price, @discount_price);			