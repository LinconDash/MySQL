-- Exercise : Write a procedure that can print star pattern by the specified no. of rows 
-- Ex : n = 5
/*
*
**
***
****
*****
*/
delimiter //
create procedure star_pattern(n int)
begin
	declare i int default 1;
    declare j int;
    declare res text default '';
    
    while i <= n do 
		set j = 1;
        while j <= i do
			set res = concat(res, '*');
            set j = j + 1;
		end while;
        set res = concat(res, '\n');
        set i = i + 1;
	end while;
    select res;
end //
delimiter ;

-- see the magic
call star_pattern(5);

-- Your exercise : Now reverse the pattern and print it . Its very easy, trust me 
/*
*****
****
***
**
*
*/

# How to Drop / Delete a procedure #
-- Making procedure is good but we know that storing multiple procedures can lead to memory explosion :)
-- So we can drop the useless procedures using the DROP PROCEDURE command
drop procedure if exists star_pattern;   

# Exception Handling in procedure #
-- Exception handling in stored procedures is crucial for managing and controlling the flow of operations, especially when an error occurs.
-- In MySQL, you can handle exceptions using the DECLARE ... HANDLER statement. 
-- There are different types of handlers you can declare, such as CONTINUE, EXIT, and UNDO.
-- You can also declare objects such as Cursors, but we will see them later on.
# syntax : DECLARE handler_type HANDLER FOR condition VALUE statement;
-- handler_type: This can be CONTINUE (continue execution after handling the exception), EXIT (exit the current compound statement), or UNDO (not supported in MySQL, typically used in other SQL implementations).
-- condition: This specifies the condition that triggers the handler, such as SQLEXCEPTION, SQLWARNING, NOT FOUND, or a specific error code.
-- statement: This is the statement or block of statements that executes when the condition is met

# Let me show you how to handle SQL exceptions
delimiter //
create procedure  update_salary(id INT, percent DECIMAL(5, 2))
begin 
    DECLARE EXIT HANDLER FOR NOT FOUND
    BEGIN
        -- Raise an error if employee ID not found
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID not found';
    END;
	
    IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = id) THEN
        -- If employee ID does not exist, raise an error
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee ID not found';
    ELSE
        -- Update the employee's details
        UPDATE employees
        SET salary = salary + percent * salary
        WHERE employee_id = id;
	END IF;
end //
delimiter ;

call update_salary(1, 0.1); 
call update_salary(101, 0.1); # You can see those error messages have been changed 

-- Now we could also have a EXIT handler type for SQL EXCEPTION but I am a bit lazy !!
-- Anyways these are not that much helpful , since we have a general purpose programming language for that purposes.

# Thats it for this session dude, lets be honest , creating procedure is fun yet exhausting !
# Untill then , just order a cheezzy pizza , and don't forget Happy Coding !!