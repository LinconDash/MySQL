## UNIQUE KEY ##
-- A unique key in MySQL is a single field or combination of fields that ensure all values going to store into the 
-- column will be unique. It means a column cannot stores duplicate values.  For example, the email addresses and 
-- roll numbers of students in the "student_info" table or contact number of employees in the "Employee" table 
-- should be unique.
-- MySQL allows us to use more than one column with UNIQUE constraint in a table. It can accept a null value, but
-- MySQL allowed only one null value per column. It ensures the integrity of the column or group of columns to 
-- store different values into a table.

-- example :
CREATE TABLE Students(  
    Stud_ID int,   
    Roll_No int,  
    Name varchar(45) NOT NULL,   
    Email varchar(45),  
    Age int,   
    City varchar(25),  
    CONSTRAINT uc_rollno_email UNIQUE(Roll_No, Email)  
);  
show indexes from Students;
-- we can also add constraint and drop constraint using alter table statement but I am lazzyyyy ...
-- Just kidding , here it is how to do this using the alter table statement
# syntax : ALTER TABLE table_name [ADD / DROP] [CONSTRAINT / INDEX] constraint_name
-- Drop a constraint / index
alter table Students drop constraint uc_rollno_email; 
-- Create the same thing again , we donot want to mess up things
alter table Students add constraint uc_rollno_email UNIQUE(Roll_no, Email);

## PRIMARY KEY ##
-- MySQL primary key is a single or combination of the field, which is used to identify each record in a table 
-- uniquely. If the column contains primary key constraints, then it cannot be null or empty. A table may have 
-- duplicate columns, but it can contain only one primary key. It always contains unique value into a column.
-- When you insert a new row into the table, the primary key column can also use the AUTO_INCREMENT attribute to
-- generate a sequential number for that row automatically. MySQL automatically creates an index named "Primary" 
-- after defining a primary key into the table. Since it has an associated index, we can say that the primary key 
-- makes the query performance fast.

alter table Students add constraint primary_key PRIMARY KEY AUTO_INCREMENT (Roll_no) ;
-- or we can also do this 
alter table Students add PRIMARY KEY AUTO_INCREMENT (Roll_no);   # Don't execute this if already executed above statement
-- The second one is a better method 
-- then we can drop primary key using the same
alter table Students drop primary key;				

-- There are some differences between the primary key and the unique key but its not that important now 

## FOREIGN KEY ##
-- The foreign key is used to link one or more than one table together. It is also known as the referencing key.
-- A foreign key matches the primary key field of another table. It means a foreign key field in one table refers
-- to the primary key field of the other table. It identifies each row of another table uniquely that maintains 
-- the referential integrity in MySQL.
-- A foreign key makes it possible to create a parent-child relationship with the tables. In this relationship, the 
-- parent table holds the initial column values, and column values of child table reference the parent column values. 
-- MySQL allows us to define a foreign key constraint on the child table.

# Syntax :
/* 
[CONSTRAINT constraint_name]  
    FOREIGN KEY [foreign_key_name] (col_name, ...)  
    REFERENCES parent_tbl_name (col_name,...)  
    ON DELETE referenceOption  
    ON UPDATE referenceOption  
*/
-- MySQL contains five different referential options, which are given below:
-- 1. CASCADE: It is used when we delete or update any row from the parent table, the values of the matching rows in the child table will be deleted or updated automatically.
-- 2. SET NULL: It is used when we delete or update any row from the parent table, the values of the foreign key columns in the child table are set to NULL.
-- 3. RESTRICT: It is used when we delete or update any row from the parent table that has a matching row in the reference(child) table, MySQL does not allow to delete or update rows in the parent table.
-- 4. NO ACTION: It is similar to RESTRICT. But it has one difference that it checks referential integrity after trying to modify the table.
-- 5. SET DEFAULT: The MySQL parser recognizes this action. However, the InnoDB and NDB tables both rejected this action.

-- NOTE: MySQL mainly provides full support to CASCADE, RESTRICT, and SET NULL actions. 
-- If we have not specified the ON DELETE and ON UPDATE clause, MySQL takes default action RESTRICT.

# Lets see one example where we will use CASCADE referential option for both Tables
CREATE TABLE customers (  
  ID INT NOT NULL AUTO_INCREMENT,  
  Name varchar(50) NOT NULL,  
  City varchar(50) NOT NULL,  
  PRIMARY KEY (ID)  									-- creating the primary key constraint (PARENT TABLE)
);  
CREATE TABLE orders (  
  ID INT,  
  Customer_Id INT,  
  order_type varchar(50) NOT NULL,  
  CONSTRAINT fk_customer FOREIGN KEY (Customer_Id)  	-- creating the foreign key constraint (CHILD TABLE)
  REFERENCES customers(ID)  
  ON DELETE CASCADE  
  ON UPDATE CASCADE  
);  

