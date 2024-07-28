-- The constraint in MySQL is used to specify the rule that allows or restricts what values/data will be stored in the table.
-- They provide a suitable method to ensure data accuracy and integrity inside the table. 
-- It also helps to limit the type of data that will be inserted inside the table. 
-- If any interruption occurs between the constraint and data action, the action is failed.

-- Constraints in MySQL is classified into two types:
-- Column Level Constraints: These constraints are applied only to the single column that limits the type of particular column data.
-- Table Level Constraints: These constraints are applied to the entire table that limits the type of data for the whole table.

-- We can define the constraints during a table created by using the CREATE TABLE statement.
-- CREATE TABLE new_table_name (  
--     col_name1 datatype constraint,  
--     col_name2 datatype constraint,  
--     col_name3 datatype constraint,  
--     .........  
-- );  

-- The following are the most common constraints used in the MySQL: NOT NULL , CHECK , DEFAULT , PRIMARY KEY , AUTO_INCREMENT , UNIQUE , ENUM , FOREIGN KEY, INDEX (will see this later)
-- Note : Some of them can be used as table constraints but we generally ignore using table constraints

## NOT NULL CONSTRAINT ##
-- This constraint specifies that the column cannot have NULL or empty values. 

## CHECK CONSTRAINT ##
-- It controls the value in a particular column. It ensures that the inserted value in a column must be satisfied with the given condition.
-- In other words, it determines whether the value associated with the column is valid or not with the given condition.

## DEFAULT CONSTRAINT ##
-- This constraint is used to set the default value for the particular column where we have not specified any value. It means the column must contain a value, including NULL.

## UNIQUE CONSTRAINT ##
-- This constraint ensures that all values inserted into the column will be unique. It means a column cannot stores duplicate values. 
-- MySQL allows us to use more than one column with UNIQUE constraint in a table.

## AUTO_INCREMENT CONSTRAINT ##
-- This constraint automatically generates a unique number whenever we insert a new record into the table. Generally, we use this constraint for the primary key field in a table.

## PRIMARY KEY CONSTRAINT ##
-- This constraint is used to identify each record in a table uniquely. If the column contains primary key constraints, then it cannot be null or empty.
-- A table may have duplicate columns, but it can contain only one primary key. It always contains unique value into a column.

## FOREIGN KEY CONSTRAINT ##
-- This constraint is used to link two tables together. It is also known as the referencing key. A foreign key column matches the primary key field of another table. 
-- It means a foreign key field in one table refers to the primary key field of another table.

## ENUM CONSTRAINT ##
-- The ENUM data type in MySQL is a string object. It allows us to limit the value chosen from a list of permitted values in the column specification at the time of table creation.
-- It is short for enumeration, which means that each column may have one of the specified possible values. It uses numeric indexes (1, 2, 3…) to represent string values.

# NOW LETS APPLY ALL OF THE CONSTRAINTS IN A TABLE CREATION
CREATE TABLE CUSTOMERS(
	Cust_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,								-- primary key , not null and auto-increment constraints
    Cust_name VARCHAR(20) NOT NULL,													
    Cust_age INT CHECK(Cust_age >= 18 AND Cust_age <= 90),							-- check constraint
    Cust_email VARCHAR(100) DEFAULT NULL UNIQUE,									-- default and unique constraint (default value is NULL in the column)
    Cust_dob DATE DEFAULT NULL,																											
    Cust_phone BIGINT NOT NULL,
    Shirt_size ENUM("Small", "Medium", "Large", "Extra-Large")						-- enum constraint (column should contain any one of those values specified)
);

# Lets create another table for foreign key constraint
CREATE TABLE ORDERS(
	Order_id int NOT NULL PRIMARY KEY,  											
    Order_Num int NOT NULL,  
    Cust_id int,  
    FOREIGN KEY (Cust_id) REFERENCES CUSTOMERS(Cust_id)  							-- Foreign Key constraint
);	


insert into customers(Cust_name, Cust_age, Cust_email, Cust_phone, Shirt_size) values
("Ajay", 27, "ajay@xyz.com",1213314421, "Large"),
("Bijay", 37, "bijay@xyz.com",1233214431, "Large"),
("Chatur", 47, "chatur@xyz.com",123243211, "Extra-Large"),
("Dalal", 29, "dalal@xyz.com", 3243121212, "Medium");

select * from customers;







