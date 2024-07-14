### CURSORS in SQL ###
-- A cursor in database is a construct which allows you to iterate/traversal the records of a table. 
-- In MySQL you can use cursors with in a stored program such as procedures, functions etc.
-- In other words, you can iterate though the records of a table from a MySQL stored program using the cursors.
-- The cursors are read-only, Non-Scrollable and Asenitive in MySQL. 

-- To use a cursor, you need to follow the steps given below (in the same order)
-- 1. Declare the cursor using the DECLARE Statement.
-- 2. Declare variables and conditions.
-- 3. Open the declared cursor using the OPEN Statement.
-- 4. Retrieve the desired records from a table using the FETCH Statement.
-- 5. Finally close the cursor using the CLOSEstatement.

-- A cursor in stored procedure or function is used to iterate through the result set obtained from the SELECT statement and process each row accordingly.
-- This is useful when you need to perform operations on each row of a result set individually, such as calculations, conditional logic, or executing statements
-- that depend on the data in each row.

-- Example of Cursor process
/*
1. DECLARE cursor_name CURSOR FOR SELECT_statement
2. OPEN cursor_name
3. DECLARE CONTINUE HANDLER FOR NOT FOUND   (termination statement)
4. FETCH cursor_name INTO variables list
5. CLOSE cursor_name
*/

# Cursors are generally used for performing complex logical calculation in row wise manner.
# However we donot have such example so let me show you how to transfer data from one table to another using the cursors (row-wise data transfer)
-- Lets say we will transfer the data from employees table to backup table
CREATE TABLE `backup` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `manager_id` int DEFAULT NULL,
  PRIMARY KEY (`employee_id`)
)  
# you might be wondering why `xyz` is used as a format, well this is one of the formats we can use while specifying words those are actually keywords (backup is a keyword)
select * from `backup`;

delimiter //
create procedure transfer()
begin
	declare flag int default 0;
    declare empID, managerID int;
    declare fName, lName, dept varchar(50);
    declare sal decimal(10, 2);
    declare hire_date date;
    
    # Now decalre a cursor
    declare cur cursor for select * from employees;
    declare continue handler for not found set flag = 1;
    
    open cur;
    my_loop : LOOP
		if flag = 1 then
			leave my_loop;
		end if;
        
		fetch cur into empID, fName, lName, dept, sal, hire_date, managerID;
        insert into backup values(empID, fName, lName, dept, sal, hire_date, managerID);
        
	end loop my_loop;
    close cur;
end //
delimiter ;

call transfer();

-- Now lets check our backup table
select * from backup;
-- Perfecto !!!


# Again there are lot of things about cursors , but they are not significant from my perspective, if you want you can explore it.
# Thats all about cursors , Untill then create a beautiful painting of sunset and also Happy Coding !!