INSERT INTO customers (Name, City) VALUES 
('Alice', 'New York'),
('Bob', 'Los Angeles'),
('Charlie', 'Chicago'),
('David', 'Houston'),
('Eve', 'Phoenix');

INSERT INTO orders (ID, Customer_Id, order_type) VALUES 
(1, 1, 'Electronics'),
(2, 2, 'Furniture'),
(3, 1, 'Books'),
(4, 3, 'Clothing'),
(5, 4, 'Groceries'),
(6, 2, 'Automotive');

select * from customers;
select * from orders;

-- Lets test the delete and update CASCADE integrity
DELETE FROM customers WHERE ID = 1;
select * from orders;				# and yes it also deleted records of Customer_Id = 1 from orders table

UPDATE customers SET ID = 1 WHERE Name = "Bob";
select * from orders;				# and yes it also updated records of Customer_Id = 2 from orders table

# Also we cannot drop a parent table having relationship with a child table, but we can drop a child table  
DROP TABLE customers;			# error
DROP TABLE orders;				# no-errors :)

-- we can use alter table to add foreign key constraint after creating a table  (DONOT RUN THE BELOW QUERY)
ALTER TABLE orders ADD CONSTRAINT fk_customer  
FOREIGN KEY ( Customer_Id ) REFERENCES customers ( ID ) ON DELETE CASCADE ON UPDATE RESTRICT;  

-- MySQL has a special variable foreign_key_cheks to control the foreign key checking into the tables. By default,
-- it is enabled to enforce the referential integrity during the normal operation on the tables. 

/*
Sometimes there is a need for disabling the foreign key checking, which is very useful when:

1. We drop a table that is a reference by the foreign key.
2. We import data from a CSV file into a table. It speeds up the import operation.
3. We use ALTER TABLE statement on that table which has a foreign key.

*/

SET foreign_key_checks = 0;  # disable foreign_key_checks
SET foreign_key_checks = 1;  # enable foreign_key_checks

## COMPOSITE KEY ##
-- A composite key in MySQL is a combination of two or more than two columns in a table that allows us to identify each row of the table 
-- uniquely. It is a type of candidate key which is formed by more than one column. MySQL guaranteed the uniqueness of the column only
--  when they are combined. If they have taken individually, the uniqueness cannot maintain.
-- Any key such as primary key, super key, or candidate key can be called composite key when they have combined with more than one attribute.
CREATE TABLE Product (  
    Prod_ID int NOT NULL,   
    Name varchar(45),   
    Manufacturer varchar(45),  
    PRIMARY KEY(Name, Manufacturer)  
); 

-- HERE THE COMPOSITE KEY IS Name + Manufacturer . If both of them have same values in different rows then we connot insert it . Example :
INSERT INTO Product values 
(1, 'Soap', 'Lux'),  
(2, 'Shampoo', 'Clinic Plus'),  
(3, 'Shampoo', 'Tresme'), 
(3, 'Oil', 'Dabur Almond');  

-- But if we insert this we will get an error
INSERT INTO Product values  (5, 'Shampoo', 'Clinic Plus');

-- We can also add the composite key using the alter table . I am a bit tired of this seriously :|

## ALTERNATE KEY ##
-- An Alternate Key in a table is nothing but an alternative to the primary key in that table. In other words, they are candidate keys 
-- that are not currently selected as the primary key of a table (but has a potential to be one). Hence, they can also be used to uniquely
-- identify a tuple(or a record) in a table.
-- If a table consists of only one Candidate key that is treated as the primary key of the table, then there is no alternate key in that table.

/*
Features of Alternate Key :
1. The alternate key does not allow duplicate values.
2. A table can have more than one alternate keys.
3. The alternate key can contain NULL values unless the NOT NULL constraint is set explicitly.
4. All alternate keys can be candidate keys, but all candidate keys can not be alternate keys. As a primary key, which is also a
	candidate key, can not be considered as an alternate key.
*/

# Example :
CREATE TABLE Sales(
	Sales_Id INT PRIMARY KEY AUTO_INCREMENT,		# primary key
    Sale_Price DATE NOT NULL UNIQUE,				# alternate key
    Item_Name VARCHAR(50) NOT NULL
)