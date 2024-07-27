-- Make sure you have the table with yourself
select * from employees;

# Procedure with different DML statements #
-- Generally DML statements are used in a stored procedure to perform multiple data manipulation task just by calling the procedure
-- We have seen already about select statement , so lets see UPDATE, DELETE, INSERT
-- Ex : Increment the salary of the specified employee by specified percentage 
DELIMITER //
CREATE PROCEDURE increment_sal(emp_id INT, percent DECIMAL(5, 2))
BEGIN 
	UPDATE employees
    SET salary = salary + percent * salary
    WHERE employee_id = emp_id;
    -- A Message after updationemployees
    SELECT concat("Updated Salary of ", first_name, " ", last_name, " Successfully !") as  Message 
    from employees where employee_id = emp_id;
END //

DELIMITER ;
CALL increment_sal(1, 0.1);   # increment the salary of emp_id = 1 by 10 %
CALL increment_sal(2, 0.2);   # increment the salary of emp_id = 2 by 20 %

-- Ex : Insert or delete records with a single procedure (we can use IF-ELSE statement)
DELIMITER //
CREATE PROCEDURE insert_or_delete(
	operation VARCHAR(10),
	empID INT,
    fName VARCHAR(50),
    lName VARCHAR(50),
	department VARCHAR(50),
    empSalary DECIMAL(10,2),
    hireDate DATE,
    managerId INT
    )
BEGIN 
	-- INSERT operation 
    IF operation = "INSERT" THEN
		INSERT INTO employees VALUES (empID, fName, lName, department, empSalary, hireDate, managerId);
        select "Inserted a row succesfully ! " as Message;
	ELSEIF operation = "DELETE" THEN
		IF EXISTS (select * from employees where employee_id = empID) THEN    # Make a check that if that employee exists or not 
			DELETE FROM employees WHERE employee_id = empID;
            select 'Employee deleted successfully.' as Message;
		ELSE
			select 'No such employee exists.' as Message;
		END IF;
	ELSE
		select "Invalid Operation" as Message;
     END IF;
END //
DELIMITER ;
-- call the procedure for insert
call insert_or_delete("INSERT", 31, "Harold", "Sweet", "IT", 70000, curdate(), 3);
-- then check the data 
select * from employees;
-- Now, lets see if delete works (Delete the same record we inserted)
call insert_or_delete("DELETE", 31, null, null, null, null, null, null);
-- then check the data 
select * from employees;
-- Now, lets see if we can delete a non existing employee
call insert_or_delete("DELETE", 50, null, null, null, null, null, null);
-- And all set !

# Likewise, we can use the DCL, DDl, and TCL statements inside a procedure 

# Procedure with LOOPs, conditional-jumps and CASE statements #
-- We can use the CASE statements inside of a procedure as we were using it in queries
-- But let's see some interesting LOOPS in the procedures, it would be easier to understand if you have done some basic programming.
-- So there are 3 kinds of Loop statements such as :
/*
1. WHILE  				# similar to while loop
2. REPEAT .. UNTIL 		# similar to do while loop
3. LOOP					# similar to for loop
*/

-- And there are 2 kinds of conditional-jump statements such as  
/*
1. LEAVE 				# similar to break statement
2. ITERATE 				# similar to continue statement
*/

-- Lets see each of the loops one by one 
-- 1. WHILE : Repeatedly executes a block of statements while a condition is true and used when we have a known condition.
# syntax : 
/*
WHILE condition DO
    -- statements
END WHILE;
*/
-- simple while loop example 
DELIMITER //
CREATE PROCEDURE while_example()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE value TEXT DEFAULT "";
    WHILE counter <= 5 DO
        SET value =  CONCAT(value, 'Counter value: ', counter, "\n");					-- I could have written select here but its very bad experience :| trust me 
        SET counter = counter + 1;
    END WHILE;
    SELECT value;
END //
DELIMITER ;

CALL while_example();    -- click on Wrap Cell content to see the whole thing (If you are using MySQL workbench)

-- 2. REPEAT ... UNTIL :  Similar to WHILE, but the condition is checked after the loop body is executed. Ensures the loop body is executed at least once.
# syntax :
/*
	REPEAT
    -- statements
	UNTIL condition
	END REPEAT;
*/

-- simple repeat until example
DELIMITER //
CREATE PROCEDURE repeat_until_example()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE value TEXT DEFAULT "";
    REPEAT 
        SET value =  CONCAT(value, 'Counter value: ', counter, "\n");					
        SET counter = counter + 1;
	UNTIL counter > 5
    END REPEAT;
    SELECT value;
END //
DELIMITER ;

CALL repeat_until_example();

-- 3. LOOP : Executes a block of statements repeatedly.Typically combined with LEAVE to exit the loop.
# syntax
/*
label:LOOP
    -- statements
    LEAVE label; -- Exit loop
END LOOP label;
*/
-- Since we are using a conditional jump statement there must be a condition with IF statement for that
-- simple example of loop 
DELIMITER //
CREATE PROCEDURE loop_example()
BEGIN
	DECLARE counter INT DEFAULT 1;
    DECLARE value TEXT DEFAULT "";
    my_loop : LOOP
		IF counter > 5 THEN 
			LEAVE my_loop;
		END IF;
		SET value = CONCAT(value, "Counter value : ", counter, "\n");
        SET counter = counter + 1;
	END LOOP my_loop; 
    SELECT value;
END //
DELIMITER ;

CALL loop_example();

-- Lets see the examples of LEAVE and ITERATE :
-- LEAVE : Used within LOOP, WHILE, and REPEAT statements to exit the loop based on a condition.
-- ITERATE : Skips the remaining statements in the loop and begins the next iteration but donot exits the loop. 
-- simple example of both LEAVE and ITERATE  
# (I am writing everything in lower case now , I am tired of switching case while writing the queries)
delimiter //
create procedure leave_and_iterate()
begin 
	declare counter int default 1;
    declare result text default "";
	my_loop : LOOP 
		if counter = 3 then					-- If counter becomes 3, skip the iteration and go to next iteration
			set counter = counter + 1;
			iterate my_loop;
		end if;
		if counter > 10 then				-- If counter becomes greater than 10 , exit the loop
			leave my_loop;
		end if;
		set result = concat(result, "Counter value : ", counter, "\n");
        set counter = counter + 1;
	end loop my_loop;
    select result as Leave_example;
end //
delimiter ;

call leave_and_iterate();

# Okay thats it fellas, I think I am super tired right now (perhaps lazy)
# We have seen if-else, different DML statements, also loops and jumping statements, we are on the end of stored procedure now. 
# Untill then, keep helping your friends who are struggling in programming and I will see you next time.
