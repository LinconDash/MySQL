-- Since now we have a basic idea of what joins are and how they are implemented , Now lets have a look at 
-- other types of joins that may also be helpful and also its better to know because : "I am forcing you" :|
-- Just kidding , they are not so popular yet helpful for tackling some of the data related problems.
-- Here is a list of the other type of joins which we will see in details :
-- 1. CROSS JOIN
-- 2. SELF JOIN
-- 3. DELETE JOIN
-- 4. UPDATE JOIN

-- Also we will see the difference between union and joins which will give some clarity about them

-- NOTE : We will use the same tables which were created and used in the previous file about JOINS

## CROSS JOIN ##
-- A Cross Join combines each row of the first table with each row of second table. It is a basic type of 
-- inner join that is used to retrieve the Cartesian product (or cross product) of two individual tables 
-- (i.e. permutations).
-- The CROSS JOIN is also known as CARTESIAN JOIN, which provides the Cartesian product of all associated
-- tables. The Cartesian product can be explained as all rows present in the first table multiplied by all 
-- rows present in the second table.Its same as inner join without the joining condition. 
# syntax :
/* SELECT column-lists  
FROM table1  
CROSS JOIN table2  
CROSS JOIN table3
....;
*/

# Example queries :   
select * 
from students as s
cross join courses as c
order by s.student_id;
-- So you can see that every student_id has 12 courses and the reason behind it is "Figure out yourself dumbo.",
-- Just kidding , the reason behind it is since we have 10 rows of data for students and 12 rows of data 
-- for courses so what happens here is for each student we have 12 rows of courses so in total we have 120 rows of data now
-- as cross join is simply the cartesian product.

select s.student_id, s.first_name, s.last_name, c.course_name
from students as s
cross join courses as c
on s.student_id = c.student_id;  
-- See same as inner join

-- Lets join all the three tables (1200 rows of data in total)
select *
from students as s
cross join courses as c
cross join contacts as con
order by s.student_id;

-- Lets use multiple type of joins together (forexample : cross join and left join), and lets answer a question
-- Query the rows that contains students studying every type of course and have contacts of each 
select s.student_id, s.first_name, s.last_name, s.age, s.major, c.course_id, c.course_name, c.instructor, con.phone_number, con.email, con.address
from students as s
cross join courses as c
left join contacts as con
on s.student_id = con.student_id
order by s.student_id;
-- Now every student will learn everything !!
-- Phew !! such a complex query 

## SELF JOIN ##
-- A SELF JOIN is a join that is used to join a table with itself. In the previous sections, we have learned about the joining 
-- of the table with the other tables using different JOINS, such as INNER, LEFT, RIGHT, and CROSS JOIN. However, there is a 
-- need to combine data with other data in the same table itself. In that case, we use Self Join.
-- We can perform Self Join using table aliases. The table aliases allow us not to use the same table name twice with a single 
-- statement. If we use the same table name more than one time in a single query without table aliases, it will throw an error.
-- However, unlike queries of other joins, we use WHERE clause to specify the condition for the table to combine with itself; 
-- instead of the ON clause.
# syntax : 
/* SELECT column_name(s)
FROM table1 a, table1 b
WHERE a.common_field = b.common_field;
*/

-- Lets create junior-senior pairs of each student with every other student
select a.first_name as senior, b.first_name as junior
from students as a , students as b
where a.age > b.age;
-- Interesting , now we can see that Frank has no seniors and therefore his age must be the highest of all
select first_name from students where age = (select max(age) from students);   # Execute it to find who has the highest age
-- Yes, I found Frank has the highest age of all !! 

-- Note : We can also use other JOIN clauses if we want that :-
select a.first_name as senior, b.first_name as junior
from students as a 
right join students as b
on a.age > b.age;

## DELETE JOIN ##
-- DELETE query is a sub-part of data manipulation language used for removing the rows from tables. 
-- It is not an easy process to use the delete join statements in MySQL. In this section, we are going to describe how you 
-- can delete records from multiple tables with the use of INNER JOIN or LEFT JOIN in the DELETE query.
# syntax :
/*
DELETE table(s)
FROM table1 
type_of_JOIN table2
ON table1.common_field = table2.common_field;
*/

-- Lets see , we should delete the courses which are not assigned to any students 
SELECT *
FROM students as s
RIGHT JOIN courses as c
ON s.student_id = c.student_id
WHERE c.student_id is null; 			# Always remember to use is and is not for NULL value comparision as = or <> wont work
-- All of these records are to be deleted now using a delete right join

DELETE courses
FROM students 
RIGHT JOIN courses
ON students.student_id = courses.student_id
WHERE courses.student_id IS NULL ; 

-- we can also delete records from multiple tables as (Dont execute it as everything will be deleted)
DELETE courses, students
FROM students 
INNER JOIN courses
ON students.student_id = courses.student_id;

## UPDATE JOIN ##
-- The UPDATE JOIN is a MySQL statement used to perform cross-table updates that means we can update one table using another
-- table with the JOIN clause condition. This query update and alter the data where more than one tables are joined based on 
-- PRIMARY Key and FOREIGN Key and a specified join condition. We can update single or multiple columns at a time using the UPDATE query.
# syntax : 
/*
UPDATE table1(s)
type_of_JOIN table2 
ON table1.column = table2.column
SET col1 = val1, col2 = val2, ....
WHERE condn;
*/

-- query to let me make my students bright in Computer science . Oops !! 
-- query to change the professor of Computer Science to Prof. Lincon
UPDATE courses c
INNER JOIN students s 
ON c.student_id = s.student_id
SET c.instructor = 'Prof. Lincon'
WHERE s.major = 'Computer Science';

-- See the results : I am your new computer science teacher guyzz ..
select * from courses;

## EXTRAS ##
## Some unpopular joins ##
-- 1. EquiJoin : It joins the tables based on the equality or matching column values in the associated tables ( = is used).
-- 2. Natural Join : It joins the tables based on the same column names and their data types.

-- There is a difference between NATURAL and INNER JOIN 
-- It doesn't need to specify the common column_name of tables also we can see that there is no duplicate attributes of tables
-- in case of natrual join . Here you can see there is not 2 columns having student_id from courses and students
select * 
from students 
natural join courses;

## NATURAL JOIN ##
-- When we combine rows of two or more tables based on a common column between them, this operation is called joining. 
-- A natural join is a type of join operation that creates an implicit join by combining tables based on columns with the same 
-- name and data type. It is similar to the INNER or LEFT JOIN, but we cannot use the ON or USING clause with natural join as 
-- we used in them.

-- Example 
select * 
from students 
natural join courses
natural join contacts;

-- INNER JOIN is not always an EquiJoin.
select *
from students as s
inner join courses as c
on s.student_id < c.course_id;

-- Also one more thing to add is that natural join performs the cross join operation if it doesn't find out the matching column_names and column_datatypes between the tables

-- I think that's it for joins , untill then Happy Coding !!