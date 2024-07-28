-- There are two ways to writing a query from multiple tables :
-- 1. Joining the tables using SQL JOINS
-- 2. Without Joining the tables , using commas "," in the FROM clause

-- Lets first create two tables and make some entries so that we can understand it properly :
-- Create departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Sales');

INSERT INTO employees (employee_id, employee_name, department_id, salary) VALUES
(1, 'Alice', 1, 60000.00),
(2, 'Bob', 2, 70000.00),
(3, 'Charlie', 3, 80000.00),
(4, 'David', 4, 50000.00),
(5, 'Eve', 5, 75000.00),
(6, 'Frank', 3, 85000.00),
(7, 'Grace', 1, 55000.00),
(8, 'Heidi', 4, 65000.00),
(9, 'Ivan', 2, 72000.00),
(10, 'Judy', 5, 77000.00);

-- view the data in both the tables
select * from employees;
select * from departments;

-- Lets first see how to look at data without joins  (Implicit JOINS)
select e.employee_id, e.employee_name, e.department_id, d.department_name 
from employees as e, departments as d
where e.department_id = d.department_id
order by e.employee_id;							# Donot leave the order by as without it the departments are stacked according to the departments table

-- Lets use the JOIN clause and see what does the result look like (Explicit JOINS)
select e.employee_id, e.employee_name, e.department_id, d.department_name 
from employees as e join departments as d
on e.department_id = d.department_id
order by e.employee_id;

# I know that there is nothing different in both results but there are some huge differences in the backend :
-- 1. Readability and Maintainability of the JOIN query is much better escpecially in the case of complex queries 
-- 2. The explicit JOIN syntax is part of the SQL-92 standard and is more commonly used in modern SQL. It is preferred for its clarity and structure.
-- 3.  Explicit JOIN syntax is versatile and can clearly specify different types of joins 
-- 4. Most important point , explicit joins can sometimes provide better optimization hints to the database engine, especially in more complex queries.

# So always prefer to use the explicit JOINS whenever required 
# Now we can peacefully learn about JOINS : ) 

## JOIN Clause ##
-- A Join clause in MySQL is used to combine records from two or more tables in a database. These tables are joined together based on a
-- condition, specified in a WHERE clause.
-- For example, comparing the equality (=) of values in similar columns of two different tables can be considered as a join-predicate. 
-- In addition, several operators can be used to join tables, such as <, >, <>, <=, >=, !=, BETWEEN, LIKE, and NOT etc.
-- We can use JOINS in the SELECT, UPDATE and DELETE statements to join the MySQL tables.
-- It is performed whenever you need to fetch records from two or more tables.
-- There are mainly 2 JOINS : INNER and OUTER but its subdivided into further more :
 
-- There are many kinds of JOINS in SQL but these four are more important :
-- INNER JOIN (or sometimes called simple join)       
-- LEFT OUTER JOIN (or sometimes called LEFT JOIN)
-- RIGHT OUTER JOIN (or sometimes called RIGHT JOIN)
-- FULL OUTER JOIN
-- Other types of JOINS are also there which we will discuss after this session

-- But before going onto the queries lets create 3 tables for practicing JOINS and types of JOINS :
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    major VARCHAR(50),
    enrollment_year INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    department VARCHAR(50),
    credits INT,
    instructor VARCHAR(50),
    student_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

