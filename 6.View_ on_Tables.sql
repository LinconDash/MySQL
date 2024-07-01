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


## SOME EXTRA POINTS IF YOU WANT TO KNOW MORE ABOUT VIEWS ##
-- Note there are many things to do with views but this worksheet only contains some of them 
-- Rules while creating a query using the replace syntax:
-- 1. order of columns should be same , if new column are to be added in the view than add as a last column
-- 2. cannot change the name of the columns 
-- 3. cannot change the datatype of a column

-- Also a point worth mentioning that there are some rules while creating the views that if a view is created on a base_table and then some new columns
-- are added to the base_table then we cannot see it in the view because it can only capture the structure based upon which it is built. So for that reason we
-- have to use the create or replace syntax . But if any new row is added to the base_table then the view can easily capture that.
-- So its better to write the view and create or replace view and execute it again whenever there is a new structure changes occurs on a base_table

-- While updating a view like changing the value of a cell in the table or something like this can actually gets reflected back in the base_table
-- therefore its not at all recommended to update the view where we change the value , but this doesn't happens when a view is created from more than one table
-- Also a view is not updatable if its created from a group by query or a query where distinct clause is used.
-- If query contains a CTE or WITH clause then also we cannot update the views
-- If query contains a window function then also we cannot update the views

-- Views donot contibute to query performance optimizations such as indexes but there is another type of view called Materialized views 
-- that help in that which we will not be able to see because in MySQL materialized views are not supported. 