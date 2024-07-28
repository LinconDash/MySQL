## CLAUSES WHERE SUBQUERIES CAN BE USED ##
-- We have already seen the WHERE clause for the subqueries so , it will not be repeated again
-- Note that we will use the same table i.e students, courses and enrollments for the examples 
-- These are the clauses where subqueries can be used :

-- see the data
select * from students;
select * from courses;
select * from enrollments;

## 1. SELECT Clause subqueries ##
# Example : Get the names of students along with the total number of credits they are enrolled in.
SELECT 
    s.first_name, 
    s.last_name, 
    (SELECT SUM(c.credits)
     FROM courses c
     JOIN enrollments e ON c.course_id = e.course_id
     WHERE e.student_id = s.student_id) AS total_credits
FROM students s;

## 2. JOIN Clause subqueries ##
# Example : List the average grade per course.
SELECT c.course_name, avg_grades.avggrade
FROM courses c
JOIN (
    SELECT course_id, AVG(CASE grade
                          WHEN 'A' THEN 4
                          WHEN 'B' THEN 3
                          WHEN 'C' THEN 2
                          WHEN 'D' THEN 1
                          WHEN 'F' THEN 0
                         END) AS avggrade
    FROM enrollments
    GROUP BY course_id
) avg_grades 
ON c.course_id = avg_grades.course_id;

## 3. FROM Clause subqueries ##
# Example : Find the students who have the highest grade in each course
SELECT 
    s.first_name, s.last_name, c.course_name, e.grade
FROM 
    students s, courses c, enrollments e, (SELECT course_id, MAX(grade) AS max_grade FROM enrollments GROUP BY course_id) AS max_grades
WHERE 
    e.student_id = s.student_id 
    AND e.course_id = c.course_id
    AND e.course_id = max_grades.course_id 
    AND e.grade = max_grades.max_grade;

## 4. HAVING Clause subquery ##
# Example : Find courses that have an average grade higher than overall average grade of overall all courses.
SELECT 
    c.course_name,
    AVG(CASE e.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END) AS avg_grade
FROM 
    courses c
JOIN 
    enrollments e ON c.course_id = e.course_id
GROUP BY 
    c.course_name
HAVING 
    AVG(CASE e.grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
            WHEN 'F' THEN 0
        END) > (SELECT 
                    AVG(CASE e1.grade
                            WHEN 'A' THEN 4
                            WHEN 'B' THEN 3
                            WHEN 'C' THEN 2
                            WHEN 'D' THEN 1
                            WHEN 'F' THEN 0
                        END)
                 FROM 
                    enrollments e1);

-- NOTE : We have only done the examples, but in reality these questions can be pretty efficiently done from various perspectives.
-- However to learn about subqueries its important to know about thier working behaviour.