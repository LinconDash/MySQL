--  The Temporary Tables are the tables that are created in a database to store data temporarily.
--  These tables will be automatically deleted once the current client session is terminated or ends. 
--  In addition to that, these tables can be deleted explicitly if the users decide to drop them manually.
--  You can perform various SQL operations on temporary tables, just like you would with permanent tables, 
--  including CREATE, UPDATE, DELETE, INSERT, JOIN, etc.

## CREATE A TEMPORARY TABLE ##
-- Query to create a temporary table of animals 
CREATE TEMPORARY TABLE ANIMALS(
Animal_id int auto_increment primary key,
Animal_name varchar(200),
Animal_Type varchar(200), 
Animal_Gender varchar(1) check(Animal_Gender = "M" OR Animal_Gender = "F")
);

-- Query to insert data into the temporary table and view it
-- Note creating a temporary table doesn't store it inside any database
INSERT INTO ANIMALS(Animal_name, Animal_Type, Animal_Gender) VALUES("Rio", "Rhino", "M"), ("Fin", "Fox", "M"), ("Rey", "Tiger", "M"), ("Julia", "Cockatoo", "F"), ("Emily", "Crane", "F");
SELECT * FROM ANIMALS;  

-- Lets first create a table of students and then create a temporary table from that
CREATE TABLE STUDENTS(
Id INT AUTO_INCREMENT PRIMARY KEY, 
Student_Name VARCHAR(200) NOT NULL,
Student_grade VARCHAR(1),
Student_age INT CHECK(Student_age >= 0 AND Student_age <= 20)
);
ALTER TABLE STUDENTS AUTO_INCREMENT = 1;  # start the Id auto increment from 1

INSERT INTO STUDENTS(Student_Name, Student_grade, Student_age) VALUES ("Ram", "E", 19), ("Shyam", "A", 18), ("Gopal", "A", 18), ("Linx", "E", 19), ("Lincon", "E", 20), ("Dibya", "E", 20), ("Radha", "E", 18);
SELECT * FROM STUDENTS;

-- Query to create a temporary table from STUDENTS to see the data about only top_students who have E grades only 
CREATE TEMPORARY TABLE top_students 
SELECT Id, Student_Name, Student_age FROM STUDENTS WHERE Student_grade = "E";

-- Lets see the top students
SELECT * FROM top_students;

## DROP A TEMPORARY TABLE ##
-- Query to drop the temporary table top_students
DROP TEMPORARY TABLE top_students;

-- We can also use joins in the query to create temporary tables but it makes more sense later on after learning about JOINS in MYSQL
-- There are 2 types of temporary table global and local , global is accessed by all sessions and local is accessed by only that session which created it.
-- Some users use another syntax to create temp tables using a # infront of table name such as :
-- create table #top_students  creates a local temporay table (without using the temporary keyword)
-- create table ##top_students  creates a global temporay table (without using the temporary keyword)