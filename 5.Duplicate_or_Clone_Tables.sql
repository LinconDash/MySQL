--  MySQL copy or clone table is a feature that allows us to create a duplicate table of an existing table,
--  including the table structure, indexes, constraints, default values, etc. Copying data of an existing table 
--  into a new table is very useful in a situation like backing up data in table failure. It is also advantageous 
--  when we need to test or perform something without affecting the original table, for example, replicating the production data for testing.

## CREATE A COPY TABLE OF THE ORIGINAL TABLE STUDENTS ##
-- so we can create a copy table using the CREATE, SELECT and INSERT commmands
CREATE TABLE IF NOT EXISTS STUDENTS_COPY_1 
SELECT * FROM STUDENTS;

-- It is to be noted that this statement only copies the table and its data. 
-- It doesn't copy all dependent objects of the table, such as indexes, triggers, primary key constraints, foreign key constraints, etc.
-- So the command of copying data along with its dependent objects from an existing to the new table can be written as the following statements:

-- This is a better version of creating a copy table, we can also use conditions statements here
CREATE TABLE STUDENTS_COPY_2 LIKE STUDENTS;
INSERT INTO STUDENTS_COPY_2 SELECT * FROM STUDENTS;

-- We can create a copy table from another database using this syntax :
-- CREATE TABLE destination_db.new_table_name LIKE source_db.existing_table_name;  
-- INSERT destination_db.new_table_name SELECT * FROM source_db.existing_table_name; 

-- create the duplicate of sakila.actors
create table practice.sakila_actor_copy like sakila.actor;
insert practice.sakila_actor_copy select * from sakila.actor;
