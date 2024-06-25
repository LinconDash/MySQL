-- A subquery, also known as an inner query or nested query, is a query within another SQL query and embedded within 
-- the WHERE clause, FROM clause, JOIN clause or SELECT clause of another SQL query. Subqueries are used to perform operations 
-- in multiple steps, such as filtering, calculating, or organizing data to provide results for the outer query.
-- Also subquery in MySQL can be embedded with SELECT, INSERT, UPDATE or DELETE statement along with the various operators. 
-- We can also nest the subquery with another subquery. A subquery is known as the inner query, and the query that contains
-- subquery is known as the outer query.
-- The inner query executed first gives the result to the outer query, and then the main/outer query will be performed. 
-- MySQL allows us to use subquery anywhere, but it must be closed within parenthesis. 
-- All subquery forms and operations supported by the SQL standard will be supported in MySQL also.

# Why we use subqueries ?
-- 1. The subqueries make the queries in a structured form that allows us to isolate each part of a statement.
-- 2. The subqueries provide alternative ways to query the data from the table; otherwise, we need to use complex joins and unions.
-- 3. The subqueries are more readable than complex join or union statements.

# Rules for subqueries
-- 1. Subqueries should always use in parentheses.
-- 2. The main query that have multiple columns for subquery, then a subquery will also have that many no. of columns in the SELECT command as specified by main query.
-- 3. We can use various comparison operators with the subquery, such as >, <, =, IN, ANY, SOME, and ALL.A multiple-row operator is very useful when the subquery returns more than one row.
-- 4. We cannot use the ORDER BY clause in a subquery, although it can be used inside the main query.
-- 5. If we use a subquery in a set function, it cannot be immediately enclosed in a set function.

# Too much theory , lets dive into practical applications
# Before using subqueries, I would like to create some tables that are helpful for using subqueries and also I am bored with using the repeated tables :) 
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    enrollment_date DATE
);
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT
);
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Inserting data
INSERT INTO students (first_name, last_name, enrollment_date) VALUES
('Alice', 'Smith', '2021-08-15'),
('Bob', 'Johnson', '2020-09-03'),
('Charlie', 'Williams', '2021-06-23'),
('David', 'Brown', '2019-09-12'),
('Eve', 'Jones', '2021-01-19');

alter table courses auto_increment=1;
INSERT INTO courses (course_name, credits) VALUES
('Mathematics', 3),
('History', 4),
('Biology', 4),
('Computer Science', 3),
('Art', 2);

alter table enrollments auto_increment=1;
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A'),
(2, 3, 'C'),
(3, 4, 'B'),
(4, 2, 'B'),
(4, 3, 'A'),
(5, 4, 'A'),
(5, 5, 'B');

-- see the data
select * from students;
select * from courses;
select * from enrollments;

-- Lets see an example question of a query : Find the students who has a grade A in any course
SELECT first_name, last_name
FROM students
WHERE student_id IN (SELECT DISTINCT student_id FROM enrollments WHERE grade="A");

-- The above subquery you see falls into the category of multiple-row subquery , which we will see on the next part
-- Untill then find out if there are any queries which can make your day happy , I've got one for you :
-- SELECT pizza, games, movies FROM life WHERE disturbance = NULL;
-- Also , Happy Coding !!!