CREATE TABLE contacts (
    contact_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (first_name, last_name, age, major, enrollment_year) VALUES
('Alice', 'Smith', 20, 'Computer Science', 2022),
('Bob', 'Johnson', 22, 'Mathematics', 2021),
('Charlie', 'Williams', 21, 'Physics', 2020),
('David', 'Brown', 23, 'Chemistry', 2019),
('Eve', 'Jones', 22, 'Biology', 2021),
('Frank', 'Garcia', 24, 'History', 2018),
('Grace', 'Martinez', 21, 'English', 2020),
('Hank', 'Rodriguez', 22, 'Philosophy', 2019),
('Ivy', 'Wilson', 23, 'Art', 2018),
('Jack', 'Taylor', 20, 'Economics', 2022);

INSERT INTO courses (course_name, department, credits, instructor, student_id) VALUES
('Database Systems', 'Computer Science', 4, 'Prof. Adams', 1),
('Algebra', 'Mathematics', 3, 'Prof. Baker', 2),
('Quantum Mechanics', 'Physics', 4, 'Prof. Clark', 3),
('Organic Chemistry', 'Chemistry', 4, 'Prof. Davis', 4),
('Genetics', 'Biology', 3, 'Prof. Evans', NULL),
('World History', 'History', 3, 'Prof. Foster', 6),
('Shakespearean Literature', 'English', 3, 'Prof. Green', 7),
('Ethics', 'Philosophy', 3, 'Prof. Harris', 8),
('Modern Art', 'Art', 3, 'Prof. Jackson', NULL),
('Microeconomics', 'Economics', 3, 'Prof. King', 10),
('Advanced Physics', 'Physics', 4, 'Prof. Clark', NULL),
('Medieval Literature', 'English', 3, 'Prof. Green', NULL);

INSERT INTO contacts (student_id, phone_number, email, address, emergency_contact_name, emergency_contact_phone) VALUES
(1, '123-456-7890', 'alice.smith@example.com', '123 Elm Street', 'John Smith', '987-654-3210'),
(2, '234-567-8901', 'bob.johnson@example.com', '456 Oak Street', 'Jane Johnson', '876-543-2109'),
(3, '345-678-9012', 'charlie.williams@example.com', '789 Pine Street', 'Robert Williams', '765-432-1098'),
(4, '456-789-0123', 'david.brown@example.com', '101 Maple Avenue', 'Susan Brown', '654-321-0987'),
(5, '567-890-1234', 'eve.jones@example.com', '202 Birch Lane', 'Michael Jones', '543-210-9876'),
(6, '678-901-2345', 'frank.garcia@example.com', '303 Cedar Court', 'Laura Garcia', '432-109-8765'),
(7, '789-012-3456', 'grace.martinez@example.com', '404 Redwood Drive', 'James Martinez', '321-098-7654'),
(8, '890-123-4567', 'hank.rodriguez@example.com', '505 Spruce Way', 'Emily Rodriguez', '210-987-6543'),
(9, '901-234-5678', 'ivy.wilson@example.com', '606 Willow Road', 'Steven Wilson', '109-876-5432'),
(10, '012-345-6789', 'jack.taylor@example.com', '707 Cypress Circle', 'Karen Taylor', '098-765-4321');

-- see the data first
select * from students;
select * from courses;
select * from contacts;

## INNER JOIN ##
-- Inner Join is a type of join that is used to combine records from two related tables, based on common columns from both the tables.
-- These tables are joined together on a specific condition. If the records in both tables satisfy the condition specified, they are combined.
-- This is a default join; that is, even if the JOIN keyword is used instead of INNER JOIN, tables are joined using matching records of 
-- common columns. They are also referred to as an "Equijoin".
# syntax : 
/* SELECT columns  
FROM table1  
INNER JOIN table2 ON condition1  
INNER JOIN table3 ON condition2  
...;  
*/

# Example queries:
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students as s
INNER JOIN courses as c 
ON s.student_id = c.student_id;      
-- So you can see that there is no 5 and 9 in student_id because it was not present in the courses foreign key column 
-- Since the INNER JOIN is the default one , we can write it as on JOIN also
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students s
JOIN courses c 
ON s.student_id = c.student_id;  
-- Both the above syntax is same for INNER JOIN
-- EXTRA : Sometimes, the name of the columns is the same in both the tables. In that case, we can use a USING keyword to access the records.
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students s
JOIN courses c 
USING (student_id);

-- INNER JOIN of 3 tables together
SELECT s.student_id, s.first_name, s.last_name, c.course_name, c.department, c.credits, con.phone_number, con.email
FROM students as s
INNER JOIN courses as c ON s.student_id = c.student_id
INNER JOIN contacts as con ON s.student_id = con.student_id;
-- Again there is no 5 and 9 in student_id because it was not present in the courses foreign key column . Are they even students ?

## LEFT OUTER JOIN (or simply LEFT JOIN) ##
-- Left Join is a type of outer join that retrieves all the records from the first table and matches them to the records in second table.
-- If the records in left table do not have their counterparts in the second table, NULL values are added.
-- But, if the number of records in first table is less than the number of records in second table, the records in second table 
-- that do not have any counterparts in the first table will be discarded from the result.
# synax:
/* SELECT columns    
FROM table1    
LEFT [OUTER] JOIN table2    			
ON Join_Condition; 
*/
-- For simplicity : left join = inner join + additional records in left table 

-- After seeing the result you can understand what the real difference is 
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students as s
LEFT JOIN courses as c
ON s.student_id = c.student_id;

-- Lets left join 3 tables together
SELECT s.student_id, s.first_name, s.last_name, c.course_name, c.department, c.credits, con.phone_number, con.email
FROM students as s
LEFT JOIN courses as c ON s.student_id = c.student_id
LEFT JOIN contacts as con ON s.student_id = con.student_id;

## RIGHT OUTER JOIN (or simply RIGHT JOIN) ##
-- The Right Join or Right Outer Join query in MySQL returns all rows from the right table, 
-- even if there are no matches in the left table. So, if zero records are matched in the left table,
-- the right join will still return a row in the result, but with a NULL value in each column of the left table.
# syntax :
/* SELECT column_list  
FROM Table1  
RIGHT [OUTER] JOIN Table2   
ON join_condition;
*/
-- For simplicity : right join = inner join + additional records in right table 

-- Watch the difference between the left and right join closely
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students s
RIGHT JOIN courses c 
ON s.student_id = c.student_id;

## FULL OUTER JOIN ##
-- Full Join creates a new table by joining two tables as a whole. The joined table contains all records from both the tables 
-- and fill in NULLs for missing matches on either side. In short, full join is a type of outer join that combines the results 
-- of both left and right joins.
-- NOTE :
-- In MySQL, there is no provision to perform full join operation. We can, however, imitate this operation to produce the same results.
-- The result-set obtained from performing full join is a union of result-sets obtained from left join and right join.
-- Thus, we can first retrieve result-sets from left and right join operations and combine them using the UNION keyword.
-- But, this method only works for cases where duplicate records are non-existent. If we want to include the duplicate rows, 
-- using UNION ALL keyword to combine the result-sets is preferred.
# syntax :
/* 
SELECT table1.column1, table2.column2...
FROM table1
LEFT JOIN table2
ON table1.common_field = table2.common_field

[UNION | UNION ALL]

SELECT table1.column1, table2.column2...
FROM table1
RIGHT JOIN table2
ON table1.common_field = table2.common_field;
*/

-- Lets see the full outer join of 2 tables first with UNION (without duplicates)
SELECT students.student_id, students.first_name, courses.course_name
FROM students
LEFT JOIN courses ON students.student_id = courses.student_id
UNION
SELECT students.student_id, students.first_name, courses.course_name
FROM students
RIGHT JOIN courses ON students.student_id = courses.student_id;

-- Lets see the full outer join of 2 tables first with UNION ALL (with duplicates)
SELECT students.student_id, students.first_name, courses.course_name
FROM students
LEFT JOIN courses ON students.student_id = courses.student_id
UNION ALL
SELECT students.student_id, students.first_name, courses.course_name
FROM students
RIGHT JOIN courses ON students.student_id = courses.student_id; 

-- Now full outer join of all tables
SELECT s.student_id, s.first_name, s.last_name, c.course_name, c.department, c.credits, con.phone_number, con.email
FROM students s
LEFT JOIN courses c ON s.student_id = c.student_id
LEFT JOIN contacts con ON s.student_id = con.student_id

UNION

SELECT s.student_id, s.first_name, s.last_name, c.course_name, c.department, c.credits, con.phone_number, con.email
FROM students s
RIGHT JOIN courses c ON s.student_id = c.student_id
RIGHT JOIN contacts con ON s.student_id = con.student_id;

## Up next we have other types of JOINS , untill then happy coding !! 