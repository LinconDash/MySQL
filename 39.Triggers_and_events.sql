# What are Triggers?
-- Triggers are database objects that are automatically executed or fired when certain events occur. 
-- They are used to enforce business rules, automate actions, and maintain data integrity.
-- Generally, a Trigger is defined as a response to an event. In MySQL, a trigger is a special stored procedure that resides in the system catalogue, 
-- that is executed automatically (without being called explicitly like regular stored procedures) whenever an event is performed. 
-- These events include statements like INSERT, UPDATE and DELETE etc.

# Note Triggers are not Events , they are response to Events, we will see events also later on
# Note : There are actually 2 kinds of triggers which are row-level and statement-level, but MySQL only supports row-level triggers.

# Types of Triggers
-- 1. BEFORE Trigger: Executes before an insert, update, or delete operation.
-- 2. AFTER Trigger: Executes after an insert, update, or delete operation.

# The combinations of them form a total of 6 types of triggers 
-- 1. BEFORE UPDATE
-- 2. AFTER UPDATE
-- 3. BEFORE INSERT
-- 4. AFTER INSERT
-- 5. BEFORE DELETE
-- 6. AFTER DELETE

-- CREATE A TRIGGER 
-- we can create trigger using the following syntax :
# syntax : 
/*
CREATE TRIGGER trigger_name
[BEFORE|AFTER] [INSERT|UPDATE|DELETE]
ON table_name FOR EACH ROW
BEGIN
    -- trigger logic
END;
*/
# The syntax is kind of similar to procedures

-- Nice examples actually about triggers are like these : 
# Ex : create a trigger that checks before any insertion in the employees table it should have salary equals 50000, if the inserted salary is less than 50000
delimiter //
create trigger before_insert_salary_check
before insert 
on employees for each row
begin
	if new.salary < 50000 then
		set new.salary = 50000;
	end if;
end //
delimiter ;

# Now lets see what will happen if I insert some employee with salary < 50000
select * from employees;
insert into employees(first_name, last_name, department, salary, hire_date, manager_id) values("Henry", "Stone", "Sales", 40000, curdate(), 1);
# Now lets check the data
select * from employees;
# Yup , so it actually updated the salary to 50000 even if we inserted 40000

# Now lets create an example that shows the use case of triggers in real-world data scenario
-- So we know that at somepoint of time we need to update the salary in a table for some employees but how do we keep track of what are the updates, 
-- for that we can create a update log 
-- create a table salary_log that actually saves all the salary updates logs
create table salary_log(
	employee_id int primary key,
    old_salary decimal(10, 2),
    new_salary decimal(10, 2),
    update_time datetime
)

delimiter //
create trigger after_update_employee
after update on employees
for each row
begin
    insert into salary_log(employee_id, old_salary, new_salary, update_time)
    values(old.employee_id, old.salary, new.salary, NOW());
END //
delimiter ;

# Now lets update some employees salary (Execute each of the updates after some intervals like maybe 10 seconds)
update employees
set salary = salary + 2000
where employee_id = 2;

update employees
set salary = salary + 5000
where employee_id = 6;

update employees
set salary = salary + 10000
where employee_id = 7;

# Now see the magic !!
select * from salary_log;
# Wow , isn't it genius.

-- SEE ALL TRIGGERS
show triggers;

-- DROP A TRIGGER 
-- we can use the drop trigger statement to drop the trigger .
-- Remember by dropping / deleting a trigger , its functions are also deleted
drop trigger before_insert_salary_check;

-- That's all about triggers , lets move onto events in SQL

# What are Events?
-- Events are tasks that run according to a schedule. They are similar to cron jobs in Unix or task scheduler in Windows.
-- They can be used to automate database tasks like backups, cleanup, and periodic updates.
-- Infact they are much more widely used now a days for database automation in some big tech companies.

-- But first make sure that your event scheduler is ON
SET GLOBAL event_scheduler = ON;

-- CREATE AN EVENT
-- we can create a event using this 
/*
CREATE EVENT event_name
ON SCHEDULE [AT timestamp] | [EVERY N DAY / MONTH / YEAR / WEEK STARTS timestamp] 
DO
BEGIN
    -- event logic
END;
*/

-- Ex : create an event that deletes 1 year old records every day from salary_log as we dont want older data 
delimiter //
create event delete_old_records 
on schedule every 1 day
starts '2024-01-01 00:00:00'
do 
begin
	delete from salary_log
    where update_time < now() - interval 1 year;
end //
delimiter ;
# Now just wait for a year to see the result , Just Kidding , it will work automatically !!

-- SEE ALL events
show events;

-- ALTER EVENT
alter event delete_old_records
on schedule every 1 week 
starts now();

-- DROP EVENTS
-- If the event is scheduled using a particular timestamp [AT timestamp] then it will automatically be deleted after the timestamp specified 
-- But recurring event are deleted manually using drop event statement
drop event delete_old_records;  

### THEORY TIME ###
-- Practical Use Cases
-- 1. Triggers :
/*		
		1. Audit Logs: Automatically log changes to critical tables.
		2. Validation: Enforce business rules before allowing changes to data.
		3. Cascading Changes: Automatically update or delete related records in other tables.
*/

-- 2. Events :
/*
		1. Database Maintenance: Automate tasks like optimizing tables, backing up data, and purging old records.
		2. Data Aggregation: Periodically summarize data for reporting purposes.
		3. Email Notifications: Send scheduled reports or alerts.
*/


# I think That's all for the most advanced and practical concept of SQL
# Only one concept is left to finish the marathon of SQL about SQL functions, which we will see later on
# Untill then, keep playing with children to boost confidence in games, and I will meet you with a new topic !!!