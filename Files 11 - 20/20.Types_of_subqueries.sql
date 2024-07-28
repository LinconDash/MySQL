-- Now that we have a proper idea about subqueries , we will look into some more concepts of subqueries:

-- Types of Subqueries :
-- 1. Single-row subqueries: Return a single row and are used with operators like =, <, >, etc.
-- 2. Multiple-row subqueries: Return multiple rows and are used with operators like IN, ANY, ALL, etc.
-- 3. Multiple-column subqueries: Return multiple columns and are typically used in IN or as part of a row comparison.
-- 4. Correlated subqueries: Refer to columns in the outer query and execute once for each row processed by the outer query.
-- 5. Non-correlated subqueries: Do not refer to any columns in the outer query and execute independently.

-- Apart from that we will also look at the statements and clauses that can be used for subqueries like SELECT, INSERT, etc statements
-- and FROM, WHERE, etc. clauses

-- Note: we will use the same tables students, courses and enrollments tables for the purpose of learning the subqueries
-- see the data
select * from students;
select * from courses;
select * from enrollments;

## TYPES OF SUBQUERIES ##
## 1. Single-row subqueries ##
-- Return a single row and are used with operators like =, <, >, etc.
# Example : Find the date which enrolled in the school after the first enrollment in the school , i.e the second enrollment date
SELECT MIN(enrollment_date) as second_enrollment
FROM students
WHERE enrollment_date > (SELECT MIN(enrollment_date) FROM students);

## 2.  Multiple-row subqueries ##
-- Return multiple rows and are used with operators like IN, ANY, ALL, etc.
# Example : Find students who are enrolled in the same courses as 'Alice Smith'.
SELECT student_id, first_name, last_name
FROM students
WHERE student_id IN (
    SELECT DISTINCT student_id
    FROM enrollments
    WHERE course_id IN (SELECT course_id FROM enrollments WHERE student_id = (SELECT student_id FROM students WHERE first_name = 'Alice' AND last_name = 'Smith'))  -- subquery inside a subquery
);

# comments :
-- What the heck is this !!! . I know it also took me 1 minute to write this subquery . JOINS were much easier than this .
# Note : This can be simply done using JOINS but We are in subqueries so I am avoiding JOINS

## 3. Multiple-column subqueries ##
-- Return multiple columns and are typically used in IN or as part of a row comparison.
# Example : Find the students who are enrolled in the same courses with the same grade as 'Alice Smith'.
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE (e.course_id, e.grade) IN (
    SELECT e2.course_id, e2.grade
    FROM enrollments e2
    WHERE e2.student_id = (SELECT student_id FROM students WHERE first_name = 'Alice' AND last_name = 'Smith')
);

## 4. Correlated subqueries ##
-- Refer to columns in the outer query and execute once for each row processed by the outer query.
# Example : Find students who have received a grade better than the average grade in their courses. 
-- (Assume grades can be translated to numerical values where 'A' = 4, 'B' = 3, 'C' = 2, 'D' = 1, 'F' = 0).
SELECT s.student_id, s.first_name, s.last_name, e.grade
FROM students as s
JOIN enrollments as e
ON s.student_id = e.student_id
WHERE (CASE e.grade
		WHEN 'A' THEN 4
        WHEN 'B' THEN 3
        WHEN 'C' THEN 2
        WHEN 'D' THEN 1
        WHEN 'F' THEN 0
      END) > (
    SELECT AVG(CASE e2.grade
               WHEN 'A' THEN 4
               WHEN 'B' THEN 3
               WHEN 'C' THEN 2
               WHEN 'D' THEN 1
               WHEN 'F' THEN 0
             END)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id		# So here you can see that there is a dependency from outer query therefore its a correlated subquery
);

-- Example : Find the courses that are not enrolled by any of the students
-- (First delete one of the record of enrollments to proceed)
select * 
from courses as c 
where not exists (select 1 from enrollments e where c.course_id = e.course_id);

## 5. Non-correlated subqueries ##
-- Do not refer to any columns in the outer query and execute independently.
# Example : Find the course with the highest number of enrollments.
SELECT course_id, course_name
FROM courses
WHERE course_id = (SELECT course_id FROM enrollments GROUP BY course_id ORDER BY COUNT(*) DESC LIMIT 1);

# I think we should also have some knowledge about where the subqueries can be used , or in particular which statement or clauses allows subqueries
# Up next, we will do these things and also discuss about some games to kill boredom, Just kidding , Untill then Happy Coding !!!