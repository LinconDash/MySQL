## STATEMENTS WHERE SUBQUERIES CAN BE USED ##
-- We already had gone through select clause so it will not be repeated again
-- Like the select statement, subqueries can also be used in different statements such as the following :

-- see the data 
select * from students;
select * from courses;
select * from enrollments;

## 1. INSERT STATEMENT ##
# Example : Insert a new student into the students table and enroll them in the course with the maximum number of credits.
-- Insert a new student
INSERT INTO students (first_name, last_name, enrollment_date)
VALUES ('Frank', 'Miller', '2022-01-15');

-- Enroll the new student in the course with the maximum credits
INSERT INTO enrollments (student_id, course_id, grade)
VALUES (
    (SELECT DISTINCT student_id FROM students WHERE first_name = 'Frank' AND last_name = 'Miller'),
    (SELECT DISTINCT course_id FROM courses WHERE credits = (SELECT MAX(credits) FROM courses) LIMIT 1),
    'A'
);

-- Now check the data of both students and enrollments as its changed now

## 2. UPDATE STATEMENT ##
# Example : Update the grades of students who are enrolled in 'History' to 'A'.
UPDATE enrollments
SET grade = 'A'
WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'History');

## 3. DELETE STATEMENT ##
# Example : Delete all enrollments of students who are enrolled in 'Biology'.
DELETE FROM enrollments
WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'Biology');
# PS : No hate to BIOLOGY students

-- I think thats all for Subqueries in SQL and there is nothing much left about subqueries , so next we will watch a netflix series,
-- Untill then , Happy Coding !!!