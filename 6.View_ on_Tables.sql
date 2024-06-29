-- A view is a database object that has no values. Its contents are based on the base table.
-- It contains rows and columns similar to the real table. In MySQL, the View is a virtual table created
-- by a query by joining one or more tables. It is operated similarly to the base table but does not contain 
-- any data of its own. The View and table have one main difference that the views are definitions built on 
-- top of other tables (or views). If any changes occur in the underlying table, the same changes reflected 
-- in the View also.

## CREATE A VIEW ##
-- A view can be created using the create view command , we can also use replace to avoid update that view if created already
-- query to create a view from students table for only top students
CREATE OR REPLACE VIEW top_students AS
SELECT * 
FROM students
WHERE Student_grade = "E";

## SHOW THE VIEW ##
## NOTE : It is essential to know that a view does not store the data physically. 
-- When we execute the SELECT statement for the view, MySQL uses the query specified in the view's definition
-- and produces the output. Due to this feature, it is sometimes referred to as a virtual table.

-- query to see the top_students view
select * from top_students;

## UPDATE THE VIEW ##
-- query to update the view using alter command 
alter view top_students as
select * from students
where Student_grade = "E" and Student_age >= 19;

# see the results after updating 
select * from top_students;

## RENAME A VIEW ##
-- The MySQL RENAME TABLE statement in MySQL is generally used to rename the name of a table. 
-- But this statement can also be used to rename views because views are typically virtual tables created by a query.
RENAME TABLE top_students TO top_students_above_18;

## DROP THE VIEW ##
DROP VIEW IF EXISTS top_students;

## CREATE A VIEW BY TWO TABLES ##
## Demo code only :
-- CREATE VIEW Trainer       
-- AS SELECT c.course_name, c.trainer, t.email       
-- FROM courses c, contact t   
-- WHERE c.id = t.id; 

-- Note there are many things to do with views but this worksheet only contains some of them 
-- Also a point worth mentioning that there are some rules while creating the views that if a view is created on a base_table and then some new columns
-- are added to the base_table then we cannot see it in the view because it can only capture the structure based upon which it is built. So for that reason we
-- have to use the create or replace syntax . But if any new row is added to the base_table then the view can easily capture that.
-- So its better to write the view and create or replace view and execute it again whenever there is a new structure changes occurs on a base_table